#!/usr/bin/env bash

psql -a <<-EOSQL
  CREATE USER writer WITH PASSWORD '$(cat /run/secrets/writer_password)';
  CREATE USER reader WITH PASSWORD '$(cat /run/secrets/reader_password)';

  ALTER USER writer CREATEDB;
EOSQL
