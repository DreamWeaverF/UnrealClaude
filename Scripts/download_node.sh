#!/usr/bin/env bash
set -euo pipefail

has_node18() {
  command -v node >/dev/null 2>&1 && node -e "const major=Number(process.versions.node.split('.')[0]); process.exit(major >= 18 ? 0 : 1)"
}

if has_node18; then
  echo "Node.js 18+ is already installed."
  exit 0
fi

if command -v brew >/dev/null 2>&1; then
  brew install node
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y nodejs npm
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y nodejs npm
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed nodejs npm
else
  echo "Node.js 18+ is required. Install Node.js manually, then run this script again."
  exit 1
fi

if ! has_node18; then
  echo "Node.js 18+ is required, but the installed node version is still too old."
  echo "Upgrade Node.js manually, then run this script again."
  exit 1
fi

echo "Node.js 18+ is ready."
