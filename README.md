# Platform (Phase 0)

## Quickstart (clean Windows machine)
1. Install WSL2 + Docker Desktop (WSL2 backend) + VS Code (WSL, Dev Containers, Docker extensions).
2. In WSL: `git clone <repo> ~/code/platform && cd ~/code/platform`
3. Open in VS Code → "Reopen in Container" (builds toolchain, runs bootstrap).
4. `cp .env.example .env` and set a local password.
5. `task infra:up`  → baseline infra healthy.
6. `task up`        → Aspire dashboard + all services green.

## Second-machine onboarding runbook (target ≤ 30 min)

Hand this to the second laptop. It assumes only a fresh Windows 11 box.

1. **(10 min)** `HOST`: `wsl --install -d Ubuntu-24.04`, reboot, install Docker Desktop (WSL2 backend, enable distro integration), install VS Code + WSL/Dev Containers/Docker extensions.
2. **(3 min)** `WSL`: `sudo apt-get update && sudo apt-get install -y git curl git-lfs && git lfs install`.
3. **(3 min)** `WSL`: replicate Git identity + signing from **Section 1** (create/import your SSH key, add to GitHub as auth **and** signing key).
4. **(2 min)** `WSL`: `git clone <repo> ~/code/platform && cd ~/code/platform`.
5. **(8 min)** VS Code → "Reopen in Container" (builds toolchain, `eng/bootstrap.sh` restores all deps + installs hooks + Aspire CLI).
6. **(2 min)** `cp .env.example .env`, set local password.
7. **(2 min)** `task infra:up` → infra healthy; `task up` → Aspire dashboard green.


## Layout
See directory tree in docs. Pins: global.json, .nvmrc, .python-version.
