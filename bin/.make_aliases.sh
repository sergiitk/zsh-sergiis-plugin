#!/usr/bin/env zsh

set -eo pipefail

REAL_PATH=$(realpath "${0}")
CURRENT_DIR=$(dirname "${REAL_PATH}")
readonly CURRENT_DIR

cd "${CURRENT_DIR}"

find * -type f | xargs -I% echo ln -vsf ${CURRENT_DIR}/% ~/.bin/%

read -n 1 -p "Continue? (y/N) " answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
  echo
  find * -type f | xargs -I% ln -vsf ${CURRENT_DIR}/% ~/.bin/%
else
  echo
  echo "Exit"
fi
