#!/bin/bash
# bwrap inside docker needs unconfined seccomp/apparmor and an unmasked /proc
set -euo pipefail
docker build -q -t repro-ai-jail .
docker run --rm \
  --security-opt seccomp=unconfined \
  --security-opt apparmor=unconfined \
  --security-opt systempaths=unconfined \
  -v "./ai-jail.toml:/home/alice/.ai-jail:ro" \
  repro-ai-jail
