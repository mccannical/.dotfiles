#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Turn on FM Lights
# @raycast.mode inline
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author me
# @raycast.authorURL https://raycast.com/m6w8h8tx44

echo "Hello World!"


action=$1

curl 'https://atx-api.actiontiles.com/v7/devices' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'Referer: https://app.actiontiles.com/' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'sec-ch-ua: "Chromium";v="130", "Google Chrome";v="130", "Not?A_Brand";v="99"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Content-Type: text/plain;charset=UTF-8' \
  --data @- << EOF
  {
  "origin": {
    "panel": "2bdcce98-3747-41c4-a440-aa4e9b758a44",
    "tile": 3,
    "tileId": "7ba3f851-7e6f-4aa6-995d-b312885ed42c",
    "tileset": 2
  },
  "target": {
    "location": "2e943e53-9249-4b0d-aa26-41d61a2efe11",
    "device": "f0d9bd07-013d-47e7-b433-1d80f9c21d7c",
    "command": "${action}",
    "capability": "switch"
  },
  "auth": "eyJhbGciOiJSUzI1NiIsImtpZCI6ImU2YWMzNTcyNzY3ZGUyNjE0ZmM1MTA4NjMzMDg3YTQ5MjMzMDNkM2IiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYWN0aW9udGlsZXMtMzlmMWQiLCJhdWQiOiJhY3Rpb250aWxlcy0zOWYxZCIsImF1dGhfdGltZSI6MTcxODA1MTE2MiwidXNlcl9pZCI6InRuNEFzSDNwQ0pjWEhocDhSU1RySTNwU3FaSzIiLCJzdWIiOiJ0bjRBc0gzcENKY1hIaHA4UlNUckkzcFNxWksyIiwiaWF0IjoxNzMwNDExOTM0LCJleHAiOjE3MzA0MTU1MzQsImVtYWlsIjoiamVzc2VAbWNjYW5uaWNhbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiamVzc2VAbWNjYW5uaWNhbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.KusD0BA_Y5hIshqezh3-3_yv_ZqqlfhdYRuAQ9Lf8d_rGi8rkCM9gT_Uf5g6GqKRjGzinovSuPiAeXCzATvXiXL_HvfDIMQSKNhd9ic0T-gRE63ZYfUYu9wHuvyrpxX9-FMu8mQ9jUxsHsEJeRtGk8xQR9sX-2HlhSOLp7AcTX8MVSB_Aepsy9wwrwo4-zMX5_oRCY4CLMcJn5Iq_uUrn9s6-8vurnTJ4RnyfJVHE7Ip16p2q3keoW24jv8ftMKJ5bdL9w329scZVGoxEFNrIHxikBEiCb27daHzkyMvcxnHnwzAyi_cj_uVstRppGLf-vj_6OhA8R2PTuJEmIfEcQ"
}
EOF