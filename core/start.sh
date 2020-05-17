#!/bin/bash
sh var-sub.sh

echo "starting kafka..."

cat config/server.properties

exec "bin/kafka-server-start.sh" "config/server.properties"

