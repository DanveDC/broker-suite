import os
from urllib.parse import urlparse
import pymysql
import pymysql.cursors


class MysqlDictConnection:
    """Wraps pymysql connection so cursor() always returns dict rows."""

    def __init__(self, conn):
        self._conn = conn

    def cursor(self, cursor_factory=None, dictionary=None):
        return self._conn.cursor()

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

            use_ssl = (
                os.environ.get('MYSQL_SSL', '').lower() in ('1', 'true')
                or (host and any(s in host for s in ('tidb', 'tidbcloud', 'planetscale', 'aiven')))
            )

            connect_args = dict(
                host=host,
                user=user,
                password=password,
                database=database,
                port=port,
                charset='utf8mb4',
                cursorclass=pymysql.cursors.DictCursor,
                autocommit=False,
            )

            if use_ssl:
                ssl_ca = '/etc/ssl/certs/ca-certificates.crt'
                if not os.path.exists(ssl_ca):
                    ssl_ca = '/etc/ssl/cert.pem'
                connect_args['ssl'] = {'ca': ssl_ca} if os.path.exists(ssl_ca) else {'ssl': True}
        else:
            connect_args = dict(
                host=os.environ.get('DB_HOST', 'localhost'),
                user=os.environ.get('DB_USER', 'root'),
                password=os.environ.get('DB_PASSWORD', ''),
                database=os.environ.get('DB_NAME', 'cabal'),
                port=int(os.environ.get('DB_PORT', 3306)),
                charset='utf8mb4',
                cursorclass=pymysql.cursors.DictCursor,
                autocommit=False,
            )

        conn = pymysql.connect(**connect_args)
        print("Conexión exitosa a la BD")
        return MysqlDictConnection(conn)

    except Exception as error:
        print(f"No se pudo conectar: {error}")
        raise error
