# ================================
# Dockerfile para projeto CARONA
# Ambiente de desenvolvimento local
# Acessar: http://localhost:8000
# Suporte a collectstatic + whitenoise
# ================================

FROM python:3.12-slim

# Diretório da aplicação
WORKDIR /app

# Evita prompts interativos
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Instala dependências de sistema necessárias para builds Python
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       gcc \
       build-essential \
       curl \
    && rm -rf /var/lib/apt/lists/*

# Copia requirements primeiro (cache do docker)
COPY requirements.txt /app/requirements.txt

# Instala dependências Python + garante whitenoise
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r /app/requirements.txt \
    && pip install --no-cache-dir whitenoise

# Copia o restante do projeto
COPY . /app

# Copia entrypoint (deve existir na raiz)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Porta do Django
EXPOSE 8000

# Entrypoint que executa migrate + collectstatic antes do comando
ENTRYPOINT ["/entrypoint.sh"]

# Comando padrão (dev). Se quiser usar gunicorn depois, trocamos aqui.
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
