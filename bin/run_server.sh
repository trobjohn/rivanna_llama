#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="${BUILD_DIR:-build/llama.cpp}"
MODEL="${MODEL:-models/Mistral-7B-Instruct-v0.3.Q4_K_M.gguf}"

# Server settings (override with env vars if desired)
HOST_BIND="${HOST_BIND:-127.0.0.1}"   # bind only localhost on the compute node
PORT="${PORT:-8000}"
NGL="${NGL:-999}"

echo "=== run_server ==="
echo "Binary: $BUILD_DIR/bin/llama-server"
echo "Model : $MODEL"
echo "Bind  : $HOST_BIND"
echo "Port  : $PORT"
echo

if [[ ! -x "$BUILD_DIR/bin/llama-server" ]]; then
  echo "ERROR: missing $BUILD_DIR/bin/llama-server"
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

NODE="$(hostname)"

echo "Server will run on compute node:"
echo "  ${NODE}:${PORT}"
echo
echo "From your laptop, create a two-hop tunnel:"
echo "  ssh -L ${PORT}:localhost:${PORT} ${USER}@rivanna.hpc.virginia.edu \\"
echo "      ssh -L ${PORT}:localhost:${PORT} ${NODE}"
echo
echo "Then open:"
echo "  http://localhost:${PORT}"
echo
echo "Stop with Ctrl+C."
echo

exec "$BUILD_DIR/bin/llama-server" \
  -m "$MODEL" \
  --host "$HOST_BIND" \
  --port "$PORT" \
  -ngl "$NGL"
