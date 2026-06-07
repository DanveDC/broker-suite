import os
import psycopg2
import psycopg2.extras

from app import app
from flask import render_template, request, flash, redirect, url_for, session

# Importando mi conexión a BD
from conexion.conexionBD import connectionBD

# Para encriptar contraseña generate_password_hash
from werkzeug.security import check_password_hash

# Importando controllers para el modulo de login
from controllers.funciones_login import *
PATH_URL_LOGIN = "public/login"


@app.route('/', methods=['GET'])
def inicio():
    if 'conectado' in session:
        return render_template('public/base_cpanel.html', dataLogin=dataLoginSesion())
    else:
        return render_template(f'{PATH_URL_LOGIN}/base_login.html')


@app.route('/mi-perfil', methods=['GET'])
def perfil():
    if 'conectado' in session:
        return render_template(f'public/perfil/perfil.html', info_perfil_session=info_perfil_session())
    else:
        return redirect(url_for('inicio'))


# Crear cuenta de usuario
@app.route('/register-user', methods=['GET'])
def cpanelRegisterUser():
    if 'conectado' in session:
        return redirect(url_for('inicio'))
    else:
        return render_template(f'{PATH_URL_LOGIN}/auth_register.html')


# Recuperar cuenta de usuario
@app.route('/recovery-password', methods=['GET', 'POST'])
def cpanelRecoveryPassUser():
    if 'conectado' in session:
        return redirect(url_for('inicio'))

    if request.method == 'POST':
        email_user = request.form['email_user']
        token = solicitar_recuperacion(email_user)

        if token:
            link = url_for('cpanelResetPassword', token=token, _external=True)
            
            # --- ENVÍO DE CORREO REAL CON OUTLOOK ---
            try:
                import smtplib
                from email.mime.text import MIMEText
                from email.mime.multipart import MIMEMultipart

                # SMTP credentials from environment variables
                sender_email = os.environ.get('SMTP_EMAIL', '')
                password = os.environ.get('SMTP_PASSWORD', '')

                # Configuración del mensaje
                message = MIMEMultipart("alternative")
                message["Subject"] = "Recuperación de Contraseña - BrokerCore"
                message["From"] = f"BrokerCore <{sender_email}>"
                message["To"] = email_user

                # Cuerpo del correo en HTML
                html = f"""
                <html>
                  <body>
                    <h2>Hola,</h2>
                    <p>Has solicitado restablecer tu contraseña en BrokerCore.</p>
                    <p>Haz clic en el siguiente enlace para crear una nueva contraseña:</p>
                    <a href="{link}" style="background-color: #696cff; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">
                        Restablecer Contraseña
                    </a>
                    <p>Si no solicitaste esto, ignora este mensaje.</p>
                    <p><small>Este enlace expirará en 1 hora.</small></p>
                  </body>
                </html>
                """
                parte_html = MIMEText(html, "html")
                message.attach(parte_html)

                # Conexión al servidor SMTP
                smtp_server = os.environ.get('SMTP_SERVER', 'smtp.gmail.com')
                smtp_port = int(os.environ.get('SMTP_PORT', 587))
                server = smtplib.SMTP(smtp_server, smtp_port)
                server.starttls() # Seguridad
                server.login(sender_email, password)
                server.sendmail(sender_email, email_user, message.as_string())
                server.quit()

                # flash('Se ha enviado un correo con las instrucciones a tu dirección.', 'success') 
                print(f"Correo enviado exitosamente a {email_user}")

            except Exception as e:
                print(f"Error al enviar correo: {e}")
                flash(f'Error al enviar el correo: {e}', 'error')
                # Fallback para pruebas si falla el correo
                print(f"LINK DE RESPALDO: {link}")

        else:
            # Por seguridad, no decimos si el correo existe o no
            # flash('Si el correo existe, recibirás un enlace de recuperación.', 'success')
            pass
            
        # SIEMPRE mostramos la pantalla de confirmación para evitar enumeración de usuarios
        return render_template(f'{PATH_URL_LOGIN}/auth_email_sent.html', email_user=email_user)

    return render_template(f'{PATH_URL_LOGIN}/auth_forgot_password.html')


@app.route('/reset-password/<token>', methods=['GET', 'POST'])
def cpanelResetPassword(token):
    if 'conectado' in session:
        return redirect(url_for('inicio'))

    email_user = validar_token(token)
    if not email_user:
        flash('El enlace es inválido o ha expirado.', 'error')
        return redirect(url_for('cpanelRecoveryPassUser'))

    if request.method == 'POST':
        pass_user = request.form['pass_user']
        repetir_pass_user = request.form['repetir_pass_user']
        
        resultado = procesar_reset_password(token, pass_user, repetir_pass_user)
        
        if resultado['success']:
            flash(resultado['message'], 'success')
            return redirect(url_for('loginCliente'))
        else:
            flash(resultado['message'], 'error')
            return render_template(f'{PATH_URL_LOGIN}/auth_reset_password.html', token=token)

    return render_template(f'{PATH_URL_LOGIN}/auth_reset_password.html', token=token)


