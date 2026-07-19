FROM python:3.11-slim

# ca-certificates required for TLS to TiDB Cloud (see conexion/conexionBD.py)
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
RUN mkdir -p temp_data

ENV PORT=8000
EXPOSE 8000

CMD ["python", "wsgi.py"]
