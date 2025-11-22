#!/usr/bin/env bash

set -euo pipefail

printf "\nSubmodule check...\n"
git submodule update --init
printf "Submodule is checked out at commit: $(git submodule status)\n\n"

echo "Setting up Python dependencies..."
python3 --version

# Check for uv first (faster), then fall back to pip
if command -v uv &> /dev/null; then
    echo "Using uv to install dependencies..."
    uv add -r requirements.txt
else
    echo "Using pip to install dependencies..."
    pip install -r requirements.txt || pip3 install -r requirements.txt
fi

cd ./bdk-ffi/bdk-ffi/

rustup target add x86_64-apple-darwin

echo "Generating native binaries..."
cargo build --profile release-smaller --target x86_64-apple-darwin

echo "Generating bdk.py..."
cargo run --bin uniffi-bindgen generate --library ./target/x86_64-apple-darwin/release-smaller/libbdkffi.dylib --language python --out-dir ../../src/bdkpython/ --no-format

echo "Copying libraries libbdkffi.dylib..."
cp ./target/x86_64-apple-darwin/release-smaller/libbdkffi.dylib ../../src/bdkpython/libbdkffi.dylib

echo "All done!"
