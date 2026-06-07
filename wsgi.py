import os
from app import app
from routers.router_login import *
from routers.router_home import *
from routers.router_page_not_found import *


if __name__ == '__main__':
    from waitress import serve
    port = int(os.environ.get('PORT', 8000))
    serve(app, host='0.0.0.0', port=port)
