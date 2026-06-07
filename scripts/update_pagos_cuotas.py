import sys
import os
import psycopg2
import psycopg2.extras

def update_cuotas_db():
    print("--- Actualizando BD ---")
    config = {
        'host': os.environ.get('DB_HOST', 'localhost'),
        'user': os.environ.get('DB_FALLBACK_USER', 'appuser'),
        'password': os.environ.get('DB_FALLBACK_PASSWORD', 'changeme'),
        'dbname': os.environ.get('DB_NAME', 'brokerdb'),
        'port': int(os.environ.get('DB_PORT', 5432))
    }
    try:
        connection = psycopg2.connect(**config)

        with connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            # Obtener todas las renovaciones que tienen pagos
            cursor.execute("SELECT DISTINCT Cod_renovacion FROM pago WHERE Cod_renovacion IS NOT NULL")
            renovaciones = cursor.fetchall()

            print(f"Encontradas {len(renovaciones)} renovaciones con pagos.")

            count_updated = 0
            for ren in renovaciones:
                cod_ren = ren['Cod_renovacion']

                # Obtener pagos ordenados por fecha para esta renovación
                cursor.execute("SELECT Cod_pago, fecha FROM pago WHERE Cod_renovacion = %s ORDER BY fecha ASC", (cod_ren,))
                pagos = cursor.fetchall()

                # Asignar nro_cuota secuencial (1, 2, 3...)
                for index, pago in enumerate(pagos):
                    nuevo_nro = index + 1
                    sql_update = "UPDATE pago SET nro_cuota = %s WHERE Cod_pago = %s"
                    cursor.execute(sql_update, (nuevo_nro, pago['Cod_pago']))
                    count_updated += 1

            connection.commit()
            print(f"Proceso finalizado. {count_updated} pagos verificados/actualizados.\n")

        connection.close()

    except psycopg2.Error as error:
        print(f"Error conectando a la BD: {error}")
    except Exception as e:
        print(f"Error general: {e}")

if __name__ == "__main__":
    update_cuotas_db()
