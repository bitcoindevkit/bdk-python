# bdkpython

The Python language bindings for the [bitcoindevkit](https://github.com/bitcoindevkit).

See the [package on PyPI](https://pypi.org/project/bdkpython/).

# Working with the submodule

This repository uses the bdk-ffi repository as a git submodule. Here are useful tips for working with the submodule:

1. When initially cloning the repo, the `bdk-ffi` submodule will be empty locally. You can intitiate/populate the directory by using the `just submodule-init` command.
2. If you make local changes to the `bdk-ffi` directory while developing and want to hard delete all changes and return to the exact committed version hash of the bdk-ffi repo, use the `just submodule-reset` command.

## Local Testing and Usage

1. Start a Python virtual environment
2. Run one of the build script
3. Create the wheel
4. Install the library
5. Run the tests

```sh
source .localpythonenv/bin/activate

bash scripts/generate-macos-arm64.sh

python3 -m build --wheel --outdir dist --verbose 

pip3 install ./dist/bdkpython-<yourversion>.whl --force-reinstall

python3 -m unittest --verbose
```

## Build HTML API Documentation (Optional)

6. Generate docs
7. Build HTML Documentation

```sh
python3 ./docs/generate_docs.py

python3 -m sphinx -b html -W --keep-going -v docs/source docs/_build/html
```