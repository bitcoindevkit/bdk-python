#!/usr/bin/env bash

set -euo pipefail

printf "\nSubmodule check...\n"
git submodule update --init
printf "Submodule is checked out at commit: $(git submodule status)\n\n"

echo "Setting up Python dependencies..."
${PYBIN}/python --version
${PYBIN}/pip install -r requirements.txt

cd ./bdk-ffi/bdk-ffi/

rustup default 1.84.1

echo "Generating native binaries..."
cargo build --profile release-smaller

echo "Generating bdk.py..."
cargo run --bin uniffi-bindgen generate --library ./target/release-smaller/libbdkffi.so --language python --out-dir ../../src/bdkpython/ --no-format

echo "Copying linux libbdkffi.so..."
cp ./target/release-smaller/libbdkffi.so ../../src/bdkpython/libbdkffi.so

echo "All done!"
