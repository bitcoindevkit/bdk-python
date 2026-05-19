# bdkpython

The Python language bindings for the [bitcoindevkit](https://github.com/bitcoindevkit).

See the [package on PyPI](https://pypi.org/project/bdkpython/).

# Working with the submodule

This repository uses the bdk-ffi repository as a git submodule. Here are useful tips for working with the submodule:

1. When initially cloning the repo, the `bdk-ffi` submodule will be empty locally. You can intitiate/populate the directory by using the `just submodule-init` command.
2. If you make local changes to the `bdk-ffi` directory while developing and want to hard delete all changes and return to the exact committed version hash of the bdk-ffi repo, use the `just submodule-reset` command.

## Local Testing and Usage

1. Run one of the build script (skip the submodule update if you are making local changes to the bdk-ffi submodule)
2. Sync dependencies with `uv`
3. Create the wheel
4. Install the library
5. Run the tests

```sh
# If you made changes to the bdk-ffi submodule and wish to use those instead of the committed hash
bash scripts/generate-macos-arm64.sh --skip-submodule-update
# Otherwise
bash scripts/generate-macos-arm64.sh

uv sync
uv build --wheel -v
uv pip install ./dist/bdkpython-<yourversion>.whl --force-reinstall
uv run python -m unittest --verbose
```

## Build HTML API Documentation (Optional)

6. Generate docs
7. Build HTML Documentation

```sh
uv run python ./docs/generate_docs.py
uv run python -m sphinx -b html -W --keep-going -v docs/source docs/_build/html
```
