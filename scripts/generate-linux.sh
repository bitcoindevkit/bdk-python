#!/usr/bin/env bash

set -euo pipefail

echo "Making sure the submodule is initialized..."
git submodule update --init --recursive

echo "Setting up Python dependencies..."
${PYBIN}/python --version
${PYBIN}/pip install -r requirements.txt

cd ./bdk-ffi/bdk-ffi/
git checkout v1.2.0

rustup default 1.84.1

echo "Generating native binaries..."
cargo build --profile release-smaller

echo "Generating bdk.py..."
cargo run --bin uniffi-bindgen generate --library ./target/release-smaller/libbdkffi.so --language python --out-dir ../src/bdkpython/ --no-format

echo "Copying linux libbdkffi.so..."
cp ./target/release-smaller/libbdkffi.so ../src/bdkpython/libbdkffi.so

echo "All done!"
