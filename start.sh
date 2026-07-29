#!/bin/sh
set -e

cd oai-cn5g/
# docker compose down
docker compose up -d
docker logs oai-cn5g-oai-gnb-1 --follow
