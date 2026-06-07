import psycopg2
import psycopg2.extras
import os

def limpiar_bad_data():
    config = {
        'host': os.environ.get('DB_HOST', 'localhost'),
        'user': os.environ.get('DB_FALLBACK_USER', 'appuser'),
        'password': os.environ.get('DB_FALLBACK_PASSWORD', 'changeme'),
        'dbname': os.environ.get('DB_NAME', 'brokerdb'),
        'port': int(os.environ.get('DB_PORT', 5432))
    }

    conn = None
    try:
        conn = psycopg2.connect(**config)
        cursor = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        # 1. Buscar el ID de la compañía (Búsqueda flexible)
        busqueda = "ORANGE"
        cursor.execute("SELECT Cod_compania, Nombre FROM compania WHERE Nombre LIKE %s", (f"%{busqueda}%",))
        cias = cursor.fetchall()

        if not cias:
            print(f"No se encontró ninguna compañía con el nombre '{busqueda}'.")
            cursor.execute("SELECT Nombre FROM compania LIMIT 15")
            print("Algunas compañías en BD:", [c['Nombre'] for c in cursor.fetchall()])
            return

        print("\nCompañías encontradas:")
        for idx, c in enumerate(cias):
            print(f"{idx + 1}. {c['Nombre']} (ID: {c['Cod_compania']})")

        if len(cias) > 1:
            try:
                opcion = int(input("\nSeleccione el número de la compañía correcta: ")) - 1
                cia_seleccionada = cias[opcion]
            except:
                print("Opción inválida.")
                return
        else:
            cia_seleccionada = cias[0]

        cia_id = cia_seleccionada['Cod_compania']
        print(f"\nTrabajando con: {cia_seleccionada['Nombre']} (ID: {cia_id})")

        # 2. Identificar las pólizas a borrar
        cursor.execute("""
            SELECT cod_poliza, Ramo FROM poliza
            WHERE Cod_compania = %s
            AND (UPPER(Ramo) LIKE 'PERSONA%%' OR UPPER(Ramo) LIKE 'VIAJE%%')
        """, (cia_id,))
        polizas = cursor.fetchall()

        if not polizas:
            print("No se encontraron pólizas de Personas/Viaje para esta compañía.")
            return

        cod_polizas = [p['cod_poliza'] for p in polizas]
        print(f"Se encontraron {len(cod_polizas)} pólizas para borrar.")

        confirm_final = input(f"\n¿ESTÁ SEGURO de borrar estas {len(cod_polizas)} pólizas y todos sus pagos? (si/no): ")
        if confirm_final.lower() != 'si':
            print("Operación cancelada por el usuario.")
            return

        # 3. Borrar en orden jerárquico (evitando errores de FK)
        print("\nIniciando limpieza...")

        # a) Borrar Pagos (PostgreSQL-compatible subquery DELETE)
        print("- Eliminando pagos relacionados...")
        for cp in cod_polizas:
            cursor.execute("""
                DELETE FROM pago WHERE Cod_renovacion IN (
                    SELECT r.Cod_renovacion FROM renovacion r WHERE r.Cod_poliza = %s
                )
            """, (cp,))

        # b) Borrar Renovaciones
        print("- Eliminando renovaciones...")
        for cp in cod_polizas:
            cursor.execute("DELETE FROM renovacion WHERE Cod_poliza = %s", (cp,))

        # c) Borrar de tablas específicas de ramo
        print("- Eliminando registros en tablas de ramo (Persona/Auto/Viaje/Patrimonio)...")
        for cp in cod_polizas:
            cursor.execute("DELETE FROM Persona WHERE Cod_poliza = %s", (cp,))
            cursor.execute("DELETE FROM Auto WHERE Cod_poliza = %s", (cp,))
            cursor.execute("DELETE FROM viaje WHERE Cod_poliza = %s", (cp,))
            cursor.execute("DELETE FROM patrimonio WHERE Cod_poliza = %s", (cp,))

        # d) Finalmente las Pólizas
        print("- Eliminando pólizas principales...")
        for cp in cod_polizas:
            cursor.execute("DELETE FROM poliza WHERE cod_poliza = %s", (cp,))

        conn.commit()
        print("\n=== LIMPIEZA COMPLETADA CON ÉXITO ===")

    except Exception as e:
        print(f"\nError durante la limpieza: {e}")
        if conn:
            conn.rollback()
    finally:
        if conn:
            conn.close()

if __name__ == "__main__":
    limpiar_bad_data()
