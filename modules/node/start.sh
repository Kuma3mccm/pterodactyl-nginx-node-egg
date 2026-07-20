#!/usr/bin/env bash
set -euo pipefail
trap 'echo -e "${RED}[Node] Error on line $LINENO${NC}"' ERR

BLUE='\033[0;34m'; BOLD_BLUE='\033[1;34m'
WHITE='\033[0;37m'; GREEN='\033[0;32m'
YELLOW='\033[0;33m'; RED='\033[0;31m'
NC='\033[0m'

header() {
  echo -e "${BLUE}───────────────────────────────────────────────${NC}"
  echo -e "${BOLD_BLUE}[Node] $1${NC}"
}

# configurations
NPM_START_CMD="${NPM_START_CMD:-}"

mkdir -p /home/container/.npm
export NPM_CONFIG_CACHE="/home/container/.npm"

# set default node port (SERVER_PORT と揃える設計の場合)
export SERVER_PORT="${SERVER_PORT:-1234}"
export NODE_PORT="${NODE_PORT:-${SERVER_PORT}}"
export PORT="${NODE_PORT}"

header "Starting Node module on PORT=${PORT}"
cd /home/container/node

# ここで依存をインストール
header "Running npm install"
npm install

# 依存インストール後にアプリを起動
header "Running start command: ${NPM_START_CMD}"
$NPM_START_CMD