# /Services/homepage/justfile 

# -----------------------------------------------------------------
# 💡 シェル設定
# -----------------------------------------------------------------
set shell := ["bash", "-cu"]

SERVICE_NAME := shell("basename $(pwd)")

_default:
  @just --list -u

# 開発環境起動 (docker-compose.yml + compose.dev.yml)
up:
    @echo "--> 🚀 Starting {{SERVICE_NAME}} (Dev Mode)..."
    @docker compose -f docker-compose.yml -f compose.dev.yml -d --build

# 開発環境停止
down:
    @echo "--> 🛑 Stopping {{SERVICE_NAME}}..."
    @docker compose -f docker-compose.yml -f compose.dev.yml down