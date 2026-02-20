#!/usr/bin/env bash
set -euo pipefail

PORT="${PORT:-8000}"

echo "Health:"
curl -s "http://localhost:${PORT}/health"
echo
echo

echo "Chat reply:"
curl -s "http://localhost:${PORT}/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "local",
    "messages": [
      {"role": "user", "content": "How are you doing, LLM friend?"}
    ],
    "max_tokens": 20,
    "temperature": 0
  }' \
  | python -c 'import sys,json; print(json.load(sys.stdin)["choices"][0]["message"]["content"])'
