import psycopg2
import psycopg2.extras
import os

def update_ramo():
    config = {
        'host': os.environ.get('DB_HOST', 'localhost'),
        'user': os.environ.get('DB_FALLBACK_USER', 'appuser'),
        'password': os.environ.get('DB_FALLBACK_PASSWORD', 'changeme'),
        'dbname': os.environ.get('DB_NAME', 'brokerdb'),
        'port': int(os.environ.get('DB_PORT', 5432))
    }

    conn = None
    try:
        print("Conectando a la base de datos...")
        conn = psycopg2.connect(**config)

        cursor = conn.cursor()

        # Actualizar 'PERSONAS' a 'Persona'
        print("Analizando registros con Ramo 'PERSONAS'...")
        sql_personas = "UPDATE poliza SET Ramo = 'Persona' WHERE Ramo = 'PERSONAS'"
        cursor.execute(sql_personas)
        personas_updated = cursor.rowcount
        print(f"-> Se actualizaron {personas_updated} registros de 'PERSONAS' a 'Persona'.")

        # Actualizar 'AUTO' a 'Auto'
        print("Analizando registros con Ramo 'AUTO'...")
        sql_auto = "UPDATE poliza SET Ramo = 'Auto' WHERE Ramo = 'AUTO'"
        cursor.execute(sql_auto)
        auto_updated = cursor.rowcount
        print(f"-> Se actualizaron {auto_updated} registros de 'AUTO' a 'Auto'.")

        # Actualizar 'PATRIMONIAL' a 'Patrimonial'
        print("Analizando registros con Ramo 'PATRIMONIAL'...")
        sql_patrimonial = "UPDATE poliza SET Ramo = 'Patrimonial' WHERE Ramo = 'PATRIMONIAL'"
        cursor.execute(sql_patrimonial)
        patrimonial_updated = cursor.rowcount
        print(f"-> Se actualizaron {patrimonial_updated} registros de 'PATRIMONIAL' a 'Patrimonial'.")

        # Actualizar 'VIAJES' a 'Viaje'
        print("Analizando registros con Ramo 'VIAJES' a 'Viaje'")
        sql_viaje = "UPDATE poliza SET Ramo = 'Viaje' WHERE Ramo = 'VIAJES'"
        cursor.execute(sql_viaje)
        viaje_updated = cursor.rowcount
        print(f"-> Se actualizaron {viaje_updated} registros de 'VIAJES' A 'Viaje'.")

        conn.commit()
        print("Cambios guardados exitosamente en la base de datos.")

        # Actualizar 'FIANZAS' a 'Fianza'
        print("Analizando registros con Ramo 'FIANZAS' a 'Fianza'")
        sql_fianza = "UPDATE poliza SET Ramo = 'Fianza' WHERE Ramo = 'FIANZAS'"
        cursor.execute(sql_fianza)
        fianza_updated = cursor.rowcount
        print(f"-> Se actualizaron {fianza_updated} registros de 'FIANZAS' A 'Fianza'.")

        conn.commit()
        print("Cambios guardados exitosamente en la base de datos.")

    except psycopg2.Error as err:
        print(f"Error al conectar o actualizar la base de datos: {err}")
    finally:
        if conn:
            cursor.close()
            conn.close()
            print("Conexión cerrada.")

if __name__ == "__main__":
    update_ramo()
