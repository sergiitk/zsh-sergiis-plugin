#!/usr/bin/env bash

set -eo pipefail

REAL_PATH=$(realpath "${0}")
CURRENT_DIR=$(dirname "${REAL_PATH}")
readonly CURRENT_DIR

cd "${CURRENT_DIR}"

find * -type f | xargs -I{} echo ln -vsf $(realpath {}) ~/.bin/{}

read -n 1 -p "Continue? (y/N) " answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
  echo
  find * -type f | xargs -I{} ln -vsf $(realpath {}) ~/.bin/{}
else
  echo
  echo "Exit"
fi
