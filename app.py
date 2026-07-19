import os
from dotenv import load_dotenv
from flask import Flask

load_dotenv()

app = Flask(__name__)
application = app

secret_key = os.environ.get('SECRET_KEY')
if not secret_key:
    if os.environ.get('RENDER'):
        raise RuntimeError('SECRET_KEY es obligatoria en producción (Render)')
    secret_key = 'dev-secret-key-change-in-production'
app.secret_key = secret_key

app.config['SESSION_COOKIE_HTTPONLY'] = True
app.config['SESSION_COOKIE_SAMESITE'] = 'Lax'
app.config['SESSION_COOKIE_SECURE'] = bool(os.environ.get('RENDER'))
