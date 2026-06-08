import os
from dotenv import load_dotenv
from flask import Flask, jsonify

load_dotenv()

app = Flask(__name__)
application = app
app.secret_key = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')


@app.route('/fix-schema2')
def fix_schema2():
    from conexion.conexionBD import connectionBD
    MIGRATIONS = [
        "ALTER TABLE renovacion ADD COLUMN IF NOT EXISTS estado VARCHAR(50)",
        "ALTER TABLE renovacion ADD COLUMN IF NOT EXISTS Ejecutivo INT",
        "ALTER TABLE renovacion ADD COLUMN IF NOT EXISTS fecha_registro TIMESTAMP DEFAULT NOW()",
        "ALTER TABLE polizas_pendientes ADD COLUMN IF NOT EXISTS fecha_registro TIMESTAMP DEFAULT NOW()",
        "ALTER TABLE comision ADD COLUMN IF NOT EXISTS cod_poliza VARCHAR(100)",
    ]
    try:
        conn = connectionBD()
        conn.autocommit = True
        cursor = conn.cursor()
        results = []
        for sql in MIGRATIONS:
            try:
                cursor.execute(sql)
                results.append({'sql': sql[:60], 'status': 'ok'})
            except Exception as e:
                results.append({'sql': sql[:60], 'status': 'error', 'error': str(e)})
        cursor.close()
        conn.close()
        errors = [r for r in results if r['status'] == 'error']
        return jsonify({'status': 'ok', 'total': len(MIGRATIONS), 'errors': errors})
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500
