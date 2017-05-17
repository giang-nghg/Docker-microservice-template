#!/usr/bin/env bash

SERVICE=$1

sudo docker run --rm stack-$SERVICE
