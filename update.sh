#!/usr/bin/env -S nix shell nixpkgs#bash nixpkgs#packwiz --command bash
# shellcheck shell=bash
BASE_DIR=$(dirname "$(realpath "$0")")
ADDITIONS_FILE="$BASE_DIR/additions"
VERSIONS_DIR="$BASE_DIR/versions/fabric"

for version_dir in "$VERSIONS_DIR"/*; do
  if [ -d "$version_dir" ]; then
    pushd "$version_dir" > /dev/null || exit

    packwiz refresh

    while IFS= read -r line; do
      packwiz update "$line"
    done < "$ADDITIONS_FILE"

    packwiz refresh

    popd > /dev/null || exit
  fi
done
