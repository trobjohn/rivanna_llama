#!/usr/bin/env bash
set -euo pipefail

LLAMA_REPO="${LLAMA_REPO:-https://github.com/ds4e/llama.cpp}"
LLAMA_DIR="${LLAMA_DIR:-vendor/llama.cpp}"
BUILD_DIR="${BUILD_DIR:-build/llama.cpp}"

echo "=== build_llama ==="
echo "Repo : $LLAMA_REPO"
echo "Src  : $LLAMA_DIR"
echo "Build: $BUILD_DIR"
echo

mkdir -p vendor build

echo "Loading modules..."
module purge >/dev/null 2>&1 || true
module load gcc/11.4.0
module load cuda/12.8.0
module load bzip2/1.0.6
module load cmake/3.28.1
echo "gcc : $(gcc --version | head -n 1)"
echo "cmake: $(cmake --version | head -n 1)"
echo "nvcc: $(nvcc --version | head -n 2 | tail -n 1)"
echo

if [[ ! -d "$LLAMA_DIR/.git" ]]; then
  echo "Cloning llama.cpp..."
  rm -rf "$LLAMA_DIR" 2>/dev/null || true
  git clone "$LLAMA_REPO" "$LLAMA_DIR"
else
  echo "Found existing llama.cpp checkout."
fi
echo

if [[ ! -x "$BUILD_DIR/bin/llama-cli" ]]; then
  echo "Configuring (CUDA enabled)..."
  cmake -S "$LLAMA_DIR" -B "$BUILD_DIR" -DGGML_CUDA=ON
  echo
  echo "Building..."
  JOBS="${JOBS:-4}"
  cmake --build "$BUILD_DIR" -j "$JOBS"
else
  echo "Build already exists: $BUILD_DIR/bin/llama-cli"
fi

echo
echo "OK: binaries:"
ls -1 "$BUILD_DIR/bin" | head -n 20

