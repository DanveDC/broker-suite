import os
import ssl
import pg8000.dbapi
from urllib.parse import urlparse


class DictCursor:
    """Makes pg8000 cursor return dicts like psycopg2 RealDictCursor."""

    def __init__(self, cursor):
        self._c = cursor

    def execute(self, query, params=None):
        if params is not None:
            self._c.execute(query, list(params))
        else:
            self._c.execute(query)

    def fetchone(self):
        row = self._c.fetchone()
        if row is None:
            return None
        cols = [d[0] for d in self._c.description]
        return dict(zip(cols, row))

    def fetchall(self):
        rows = self._c.fetchall()
        if not rows:
            return []
        cols = [d[0] for d in self._c.description]
        return [dict(zip(cols, row)) for row in rows]

    @property
    def rowcount(self):
        return self._c.rowcount

    @property
    def description(self):
        return self._c.description

    def close(self):
        self._c.close()

    def __enter__(self):
        return self

    def __exit__(self, *args):
        self.close()


class DictConnection:
    """Makes pg8000 connection behave like psycopg2 — accepts cursor_factory arg (ignored)."""

    def __init__(self, conn):
        self._conn = conn
        self._autocommit = False

    def cursor(self, cursor_factory=None):
        return DictCursor(self._conn.cursor())

    def commit(self):
        self._conn.commit()

    def rollback(self):
        self._conn.rollback()

    def close(self):
        self._conn.close()

    @property
    def autocommit(self):
        return self._autocommit

    @autocommit.setter
    def autocommit(self, value):
        self._autocommit = value
        self._conn.autocommit = value


def connectionBD():
    try:
        database_url = os.environ.get('DATABASE_URL')

        if database_url:
            if database_url.startswith('postgres://'):
                database_url = database_url.replace('postgres://', 'postgresql://', 1)
            parsed = urlparse(database_url)

            ssl_ctx = ssl.create_default_context()
            ssl_ctx.check_hostname = False
            ssl_ctx.verify_mode = ssl.CERT_NONE

            conn = pg8000.dbapi.connect(
                host=parsed.hostname,
                user=parsed.username,
                password=parsed.password,
                database=parsed.path.lstrip('/'),
                port=parsed.port or 5432,
                ssl_context=ssl_ctx
            )
        else:
            conn = pg8000.dbapi.connect(
                host=os.environ.get('DB_HOST', 'localhost'),
                user=os.environ.get('DB_FALLBACK_USER', 'appuser'),
                password=os.environ.get('DB_FALLBACK_PASSWORD', 'changeme'),
                database=os.environ.get('DB_NAME', 'brokerdb'),
                port=int(os.environ.get('DB_PORT', 5432))
            )

        print("Conexión exitosa a la BD")
        return DictConnection(conn)

    except Exception as error:
        print(f"No se pudo conectar: {error}")
        raise error
