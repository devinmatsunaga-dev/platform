#!/usr/bin/env bash
set -euo pipefail

echo "== Verifying pinned toolchain =="
expected_dotnet="$(python3 -c 'import json; print(json.load(open("global.json"))["sdk"]["version"])')"
expected_node="v$(cat .nvmrc)"
expected_python="Python $(cat .python-version)"

actual_dotnet="$(dotnet --version)"
actual_node="$(node --version)"
actual_python="$(python --version)"

printf "dotnet: expected %s, actual %s\n" "$expected_dotnet" "$actual_dotnet"
printf "node:   expected %s, actual %s\n" "$expected_node" "$actual_node"
printf "python: expected %s, actual %s\n" "$expected_python" "$actual_python"
uv --version

[ "$actual_dotnet" = "$expected_dotnet" ]
[ "$actual_node" = "$expected_node" ]
[ "$actual_python" = "$expected_python" ]

echo "== Enabling pnpm via Corepack =="
corepack enable

echo "== Installing the Aspire CLI =="
curl -fsSL https://aspire.dev/install.sh | bash

echo "== Restoring dependencies =="
[ -f src/api/Platform.Api.csproj ] && (cd src/api && dotnet restore --locked-mode)
[ -f src/web/package.json ] && (cd src/web && pnpm install --frozen-lockfile)
[ -f src/workers/pyproject.toml ] && (cd src/workers && uv sync --frozen)

echo "== Installing pre-commit hooks =="
uv tool install pre-commit || pip install --user pre-commit
pre-commit install --install-hooks
pre-commit install --hook-type commit-msg

echo "Bootstrap complete."
