#!/bin/bash

# Create a test html file
mkdir test
printf "WITNESS" > test/index.html

# Build and run image
docker compose -f docker-compose.test.yaml \
  up -d --build --wait --wait-timeout 10

# Assert that our test file is readable
result=$(curl -s http://localhost:8080/)

docker compose -f docker-compose.test.yaml down

[ "$result" == "WITNESS" ] || exit 1

echo "Success"
exit 0
