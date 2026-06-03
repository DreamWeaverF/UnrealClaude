#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$ROOT/Binaries"
URL="${1:-}"
TEMP_DIR="${TMPDIR:-/tmp}/UnrealClaude-Binaries"
ZIP="${TMPDIR:-/tmp}/UnrealClaude-Binaries.zip"

if [ -z "$URL" ]; then
  echo "Usage: $(basename "$0") <github-release-binaries-zip-url>"
  echo "The zip must contain a Binaries folder at its root."
  exit 1
fi

if command -v curl >/dev/null 2>&1; then
  curl -L "$URL" -o "$ZIP"
elif command -v wget >/dev/null 2>&1; then
  wget -O "$ZIP" "$URL"
else
  echo "curl or wget is required to download release binaries."
  exit 1
fi

rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"

if command -v unzip >/dev/null 2>&1; then
  unzip -o "$ZIP" -d "$TEMP_DIR"
else
  echo "unzip is required to extract release binaries."
  exit 1
fi

if [ -d "$TEMP_DIR/Binaries" ]; then
  mkdir -p "$TARGET"
  cp -a "$TEMP_DIR/Binaries/." "$TARGET/"
elif [ -d "$TEMP_DIR/Win64" ]; then
  mkdir -p "$TARGET"
  cp -a "$TEMP_DIR/." "$TARGET/"
else
  echo "Downloaded package must contain Binaries/ or Win64/."
  exit 1
fi

echo "Binaries restored to $TARGET"
