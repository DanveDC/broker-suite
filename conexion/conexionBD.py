import os
import psycopg2
import psycopg2.extras
from urllib.parse import urlparse


def connectionBD():
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

        connection.autocommit = False
        print("Conexión exitosa a la BD")
        return connection

    except psycopg2.Error as error:
        print(f"No se pudo conectar: {error}")
        raise error
