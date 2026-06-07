# Importandopaquetes desde flask
from flask import session, flash

# Importando conexion a BD
from conexion.conexionBD import connectionBD
# Para  validar contraseña
from werkzeug.security import check_password_hash

import os
import re
from werkzeug.security import generate_password_hash

import datetime
import uuid


def solicitar_recuperacion(email_user):
    """
    Genera un token de recuperación y lo guarda en la BD.
    Retorna el token si el usuario existe, None si no.
    """
    token = str(uuid.uuid4())

    try:
        conexion = connectionBD()
        if not conexion:
            return None

        with conexion:
            with conexion.cursor() as cursor:
                cursor.execute("SELECT id FROM users WHERE email_user = %s", (email_user,))
                user = cursor.fetchone()

                if not user:
                    return None

                cursor.execute(
                    "DELETE FROM password_resets WHERE email_user = %s AND created_at < NOW() - INTERVAL '1 hour'",
                    (email_user,)
                )
                cursor.execute(
                    "INSERT INTO password_resets (email_user, token, created_at) VALUES (%s, %s, NOW())",
                    (email_user, token)
                )
                conexion.commit()
                print(f"Token generado para {email_user}")
                return token

    except Exception as e:
        print(f"Error en solicitar_recuperacion: {e}")
        return None


def validar_token(token):
    """
    Verifica si un token es válido (existe y no expiró).
    Retorna el email del usuario si es válido, None si no.
    """
    try:
        conexion = connectionBD()
        if not conexion:
            return None

        with conexion:
            with conexion.cursor() as cursor:
                cursor.execute(
                    "SELECT email_user, created_at FROM password_resets WHERE token = %s",
                    (token,)
                )
                result = cursor.fetchone()

                if not result:
                    return None

                now = datetime.datetime.now()
                created_at = result['created_at']
                if isinstance(created_at, str):
                    created_at = datetime.datetime.strptime(created_at, '%Y-%m-%d %H:%M:%S')

                if now - created_at <= datetime.timedelta(hours=1):
                    return result['email_user']

    except Exception as e:
        print(f"Error en validar_token: {e}")

    return None


def procesar_reset_password(token, new_pass, repetir_pass):
    if new_pass != repetir_pass:
        return {"success": False, "message": "Las contraseñas no coinciden."}

    email_user = validar_token(token)
    if not email_user:
        return {"success": False, "message": "El enlace de recuperación es inválido o ha expirado."}

    try:
        conexion = connectionBD()
        if not conexion:
            return {"success": False, "message": "No se pudo conectar a la base de datos."}

        with conexion:
            with conexion.cursor() as cursor:
                nueva_password_app = generate_password_hash(new_pass)
                cursor.execute(
                    "UPDATE users SET pass_user = %s WHERE email_user = %s",
                    (nueva_password_app, email_user)
                )

                cursor.execute(
                    "DELETE FROM password_resets WHERE email_user = %s",
                    (email_user,)
                )
                conexion.commit()
                print(f"Contraseña actualizada para {email_user}")
                return {"success": True, "message": "Contraseña actualizada exitosamente."}

    except Exception as e:
        print(f"Error en procesar_reset_password: {e}")
        return {"success": False, "message": "No se pudo actualizar la contraseña. Intente nuevamente."}

def recibeInsertRegisterUser(name_surname, email_user, pass_user, permisos):
    respuestaValidar = validarDataRegisterLogin(name_surname, email_user, pass_user)

    if not respuestaValidar:
        return {"success": False, "message": "Datos de registro inválidos."}

    nueva_password = generate_password_hash(pass_user, method='scrypt')

    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor() as mycursor:
                # 1. Verificar si el usuario ya existe en la tabla 'users'
                mycursor.execute(
                    "SELECT COUNT(*) AS count FROM users WHERE email_user = %s",
                    (email_user,)
                )
                if mycursor.fetchone()['count'] > 0:
                    return {"success": False, "message": "Ya existe un usuario registrado con este correo electrónico."}

                # 2. Insertar en la tabla de usuarios de la aplicación
                mycursor.execute(
                    "INSERT INTO users(name_surname, email_user, pass_user, permisos) VALUES (%s, %s, %s, %s)",
                    (name_surname, email_user, nueva_password, permisos)
                )
                conexion_MySQLdb.commit()
                return {"success": True, "message": "Usuario registrado exitosamente."}

    except Exception as e:
        print(f"Error al crear usuario: {e}")
        return {"success": False, "message": f"Error interno al registrar el usuario: {e}"}


# Validando la data del Registros para el login
def validarDataRegisterLogin(name_surname, email_user, pass_user):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor() as cursor:
                querySQL = "SELECT * FROM users WHERE email_user = %s"
                cursor.execute(querySQL, (email_user,))
                userBD = cursor.fetchone()  # Obtener la primera fila de resultados

                if userBD is not None:
                    flash('el registro no fue procesado ya existe la cuenta', 'error')
                    return False
                elif not re.match(r'[^@]+@[^@]+\.[^@]+', email_user):
                    flash('el Correo es invalido', 'error')
                    return False
                elif not name_surname or not email_user or not pass_user:
                    flash('por favor llene los campos del formulario.', 'error')
                    return False
                else:
                    # La cuenta no existe y los datos del formulario son válidos, puedo realizar el Insert
                    return True
    except Exception as e:
        print(f"Error en validarDataRegisterLogin : {e}")
        return []


