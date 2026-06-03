#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$ROOT/gitRelease/Binaries"
TARGET="$ROOT/Binaries"

if [ ! -d "$SOURCE" ]; then
  echo "Missing $SOURCE"
  echo "Put release binaries under gitRelease/Binaries before running this script."
  exit 1
fi

mkdir -p "$TARGET"
cp -a "$SOURCE/." "$TARGET/"
echo "Binaries restored to $TARGET"
