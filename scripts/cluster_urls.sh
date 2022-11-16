set -e
eval "$(jq -r '@sh "CLUSTER_NAME=\(.cluster_name)"')"
STATE=$(rosa describe cluster --cluster ${CLUSTER_NAME} --output json)
CONSOLE_URL=$(echo $STATE | jq -r '.console.url')
API_URL=$(echo $STATE | jq -r '.api.url')

jq -n --arg console_url "$CONSOLE_URL" --arg api_url "$API_URL" '{"console_url":$console_url, "api_url":$api_url}'
