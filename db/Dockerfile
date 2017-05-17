FROM postgres
ENV POSTGRES_PASSWORD_FILE /run/secrets/db_master_password
ADD set_roles.sh /docker-entrypoint-initdb.d/
