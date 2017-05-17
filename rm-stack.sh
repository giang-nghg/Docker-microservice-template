#!/usr/bin/env bash

sudo docker stack rm stack
sudo docker container prune -f
sudo docker volume prune -f
