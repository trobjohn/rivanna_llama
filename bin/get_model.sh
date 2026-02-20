#!/usr/bin/env bash
set -euo pipefail

# --- DEFAULT MODEL TARGET (edit this if you want a different model) ---
HF_REPO="${HF_REPO:-MaziyarPanahi/Mistral-7B-Instruct-v0.3-GGUF}"
HF_FILE="${HF_FILE:-Mistral-7B-Instruct-v0.3.Q4_K_M.gguf}"
# ---------------------------------------------------------------

MODELS_DIR="${MODELS_DIR:-models}"
OUT="${OUT:-$MODELS_DIR/$HF_FILE}"
URL="https://huggingface.co/${HF_REPO}/resolve/main/${HF_FILE}?download=true"

echo "=== get_model ==="
echo "Repo : $HF_REPO"
echo "File : $HF_FILE"
echo "Out  : $OUT"
echo

mkdir -p "$MODELS_DIR"

if [[ -f "$OUT" ]]; then
  echo "Model already present."
  ls -lh "$OUT"
  exit 0
fi

echo "Downloading from:"
echo "  $URL"
echo

if command -v curl >/dev/null 2>&1; then
  curl -L --retry 5 --retry-delay 2 -C - -o "$OUT" "$URL"
elif command -v wget >/dev/null 2>&1; then
  wget -O "$OUT" "$URL"
else
  echo "ERROR: Need curl or wget."
  exit 1
fi

echo
echo "Done:"
ls -lh "$OUT"

