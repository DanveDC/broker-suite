import os
from dotenv import load_dotenv
from flask import Flask, jsonify

load_dotenv()

app = Flask(__name__)
application = app
app.secret_key = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')


@app.route('/setup-admin')
def setup_admin():
    from conexion.conexionBD import connectionBD
    try:
        conn = connectionBD()
        cursor = conn.cursor()
        cursor.execute(
            "SELECT COUNT(*) AS count FROM users WHERE email_user = %s",
            ['admin@gmail.com']
        )
        row = cursor.fetchone()
        count = row['count'] if row else 0
        if count == 0:
            cursor.execute(
                "INSERT INTO users (name_surname, email_user, pass_user, permisos) VALUES (%s, %s, %s, %s)",
                ['Admin', 'admin@gmail.com', 'admin', 'admin']
            )
            conn.commit()
            msg = 'Usuario admin creado correctamente'
        else:
            msg = 'El usuario admin ya existe'
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'message': msg})
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500
