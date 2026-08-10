# bdkpython

The Python language bindings for the [bitcoindevkit](https://github.com/bitcoindevkit).

See the [package on PyPI](https://pypi.org/project/bdkpython/).

## Working with the submodule

This repository uses the bdk-ffi repository as a git submodule. Here are useful tips for working with the submodule:

1. When initially cloning the repo, the `bdk-ffi` submodule will be empty locally. You can initiate/populate the directory by using the `just submodule-init` command.
2. If you make local changes to the `bdk-ffi` directory while developing and want to hard delete all changes and return to the exact committed version hash of the bdk-ffi repo, use the `just submodule-reset` command.

## Local Testing and Usage

1. Run one of the build scripts (skip the submodule update if you are making local changes to the `bdk-ffi` submodule)
2. Sync dependencies with `uv`
3. Create the wheel
4. Install the library
5. Run the tests

### 1. Build Script Commands

Run the build script corresponding to your operating system:

**Linux**:

```sh
bash scripts/generate-linux.sh
```

**macOS (Apple Silicon / ARM64)**:

```sh
bash scripts/generate-macos-arm64.sh
```

**macOS (Intel / x86_64)**:

```sh
bash scripts/generate-macos-x86_64.sh
```

**Windows (Git Bash / MSYS2)**:

```sh
bash scripts/generate-windows.sh
```

*Note: Pass `--skip-submodule-update` if you are making local changes to `bdk-ffi` and wish to preserve them instead of resetting to the committed submodule hash.*

### 2–5. Setup, Build, Install & Test Commands

```sh
# Sync dependencies with uv
uv sync

# Create the wheel
uv build --wheel -v

# Install the library
uv pip install ./dist/bdkpython-*.whl --force-reinstall

# Run the tests
uv run python -m unittest --verbose
```

## Build HTML API Documentation (Optional)

1. Generate docs
2. Build HTML Documentation

```sh
uv run python ./docs/generate_docs.py
uv run python -m sphinx -b html -W --keep-going -v docs/source docs/_build/html
```
