#!/usr/bin/env bash

SERVICE=$1

sudo docker rmi stack-$SERVICE
sudo docker build -t stack-$SERVICE $SERVICE
