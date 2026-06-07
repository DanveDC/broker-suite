import psycopg2
import psycopg2.extras
import os

def setup_db():
    config = {
        'host': os.environ.get('DB_HOST', 'localhost'),
        'user': os.environ.get('DB_FALLBACK_USER', 'appuser'),
        'password': os.environ.get('DB_FALLBACK_PASSWORD', 'changeme'),
        'dbname': os.environ.get('DB_NAME', 'brokerdb'),
        'port': int(os.environ.get('DB_PORT', 5432))
    }
    try:
        connection = psycopg2.connect(**config)
        cursor = connection.cursor()
        # Crear la tabla si no existe
        create_sql = """
        CREATE TABLE IF NOT EXISTS bloque_pago_comision (
            id_bloque SERIAL PRIMARY KEY,
            numero_egreso VARCHAR(100),
            referencia_bancaria VARCHAR(100),
            fecha_movimiento DATE,
            fecha_creacion TIMESTAMP,
            monto_total DOUBLE PRECISION DEFAULT 0,
            compania VARCHAR(100)
        )
        """
        cursor.execute(create_sql)

        # Intentar agregar la columna monto_total por si la tabla ya existía pero sin ella
        try:
            cursor.execute('ALTER TABLE bloque_pago_comision ADD COLUMN monto_total DOUBLE PRECISION DEFAULT 0')
        except:
            pass

        connection.commit()
        print('Tabla bloque_pago_comision configurada')
        connection.close()
    except Exception as e:
        print(f'Error configurando la BD: {e}')

setup_db()