def info_perfil_session():
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor() as cursor:
                querySQL = "SELECT name_surname, email_user, permisos FROM users WHERE id = %s"
                cursor.execute(querySQL, (session['id'],))
                info_perfil = cursor.fetchone()
        return info_perfil
    except Exception as e:
        print(f"Error en info_perfil_session : {e}")
        return []


def procesar_update_perfil(data_form):
    # Extraer datos del diccionario data_form
    id_user = data_form.get('id', session.get('id')) # Usa .get para seguridad y session si no viene en form
    name_surname = data_form['name_surname']
    email_user = data_form['email_user']
    pass_actual = data_form['pass_actual']
    new_pass_user = data_form['new_pass_user']
    repetir_pass_user = data_form['repetir_pass_user']

    if not pass_actual or not email_user:
        return 3 # Código de error: campos obligatorios vacíos

    try:
        with connectionBD() as conexion_MySQLdb: # Primera y ÚNICA conexión
            with conexion_MySQLdb.cursor() as cursor:
                # 1. Obtener la cuenta para verificar la contraseña actual
                querySQL = """SELECT * FROM users WHERE id = %s LIMIT 1""" # Mejor buscar por ID si ya lo tienes en session
                cursor.execute(querySQL, (id_user,))
                account = cursor.fetchone()

                if account: # Si se encuentra el usuario en tu tabla 'users'
                    # Asegúrate de que el email_user del formulario coincida con el de la DB para evitar suplantación
                    if account['email_user'] != email_user:
                        return {"success": False, "message": "El correo electrónico no coincide con el usuario autenticado."}

                    # 2. Verificar la contraseña actual
                    if check_password_hash(account['pass_user'], pass_actual):

                        # Determinar si se actualiza la contraseña
                        if not new_pass_user or not repetir_pass_user:
                            # Caso 1: Actualizar perfil SIN cambiar contraseña
                            return updatePefilSinPass(id_user, name_surname)
                        else:
                            # Caso 2: Actualizar perfil Y cambiar contraseña
                            if new_pass_user != repetir_pass_user:
                                return 2 # Código de error: contraseñas nuevas no coinciden
                            else:
                                try:
                                    # Generar hash para la nueva contraseña de la aplicación
                                    nueva_password_app = generate_password_hash(new_pass_user, method='scrypt')

                                    # Actualizar la contraseña en la tabla 'users' de la aplicación
                                    querySQL_update_app = """
                                        UPDATE users
                                        SET
                                            name_surname = %s,
                                            pass_user = %s
                                        WHERE id = %s
                                    """
                                    params_app = (name_surname, nueva_password_app, id_user)
                                    cursor.execute(querySQL_update_app, params_app)

                                    conexion_MySQLdb.commit()
                                    return 1 # Devuelve el número de filas afectadas (1 si fue exitoso)

                                    print(f"Error en el UPDATE de procesar_update_perfil: {e}")
                                    conexion_MySQLdb.rollback() # Deshacer si hay un error en la DB
                                    return {"success": False, "message": f"Error al actualizar la base de datos: {e}"}
                                except Exception as e: # Captura cualquier otro tipo de error
                                    print(f"Ocurrió un error inesperado en procesar_update_perfil: {e}")
                                    conexion_MySQLdb.rollback() # Deshacer si hay un error inesperado
                                    return {"success": False, "message": f"Error inesperado al actualizar: {e}"}
                    else:
                        return 4 # Código de error: contraseña actual incorrecta
                else:
                    return 0 # Código de error: usuario no encontrado (debería ser raro si se usa session['id'])
    except Exception as e:
        print(f"Error de conexión en procesar_update_perfil: {e}")
        return {"success": False, "message": f"Error de conexión a la base de datos: {e}"}
    except Exception as e:
        print(f"Ocurrió un error general en procesar_update_perfil: {e}")
        return {"success": False, "message": f"Error general inesperado: {e}"}




def updatePefilSinPass(id_user, name_surname):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor() as cursor:
                querySQL = """
                    UPDATE users
                    SET
                        name_surname = %s
                    WHERE id = %s
                """
                params = (name_surname, id_user)
                cursor.execute(querySQL, params)
                conexion_MySQLdb.commit()
                print(cursor.rowcount)
        return 1
    except Exception as e:
        print(f"Ocurrió un error en la funcion updatePefilSinPass: {e}")
        return []


def dataLoginSesion():
    inforLogin = {
        "id": session['id'],
        "name_surname": session['name_surname'],
        "email_user": session['email_user']
    }
    return inforLogin
