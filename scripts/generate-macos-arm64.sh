#!/usr/bin/env bash

set -euo pipefail

printf "\nSubmodule check...\n"
git submodule update --init
printf "Submodule is checked out at commit: $(git submodule status)\n\n"

echo "Setting up Python dependencies..."
python3 --version
pip install -r requirements.txt

cd ./bdk-ffi/bdk-ffi/

rustup default 1.84.1
rustup target add aarch64-apple-darwin

echo "Generating native binaries..."
cargo build --profile release-smaller --target aarch64-apple-darwin

echo "Generating bdk.py..."
cargo run --bin uniffi-bindgen generate --library ./target/aarch64-apple-darwin/release-smaller/libbdkffi.dylib --language python --out-dir ../../src/bdkpython/ --no-format

echo "Copying libraries libbdkffi.dylib..."
cp ./target/aarch64-apple-darwin/release-smaller/libbdkffi.dylib ../../src/bdkpython/libbdkffi.dylib

echo "All done!"
