#!/usr/bin/env bash

set -euo pipefail

printf "\nSubmodule check...\n"
git submodule update --init
printf "Submodule is checked out at commit: $(git submodule status)\n\n"

cd ./bdk-ffi/bdk-ffi/

rustup target add x86_64-apple-darwin

echo "Generating native binaries..."
cargo build --profile release-smaller --target x86_64-apple-darwin

echo "Generating bdk.py..."
cargo run --bin uniffi-bindgen generate --library ./target/x86_64-apple-darwin/release-smaller/libbdkffi.dylib --language python --out-dir ../../src/bdkpython/ --no-format

echo "Copying libraries libbdkffi.dylib..."
cp ./target/x86_64-apple-darwin/release-smaller/libbdkffi.dylib ../../src/bdkpython/libbdkffi.dylib

echo "All done!"
