#!/usr/bin/env bash
set -euo pipefail

SRC="src"
OUT="lua"
mkdir -p "$OUT"

moonc init.moon -o init.lua

find "$SRC" -name "*.moon" | while read -r file; do
    rel="${file#$SRC/}"
    out="$OUT/${rel%.moon}.lua"

    mkdir -p "$(dirname "$out")"

    last_build=$(stat -c %Y "$out" 2>/dev/null || echo 0)
    last_src=$(stat -c %Y "$file")

    if (( last_src > last_build )); then
        echo "Compiling $file"
        moonc -o "$out" "$file"
    fi
done
