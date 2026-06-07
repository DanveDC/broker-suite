import pandas as pd
import psycopg2
import psycopg2.extras
import os
import sys

def update_ejecutivos():
    # MAPPING: Nombre del Referidor en Excel -> Cod_ejecutivo en la Base de Datos
    MAPPING_REFERIDORES = {
        # === IDENTIFICADOS EN LA NUEVA IMAGEN ===
        'PATRICIA COHEN': 4,
        'ROBERT VELASQUEZ': 5,
        'CABAL': 6,
        'MISHEL MARTINEZ': 7,
        'WILLIAMS MORENO': 8,
        'ISMAEL GONZALEZ': 9,
        'RAFAEL TOBIAS SALAZAR': 10,
        'CAROLINA LUZARDO': 11,
        'GUIDO LAMANNA': 12,
        'KAAREN BRICEÑO': 13,
        'SHARON GONZALEZ': 14,
        'OTTAVIO MAGNI': 15,
        'JOSE SAADE': 16,
        'GUSTAVO BERGSTROM': 17,
        'OFICINA CABAL': 18,
        'IG VENTAS': 19,
        'IG MERCADEO': 20,
        'RCV_3EROS': 21,
        'IRENE BERGSTROM': 22,
        'VALDEMAR NAVAS': 23,
        'ROSA GOMEZ': 24,
        'RODOLFO REINMMAS': 25,
        'LEOPOLDO GORDILS': 26,
        'MARZZIA TORREALBA': 27,
        'ORIANA ALVAREZ': 28,

        # === NO ENCONTRADOS EN ESTA IMAGEN / OTROS ===
        'SARAHI MIJARES': 29,
        'SHEMIL GONZALEZ': 31,
        'LUIS PULIDO': 32,
        'LESLIE RODRIGUEZ': 33,
        'NANCY HERNANDEZ': 34,
        'ALEJANDRO CARRILLO': 35,
        'CARLOS MACHADO': 36,
        'CRISTINA COHEN': 37,
        'ENGEL MORENO': 38,
        'JOSENI MACHADO': 39,
        'JUAN RAMIREZ': 40,
        'ROMER ORONO': 41,
        'WILMER RAMOS': 42,
        'JHOAN ORTEGA': 43,
        'NELSON RODRIGUEZ': 44,
        'EVELYN ABACHE': 45,
        'AURELIX MOLINA': 46,
        'WILLIAM CASTRO': 47,
        'EDUARDO GARCIA': 48,
        'REYNA DA COSTA': 49,
        'SOLUCIONES PURE CLEAN 77': 50,
        'JESUS QUERO': 51,
        'RUBEN BECERRA': 52
    }

    # Ruta del archivo Excel
    script_dir = os.path.dirname(os.path.abspath(__file__))
    excel_path = os.path.join(script_dir, '..', 'excel', 'Matriz Corte.xlsx')

    if not os.path.exists(excel_path):
        print(f"Error: No se encontró el archivo Excel en: {excel_path}")
        return

    print(f"Leyendo Excel: {excel_path}...")
    try:
        df = pd.read_excel(excel_path)
    except Exception as e:
        print(f"Error al leer el Excel: {e}")
        return

    # Configuración de la base de datos
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

        updates_performed = 0
        skipped_no_mapping = 0
        records_found = 0
        errors = 0

        print("Procesando registros...")

        for index, row in df.iterrows():
            ci_excel = row.get('ID')
            referidor_name = row.get('REFERIDOR')

            if pd.isna(ci_excel) or pd.isna(referidor_name):
                continue

            try:
                if isinstance(ci_excel, float):
                    ci_clean = int(ci_excel)
                else:
                    ci_clean = int(str(ci_excel).strip())
            except:
                ci_clean = str(ci_excel).strip()

            ref_name_str = str(referidor_name).strip().upper()

            referidor_code = None
            for key, value in MAPPING_REFERIDORES.items():
                if key.upper() == ref_name_str:
                    referidor_code = value
                    break

            if referidor_code is None:
                skipped_no_mapping += 1
                continue

            records_found += 1

            try:
                sql = "UPDATE asegurado SET Ejecutivo = %s WHERE CI = %s"
                cursor.execute(sql, (referidor_code, ci_clean))
                if cursor.rowcount > 0:
                    updates_performed += 1
            except Exception as e:
                print(f"Error al actualizar CI {ci_clean}: {e}")
                errors += 1

        conn.commit()

        print("\n" + "="*40)
        print("          RESUMEN DEL PROCESO")
        print("="*40)
        print(f"Total registros con datos válidos en Excel: {records_found + skipped_no_mapping}")
        print(f"Registros con código asignado (Mapping):   {records_found}")
        print(f"Registros actualizados en BD:              {updates_performed}")
        print(f"Registros saltados (sin código definido):  {skipped_no_mapping}")
        print(f"Errores en ejecución:                      {errors}")
        print("="*40)

        if skipped_no_mapping > 0:
            print("\nNOTA: Para los registros saltados, asegúrate de llenar el MAPPING_REFERIDORES")
            print("en el código del script con los IDs numéricos correspondientes.")

    except psycopg2.Error as err:
        print(f"Error crítico de base de datos: {err}")
    except Exception as e:
        print(f"Error inesperado: {e}")
    finally:
        if conn:
            cursor.close()
            conn.close()
            print("\nConexión cerrada.")

if __name__ == "__main__":
    update_ejecutivos()
