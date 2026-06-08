import os
import ssl
from urllib.parse import urlparse
import mysql.connector


class MysqlDictConnection:
    """Wraps mysql.connector connection to always return dict cursors."""

    def __init__(self, conn):
        self._conn = conn

    def cursor(self, cursor_factory=None, dictionary=None):
        return self._conn.cursor(dictionary=True)

    def commit(self):
        self._conn.commit()

    def rollback(self):
        self._conn.rollback()

    def close(self):
        self._conn.close()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if exc_type:
            try:
                self.rollback()
            except Exception:
                pass
        self.close()


def connectionBD():
    try:
        database_url = os.environ.get('DATABASE_URL') or os.environ.get('MYSQL_URL')

        if database_url:
            parsed = urlparse(database_url)
            host = parsed.hostname
            user = parsed.username
            password = parsed.password
            database = parsed.path.lstrip('/')
            port = parsed.port or 3306

            connect_args = dict(
                host=host,
                user=user,
                password=password,
                database=database,
                port=port,
                charset='utf8mb4',
                collation='utf8mb4_unicode_ci',
            )

            # TiDB Serverless and other cloud MySQL providers require SSL
            use_ssl = (
                os.environ.get('MYSQL_SSL', '').lower() in ('1', 'true')
                or (host and any(s in host for s in ('tidb', 'tidbcloud', 'planetscale', 'aiven')))
            )
            if use_ssl:
                ssl_ca = '/etc/ssl/certs/ca-certificates.crt'
                if not os.path.exists(ssl_ca):
                    ssl_ca = '/etc/ssl/cert.pem'
                if os.path.exists(ssl_ca):
                    connect_args['ssl_ca'] = ssl_ca
                    connect_args['ssl_verify_identity'] = True
                else:
                    connect_args['ssl_disabled'] = False
        else:
            connect_args = dict(
                host=os.environ.get('DB_HOST', 'localhost'),
                user=os.environ.get('DB_USER', 'root'),
                password=os.environ.get('DB_PASSWORD', ''),
                database=os.environ.get('DB_NAME', 'Cabal'),
                port=int(os.environ.get('DB_PORT', 3306)),
                charset='utf8mb4',
                collation='utf8mb4_unicode_ci',
            )

        conn = mysql.connector.connect(**connect_args)
        print("Conexión exitosa a la BD")
        return MysqlDictConnection(conn)

    except Exception as error:
        print(f"No se pudo conectar: {error}")
        raise error
