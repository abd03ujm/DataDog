#!/bin/bash

OS_VERSION="3.21"
NODE_VERSION="18.20"

echo "OS Version: $OS_VERSION"
echo "Node.js Version: $NODE_VERSION"

# Send data to Datadog with multi-line JSON formatting and ddsource
curl -X POST "https://http-intake.logs.datadoghq.com/v1/input" \
     -H "Content-Type: application/json" \
     -H "DD-API-KEY: YOUR_DATADOG_API_KEY" \
     -d @- <<EOF
{
  "message": "System Information",
  "os_version": "$OS_VERSION",
  "node_version": "$NODE_VERSION",
  "service": "my-app",
  "ddsource": "system-metrics"
}
EOF
```
#!/bin/bash

# Extract system info
OS_VERSION=$(awk -F= '/^PRETTY_NAME/ {print $2}' /etc/os-release | tr -d '"')
NODE_VERSION=$(node -v)

# Create a temporary JSON file
TEMP_JSON="temp_data.json"

# Replace placeholders with actual values
jq --arg os "$OS_VERSION" --arg node "$NODE_VERSION" \
    '.os_version = $os | .node_version = $node' data.json > $TEMP_JSON

# Send data to Datadog
curl -X POST "https://http-intake.logs.datadoghq.com/v1/input" \
     -H "Content-Type: application/json" \
     -H "DD-API-KEY: YOUR_DATADOG_API_KEY" \
     -d @"$TEMP_JSON"

# Clean up temp file
rm -f "$TEMP_JSON"
