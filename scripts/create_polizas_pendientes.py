import psycopg2
import psycopg2.extras
import sys
import os

# Agregamos el directorio padre al path para poder importar módulos de la app si fuera necesario
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

def create_table_polizas_pendientes():
    config = {
        'user': os.environ.get('DB_FALLBACK_USER', 'appuser'),
        'password': os.environ.get('DB_FALLBACK_PASSWORD', 'changeme'),
        'host': os.environ.get('DB_HOST', 'localhost'),
        'dbname': os.environ.get('DB_NAME', 'brokerdb'),
        'port': int(os.environ.get('DB_PORT', 5432))
    }

    try:
        connection = psycopg2.connect(**config)
        cursor = connection.cursor()

        print("--- Procesando base de datos ---")
        try:
            # Crear la tabla si no existe
            create_table_query = """
            CREATE TABLE IF NOT EXISTS polizas_pendientes (
                id SERIAL PRIMARY KEY,
                nro_poliza VARCHAR(100),
                nro_recibo VARCHAR(100),
                nombre_cliente VARCHAR(255),
                monto_prima DECIMAL(15, 2),
                monto_comision DECIMAL(15, 2),
                porcentaje_comision DECIMAL(5, 2),
                fecha_cobro DATE,
                compania VARCHAR(100),
                descripcion TEXT,
                moneda VARCHAR(50),
                tasa DECIMAL(15, 4),
                monto_pagado DECIMAL(15, 2),
                id_bloque INT,
                fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                estado VARCHAR(50) DEFAULT 'PENDIENTE'
            );
            """
            cursor.execute(create_table_query)
            connection.commit()
            print("Tabla 'polizas_pendientes' verificada/creada exitosamente.")

        except psycopg2.Error as err:
            print(f"Error procesando: {err}")
            connection.rollback()

    except psycopg2.Error as err:
        print(f"Error de conexión general: {err}")
    finally:
        if 'connection' in locals():
            cursor.close()
            connection.close()
            print("Conexión cerrada.")

if __name__ == "__main__":
    create_table_polizas_pendientes()
