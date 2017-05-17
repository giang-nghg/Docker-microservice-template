#!/usr/bin/env bash

sudo docker swarm init
echo $DB_MASTER_PASSWORD | sudo docker secret create db_master_password -
echo $READER_PASSWORD | sudo docker secret create reader_password -
echo $WRITER_PASSWORD | sudo docker secret create writer_password -
