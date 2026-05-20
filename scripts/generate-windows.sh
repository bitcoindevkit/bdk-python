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

rustup target add x86_64-pc-windows-msvc

echo "Generating native binaries..."
cargo build --locked --profile release-smaller --target x86_64-pc-windows-msvc

echo "Generating bdk.py..."
cargo run --bin uniffi-bindgen generate --library ./target/x86_64-pc-windows-msvc/release-smaller/bdkffi.dll --language python --out-dir ../../src/bdkpython/ --no-format

echo "Copying libraries bdkffi.dll..."
cp ./target/x86_64-pc-windows-msvc/release-smaller/bdkffi.dll ../../src/bdkpython/bdkffi.dll

echo "All done!"
