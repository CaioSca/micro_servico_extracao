#!/usr/bin/env bash

set -e

case "$COMPONENT" in
  create_user)
    echo "Criando usuário admin no Airflow..."
    airflow users create \
      --username "$AIRFLOW_ADMIN_USERNAME" \
      --password "$AIRFLOW_ADMIN_PASSWORD" \
      --firstname "${AIRFLOW_ADMIN_FIRSTNAME:-Admin}" \
      --lastname "${AIRFLOW_ADMIN_LASTNAME:-User}" \
      --role "Admin" \
      --email "${AIRFLOW_ADMIN_EMAIL:-admin@example.com}" || echo "Usuário já existe ou erro ao criar."
    ;;
  webserver)
    echo "Iniciando o Airflow Webserver..."
    airflow webserver
    ;;
  scheduler)
    echo "Iniciando o Airflow Scheduler..."
    airflow scheduler
    ;;
  worker)
    echo "Iniciando o Airflow Celery Worker..."
    airflow celery worker
    ;;
  flower)
    echo "Iniciando o Airflow Flower..."
    airflow celery flower
    ;;
  migrate)
    echo "Executando migrações do Airflow..."
    airflow db migrate
    ;;
  *)
    echo "Componente não especificado ou desconhecido: $COMPONENT"
    echo "Por favor, defina a variável de ambiente COMPONENT para um dos seguintes valores: webserver, scheduler, worker, flower, migrate"
    exit 1
    ;;
esac
