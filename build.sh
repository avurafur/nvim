#!/usr/bin/env bash
set -euo pipefail

SRC="src"
OUT="lua"
mkdir -p "$OUT"

if [[ ! -f "init.lua" || "init.moon" -nt "init.lua" ]]; then
  echo "Compiling init.moon"
  moonc init.moon -o init.lua
fi

find "$SRC" -name "*.moon" | while read -r file; do
    rel="${file#$SRC/}"
    out="$OUT/${rel%.moon}.lua"

    mkdir -p "$(dirname "$out")"

    if [[ ! -f "$out" || "$file" -nt "$out" ]]; then
        echo "Compiling $file"
        moonc -o "$out" "$file"
    fi
done
