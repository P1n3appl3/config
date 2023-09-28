#!/usr/bin/env bash

shopt -s globstar
set -euo pipefail

readonly CONF_DIR="${HOME}"

d() { if [[ -n ${DEBUG+x} ]]; then echo "running: $@"; fi; "${@}"; }

ln -sf $CONF_DIR/.cfg $FACADE_DIR/.git
for file in "${HOME}/flake.nix" "${HOME}/flake.lock" "${CONF_DIR}"/.config/nix-config/**; do
  repoRelativePath="$(realpath "$file" --relative-base "${CONF_DIR}")"

  if [ -f $file ]; then
    d mkdir -p "${FACADE_DIR}/$(dirname "$repoRelativePath")"
    d ln -f "${CONF_DIR}/$repoRelativePath" "${FACADE_DIR}/$repoRelativePath"
  fi

done
