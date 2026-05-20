#!/usr/bin/env bash

set -euo pipefail

printf "\nSubmodule check...\n"
if [[ "${1:-}" != "--skip-submodule-update" ]]; then
  git submodule update --init
  printf "Submodule is checked out at commit: $(git submodule status)\n\n"
else
  printf "Skipping submodule update, using local changes.\n"
  printf "Submodule is checked out at commit: $(git submodule status)\n\n"
fi

cd ./bdk-ffi/bdk-ffi/

rustup target add aarch64-apple-darwin

echo "Generating native binaries..."
cargo build --locked --profile release-smaller --target aarch64-apple-darwin

echo "Generating bdk.py..."
cargo run --bin uniffi-bindgen generate --library ./target/aarch64-apple-darwin/release-smaller/libbdkffi.dylib --language python --out-dir ../../src/bdkpython/ --no-format

echo "Copying libraries libbdkffi.dylib..."
cp ./target/aarch64-apple-darwin/release-smaller/libbdkffi.dylib ../../src/bdkpython/libbdkffi.dylib

echo "All done!"
