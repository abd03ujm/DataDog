#!/bin/bash

OS_VERSION=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')
NODE_VERSION=$(node -v)

echo "OS Version: $OS_VERSION"
echo "Node.js Version: $NODE_VERSION"

# Send data to Datadog
curl -X POST "https://http-intake.logs.datadoghq.com/v1/input" \
     -H "Content-Type: application/json" \
     -H "DD-API-KEY: YOUR_DATADOG_API_KEY" \
     -d "{\"message\": \"OS: $OS_VERSION, Node: $NODE_VERSION\", \"service\": \"my-app\"}"
