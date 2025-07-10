#!/usr/bin/env bash

set -euo pipefail

echo "Making sure the submodule is initialized..."
git submodule update --init --recursive

echo "Setting up Python dependencies..."
python3 --version
pip install -r requirements.txt

cd ./bdk-ffi/bdk-ffi/
git checkout v1.2.0

rustup default 1.84.1
rustup target add x86_64-pc-windows-msvc

echo "Generating native binaries..."
cargo build --profile release-smaller --target x86_64-pc-windows-msvc

echo "Generating bdk.py..."
cargo run --bin uniffi-bindgen generate --library ./target/x86_64-pc-windows-msvc/release-smaller/bdkffi.dll --language python --out-dir ../src/bdkpython/ --no-format

echo "Copying libraries bdkffi.dll..."
cp ./target/x86_64-pc-windows-msvc/release-smaller/bdkffi.dll ../src/bdkpython/bdkffi.dll

echo "All done!"
