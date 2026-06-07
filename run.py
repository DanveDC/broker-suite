# Declarando nombre de la aplicación e inicializando, crear la aplicación Flask
from app import app
    
# Importando todos mis Routers (Rutas)
from routers.router_login import *
from routers.router_home import *
from routers.router_page_not_found import *
from controllers.funciones_home import obtener_conteo_polizas_pendientes

@app.context_processor
def inject_pending_count():
    if 'conectado' in session:
        return {'conteo_pendientes': obtener_conteo_polizas_pendientes()}
    return {'conteo_pendientes': 0}

# Ejecutando el objeto Flask
if __name__ == '__main__':
    app.run(debug=True, port=5600)