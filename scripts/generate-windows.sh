#!/usr/bin/env bash

set -euo pipefail

printf "\nSubmodule check...\n"
git submodule update --init
printf "Submodule is checked out at commit: $(git submodule status)\n\n"

cd ./bdk-ffi/bdk-ffi/

rustup target add x86_64-pc-windows-msvc

echo "Generating native binaries..."
cargo build --profile release-smaller --target x86_64-pc-windows-msvc

echo "Generating bdk.py..."
cargo run --bin uniffi-bindgen generate --library ./target/x86_64-pc-windows-msvc/release-smaller/bdkffi.dll --language python --out-dir ../../src/bdkpython/ --no-format

echo "Copying libraries bdkffi.dll..."
cp ./target/x86_64-pc-windows-msvc/release-smaller/bdkffi.dll ../../src/bdkpython/bdkffi.dll

echo "All done!"
