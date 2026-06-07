
import psycopg2
import psycopg2.extras
import os

def get_db_connection():
    try:
        database_url = os.environ.get('DATABASE_URL')
        if database_url:
            if database_url.startswith('postgres://'):
                database_url = database_url.replace('postgres://', 'postgresql://', 1)
            connection = psycopg2.connect(database_url)
        else:
            connection = psycopg2.connect(
                host=os.environ.get('DB_HOST', 'localhost'),
                user=os.environ.get('DB_FALLBACK_USER', 'appuser'),
                password=os.environ.get('DB_FALLBACK_PASSWORD', 'changeme'),
                dbname=os.environ.get('DB_NAME', 'brokerdb'),
                port=int(os.environ.get('DB_PORT', 5432))
            )
        print("Conexión exitosa a la BD")
        return connection
    except psycopg2.Error as error:
        print(f"No se pudo conectar: {error}")
        return None

def populate_comisiones():
    datos_comisiones = {
        # --- MERCANTIL (SALUD) ---
        ('MERCANTIL', 'SALUD', 'PANAMA'): {'AGENTE': [0.15, 0.1], 'INTERMEDIO': [0.11, 0.075], 'REFERIDOR': [0.075, 0.05]},
        ('MERCANTIL', 'SALUD', '100K  200K'): {'AGENTE': [0.085, 0.085], 'INTERMEDIO': [0.06, 0.06], 'REFERIDOR': [0.04, 0.04]},
        ('MERCANTIL', 'SALUD', '5K  50K'): {'AGENTE': [0.035, 0.035], 'INTERMEDIO': [0.035, 0.035], 'REFERIDOR': [0.02, 0.02]},
        # --- MERCANTIL (AUTO) ---
        ('MERCANTIL', 'AUTO', 'CA / PT'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},

        # --- CARACAS (SALUD) ---
        ('CARACAS', 'SALUD', 'SALUD EXTERIOR'): {'AGENTE': [0.085, 0.085], 'INTERMEDIO': [0.06, 0.06], 'REFERIDOR': [0.04, 0.04]},
        ('CARACAS', 'SALUD', 'SALUD LOCAL'): {'AGENTE': [0.06, 0.06], 'INTERMEDIO': [0.045, 0.045], 'REFERIDOR': [0.03, 0.03]},
        ('CARACAS', 'SALUD', 'POLIZA INTERNACIONAL'): {'AGENTE': [0.15, 0.1], 'INTERMEDIO': [0.11, 0.075], 'REFERIDOR': [0.075, 0.05]},
        # --- CARACAS (PATRIMONIAL) ---
        ('CARACAS', 'PATRIMONIAL', 'COMBINADO EMPRESARIAL'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.1, 0.1], 'REFERIDOR': [0.075, 0.075]},
        ('CARACAS', 'PATRIMONIAL', 'COMBINADO RESIDENCIAL'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.1, 0.1], 'REFERIDOR': [0.075, 0.075]},
        # --- CARACAS (AP) ---
        ('CARACAS', 'AP', 'AP INDIVIDUAL'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.11, 0.11], 'REFERIDOR': [0.075, 0.075]},
        ('CARACAS', 'AP', 'AP COLECTIVO'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.11, 0.11], 'REFERIDOR': [0.075, 0.075]},
        ('CARACAS', 'AP', 'AP ESCOLAR'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.11, 0.11], 'REFERIDOR': [0.075, 0.075]},

        # --- PIRAMIDE (AUTO) ---
        ('PIRAMIDE', 'AUTO', 'CA / PT'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},
        # --- PIRAMIDE (SALUD) ---
        ('PIRAMIDE', 'SALUD', 'HCM'): {'AGENTE': [0.085, 0.085], 'INTERMEDIO': [0.06, 0.06], 'REFERIDOR': [0.04, 0.04]},

        # --- LA INTERNACIONAL (AUTO) ---
        ('LA INTERNACIONAL', 'AUTO', 'CA / PT'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},
        # --- LA INTERNACIONAL (SALUD) ---
        ('LA INTERNACIONAL', 'SALUD', 'CLASICO'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},
        ('LA INTERNACIONAL', 'SALUD', 'AÑOS PLATEADOS'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},
        ('LA INTERNACIONAL', 'SALUD', 'ZAFIRO / DIAMANTE'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.11, 0.11], 'REFERIDOR': [0.075, 0.075]},

        # --- UNIVERSITAS (AUTO) ---
        ('UNIVERSITAS', 'AUTO', 'CA / PT'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},
        # --- UNIVERSITAS (FUNERARIO) ---
        ('UNIVERSITAS', 'FUNERARIO', 'PLAN INDIVIDUAL'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},

        # --- ESTAR SEGUROS (PATRIMONIAL) ---
        ('ESTAR SEGUROS', 'PATRIMONIAL', 'COMBINADO EMPRESARIAL'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.1, 0.1], 'REFERIDOR': [0.075, 0.075]},
        ('ESTAR SEGUROS', 'PATRIMONIAL', 'COMBINADO RESIDENCIAL'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.1, 0.1], 'REFERIDOR': [0.075, 0.075]},
        # --- ESTAR SEGUROS (SALUD) ---
        ('ESTAR SEGUROS', 'SALUD', 'MEDICARE PLUS'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},
        ('ESTAR SEGUROS', 'SALUD', 'AFFINITY'): {'AGENTE': [0.09, 0.09], 'INTERMEDIO': [0.07, 0.07], 'REFERIDOR': [0.05, 0.05]},
        ('ESTAR SEGUROS', 'SALUD', 'ENFERMEDADES GRAVES'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},
        ('ESTAR SEGUROS', 'SALUD', 'FULL'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},
        ('ESTAR SEGUROS', 'SALUD', 'BASICO'): {'AGENTE': [0.07, 0.07], 'INTERMEDIO': [0.05, 0.05], 'REFERIDOR': [0.04, 0.04]},
        ('ESTAR SEGUROS', 'SALUD', 'FUNERARIO'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.1, 0.1], 'REFERIDOR': [0.075, 0.075]},

        # --- BANESCO (AUTO) ---
        ('BANESCO', 'AUTO', 'CA / PT'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},
        # --- BANESCO (FUNERARIO) ---
        ('BANESCO', 'FUNERARIO', 'PLAN INDIVIDUAL'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.1, 0.1], 'REFERIDOR': [0.075, 0.075]},

        # --- QUALITAS (SALUD) ---
        ('QUALITAS', 'SALUD', 'TU APOYO PREMIUM'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.11, 0.11], 'REFERIDOR': [0.075, 0.075]},
        ('QUALITAS', 'SALUD', 'HCM'): {'AGENTE': [0.085, 0.1], 'INTERMEDIO': [0.06, 0.075], 'REFERIDOR': [0.04, 0.04]},
        ('QUALITAS', 'SALUD', 'APS'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},

        # --- OCEANICA (SALUD) ---
        ('OCEANICA', 'SALUD', 'HCM INDIVIDUAL'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},

        # --- REAL SEGUROS (SALUD) ---
        ('REAL SEGUROS', 'SALUD', 'EMERGENCIAS MEDICAS'): {'AGENTE': [0.1, 0.1], 'INTERMEDIO': [0.075, 0.075], 'REFERIDOR': [0.05, 0.05]},
        ('REAL SEGUROS', 'SALUD', 'HCM'): {'AGENTE': [0.085, 0.085], 'INTERMEDIO': [0.06, 0.06], 'REFERIDOR': [0.04, 0.04]},
        # --- REAL SEGUROS (PATRIMONIAL) ---
        ('REAL SEGUROS', 'PATRIMONIAL', 'COMBINADO RESIDENCIAL'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.1, 0.1], 'REFERIDOR': [0.075, 0.075]},

        # --- UNISEGUROS (FUNERARIO) ---
        ('UNISEGUROS', 'FUNERARIO', 'PLAN INDIVIDUAL'): {'AGENTE': [0.12, 0.12], 'INTERMEDIO': [0.1, 0.1], 'REFERIDOR': [0.06, 0.06]},

        # --- VUMI (SALUD) ---
        ('VUMI', 'SALUD', 'ACCES-'): {'AGENTE': [0.15, 0.15], 'INTERMEDIO': [0.1, 0.1], 'REFERIDOR': [0.075, 0.075]},
    }

    connection = get_db_connection()
    if not connection:
        return

    try:
        with connection.cursor() as cursor:
            for key, value in datos_comisiones.items():
                compania, temp_subramo, producto = key

                subramo = temp_subramo
                if temp_subramo.upper() == 'SALUD':
                    ramo = 'PERSONA'
                else:
                    ramo = temp_subramo

                for tipo_ejecutivo, porcentajes in value.items():
                    porcentajes_str = ','.join(map(str, porcentajes))
                    sql = "INSERT INTO comisiones_config (compania, ramo, subramo, producto, tipo_ejecutivo, porcentajes) VALUES (%s, %s, %s, %s, %s, %s)"
                    val = (compania, ramo, subramo, producto, tipo_ejecutivo, porcentajes_str)
                    cursor.execute(sql, val)

            connection.commit()
            print(f"{cursor.rowcount} records inserted.")

    except psycopg2.Error as error:
        print(f"Failed to insert record into table: {error}")
    finally:
        connection.close()
        print("PostgreSQL connection is closed")

if __name__ == '__main__':
    populate_comisiones()
