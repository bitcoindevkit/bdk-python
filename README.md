# bdkpython

The Python language bindings for the [bitcoindevkit](https://github.com/bitcoindevkit).

See the [package on PyPI](https://pypi.org/project/bdkpython/).

## Local Testing and Usage

1. Start a Python virtual environment
2. Run one of the build script
3. Create the wheel
4. Install the library
5. Run the tests

```sh
source .localpythonenv/bin/activate
bash scripts/generate-macos-arm64.sh
python3 setup.py bdist_wheel
pip3 install ./dist/bdkpython-<yourversion>.whl --force-reinstall
python3 -m unittest --verbose
```
