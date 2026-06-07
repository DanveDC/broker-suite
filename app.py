import os
from dotenv import load_dotenv
from flask import Flask

load_dotenv()

app = Flask(__name__)
application = app
app.secret_key = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')
