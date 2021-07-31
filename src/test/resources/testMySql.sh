#!/usr/bin/env bash

mysqlTag="8.0"

if docker ps -a | grep -q test-mysql; then
  echo "Cleaning up old test-mysql"
  docker kill test-mysql
  docker rm test-mysql && docker ps
else
  echo "Did not find test-mysql to delete"
fi

docker run --name test-mysql \
       -e MYSQL_DATABASE=user_db \
       -e MYSQL_USER=mysqluser \
       -e MYSQL_PASSWORD=topsecret \
       -e MYSQL_ROOT_PASSWORD=root \
       -d -p 3306:3306 \
       mysql:$mysqlTag \
       --character-set-server=utf8mb4 \
       --collation-server=utf8mb4_unicode_ci

docker logs --follow test-mysql