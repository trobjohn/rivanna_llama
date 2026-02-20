#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="${BUILD_DIR:-build/llama.cpp}"
MODEL="${MODEL:-models/Mistral-7B-Instruct-v0.3.Q4_K_M.gguf}"

PROMPT="${1:-"Explain, in plain language, what an LLM is and what it is not."}"

echo "=== run_chat ==="
echo "Binary: $BUILD_DIR/bin/llama-cli"
echo "Model : $MODEL"
echo

if [[ ! -x "$BUILD_DIR/bin/llama-cli" ]]; then
  echo "ERROR: missing $BUILD_DIR/bin/llama-cli"
  echo "Run: bin/build_llama.sh"
  exit 1
fi

if [[ ! -f "$MODEL" ]]; then
  echo "ERROR: missing model $MODEL"
  echo "Run: bin/get_model.sh"
  exit 1
fi

module purge >/dev/null 2>&1 || true
module load gcc/11.4.0
module load cmake/4.1.2
module load cuda/12.8.0

"$BUILD_DIR/bin/llama-cli" \
  -m "$MODEL" \
  -p "$PROMPT" \
  -ngl 999

