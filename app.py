import os
from dotenv import load_dotenv
from flask import Flask, jsonify

load_dotenv()

app = Flask(__name__)
application = app
app.secret_key = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')


@app.route('/fix-admin-pass')
def fix_admin_pass():
    from conexion.conexionBD import connectionBD
    from werkzeug.security import generate_password_hash
    try:
        conn = connectionBD()
        cursor = conn.cursor()
        hashed = generate_password_hash('admin')
        cursor.execute(
            "UPDATE users SET pass_user = %s WHERE email_user = %s",
            [hashed, 'admin@gmail.com']
        )
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'message': 'Password actualizado con hash correcto'})
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500