# Crear cuenta de usuario
@app.route('/saved-register', methods=['POST'])
def cpanelResgisterUserBD():
    if request.method == 'POST' and 'name_surname' in request.form and 'pass_user' in request.form:
        name_surname = request.form['name_surname']
        email_user = request.form['email_user']
        pass_user = request.form['pass_user']
        permisos = request.form['permisos']
        print('perro')
        resultData = recibeInsertRegisterUser(
            name_surname, email_user, pass_user,permisos)
        if resultData.get('success'):
            flash(resultData.get('message'), 'success')
            return redirect(url_for('inicio'))
        else:
            flash(resultData.get('message'), 'error')
            return redirect(url_for('inicio'))
    else:
        flash('el método HTTP es incorrecto', 'error')
        return redirect(url_for('inicio'))


# Actualizar datos de mi perfil
@app.route("/actualizar-datos-perfil", methods=['POST'])
def actualizarPerfil():
    if request.method == 'POST': 
        if 'conectado' in session:
            respuesta = procesar_update_perfil(request.form) 
            
            # --- CAMBIO AQUI ---
            if isinstance(respuesta, dict): # Si la respuesta es un diccionario (errores de DB/inesperados)
                flash(respuesta.get('message', 'Ocurrió un error inesperado al actualizar el perfil.'), 'error')
                return redirect(url_for('perfil'))
            # --- FIN CAMBIO ---

            # Manejo de respuestas numéricas existentes
            elif respuesta == 1:
                flash('Los datos fueron actualizados correctamente.', 'success')
                return redirect(url_for('perfil'))
            elif respuesta == 4:
                flash(
                    'La contraseña actual está incorrecta, por favor verifique.', 'error') # Ajusta mensaje para incluir usuario no encontrado
                return redirect(url_for('perfil'))
            elif respuesta == 2:
                flash('Ambas claves deben ser iguales, por favor verifique.', 'error')
                return redirect(url_for('perfil'))
            elif respuesta == 3:
                flash('La Clave actual es obligatoria.', 'error')
                return redirect(url_for('perfil'))
        else:
            flash('Primero debes iniciar sesión.', 'error')
            return redirect(url_for('inicio'))
    else:
        flash('Primero debes iniciar sesión.', 'error') # Esto se ejecuta si no es POST
        return redirect(url_for('inicio'))


# Validar sesión
@app.route('/login', methods=['GET', 'POST'])
def loginCliente():
    if 'conectado' in session:
        return redirect(url_for('inicio'))
    else: 
                if request.method == 'POST':
                    if 'email_user' in request.form and 'pass_user' in request.form:
                        # ... lógica de login ...
                        email_user = str(request.form['email_user'])
                        pass_user = str(request.form['pass_user'])

                        # Comprobando si existe una cuenta
                        conexion_MySQLdb = connectionBD()
                        cursor = conexion_MySQLdb.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
                        cursor.execute(
                            "SELECT * FROM users WHERE email_user = %s", [email_user])
                        account = cursor.fetchone()

                        if account:
                            if check_password_hash(account['pass_user'], pass_user):
                                # Crear datos de sesión
                                session['conectado'] = True
                                session['id'] = account['id']
                                session['name_surname'] = account['name_surname']
                                session['email_user'] = account['email_user']
                                session['permisos'] = account['permisos']
                                flash('la sesión fue correcta.', 'success')
                                return redirect(url_for('inicio1'))
                            else:
                                flash('datos incorrectos por favor revise.', 'error')
                                return render_template(f'{PATH_URL_LOGIN}/base_login.html')
                        else:
                            flash('el usuario no existe, por favor verifique.', 'error')
                            return render_template(f'{PATH_URL_LOGIN}/base_login.html')
                    else:
                         flash('por favor llene los campos.', 'error')
                         return render_template(f'{PATH_URL_LOGIN}/base_login.html')
                else:
                    return render_template(f'{PATH_URL_LOGIN}/base_login.html')


@app.route('/closed-session',  methods=['GET'])
def cerraSesion():
    if request.method == 'GET':
        if 'conectado' in session:
            # Eliminar datos de sesión, esto cerrará la sesión del usuario
            session.pop('conectado', None)
            session.pop('id', None)
            session.pop('name_surname', None)
            session.pop('email', None)
            session.pop('pass', None)
            flash('tu sesión fue cerrada correctamente.', 'success')
            return redirect(url_for('inicio1'))
        else:
            flash('recuerde debe iniciar sesión.', 'error')
            return render_template(f'{PATH_URL_LOGIN}/base_login.html')
