#!/usr/bin/env bash
set -e

# Restore toolchain
module purge
module load gcc/11.4.0
module load cuda/12.8.0
module load bzip2/1.0.6
module load cmake/3.28.1

echo "=== probe: host and gpu ==="
hostname
whoami
pwd
echo

echo "=== probe: nvidia-smi ==="
if command -v nvidia-smi >/dev/null 2>&1; then
  nvidia-smi
else
  echo "ERROR: nvidia-smi not found. Are you on a GPU node?"
  exit 1
fi
echo

echo "=== probe: modules ==="
if command -v module >/dev/null 2>&1; then
  module list || true
else
  echo "WARNING: 'module' command not found in this shell."
  echo "         (This can happen in odd shells; try a fresh terminal.)"
fi
echo

echo "=== probe: nvcc ==="
if command -v nvcc >/dev/null 2>&1; then
  which nvcc
  nvcc --version | head -n 5
else
  echo "nvcc not found (CUDA toolkit not loaded)."
  echo "Try: module load cuda/12.8.0"
fi
echo

echo "OK."

