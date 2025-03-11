OS_VERSION=$(awk -F= '/^PRETTY_NAME/ {print $2}' /etc/os-release | tr -d '"')
NODE_VERSION=$(node -v)

echo "OS Version: $OS_VERSION"
echo "Node.js Version: $NODE_VERSION"

# Send data to Datadog with multi-line JSON formatting
curl -X POST "https://http-intake.logs.datadoghq.com/v1/input" \
     -H "Content-Type: application/json" \
     -H "DD-API-KEY: YOUR_DATADOG_API_KEY" \
     -d @- <<EOF
{
  "message": "System Information",
  "os_version": "$OS_VERSION",
  "node_version": "$NODE_VERSION",
  "service": "my-app"
}
EOF
