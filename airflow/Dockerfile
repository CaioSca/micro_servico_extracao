FROM apache/airflow:2.10.2

USER root

RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

USER airflow

RUN pip install poetry

RUN poetry config virtualenvs.create false

COPY pyproject.toml poetry.lock $AIRFLOW_HOME/

RUN poetry install --no-root --only main

COPY . $AIRFLOW_HOME/

COPY entrypoint.sh /entrypoint.sh

USER root

RUN chmod +x /entrypoint.sh

USER airflow

# portas usadas apenas pelo webserver e flower, respectivamente.
# a efetiva exposição das portas se dá mediante o uso do parâmetro -p no docker run 
EXPOSE 8080 5555

ENTRYPOINT ["/entrypoint.sh"]
