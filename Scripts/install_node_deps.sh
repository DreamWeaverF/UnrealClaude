#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BRIDGE="$ROOT/Resources/mcp-bridge"

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js 18+ is required. Install Node.js first, then run this script again."
  exit 1
fi

node -e "const major=Number(process.versions.node.split('.')[0]); process.exit(major >= 18 ? 0 : 1)" || {
  echo "Node.js 18+ is required. Please upgrade Node.js and run this script again."
  exit 1
}

if [ ! -f "$BRIDGE/package.json" ]; then
  echo "Missing $BRIDGE/package.json"
  exit 1
fi

cd "$BRIDGE"
if [ -f package-lock.json ]; then
  npm ci
else
  npm install
fi
