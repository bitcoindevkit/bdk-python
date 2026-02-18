[group("Repo")]
[doc("Default command; list all available commands.")]
@list:
  just --list --unsorted

[group("Repo")]
[doc("Open repo on GitHub in your default browser.")]
repo:
  open https://github.com/bitcoindevkit/bdk-python/

[group("Build")]
[doc("Remove all caches and previous builds to start from scratch.")]
clean:
  rm -rf ../bdk-ffi/target/
  rm -rf ./bdkpython.egg-info/
  rm -rf ./build/
  rm -rf ./dist/

[group("Build")]
[doc("Build the wheel using pyproject.toml (modern build system).")]
build:
  uv build --wheel -v

[group("Build")]
[doc("Install the wheel locally (force reinstall).")]
install:
  uv venv
  uv pip install dist/bdkpython-*.whl --force-reinstall

[group("Build")]
[doc("Build Sphinx api documentation.")]
api-docs:
  uv run python docs/generate_docs.py
  uv run python -m sphinx -b html -W --keep-going -v docs/source docs/_build/html

[group("Submodule")]
[doc("Initialize bdk-ffi submodule to committed hash.")]
submodule-init:
  git submodule update --init

[group("Submodule")]
[doc("Hard reset the bdk-ffi submodule to committed hash.")]
submodule-reset:
  git submodule update --force

[group("Submodule")]
[doc("Checkout the bdk-ffi submodule to the latest commit on master.")]
submodule-to-master:
  cd ./bdk-ffi/ \
  && git fetch origin \
  && git checkout master \
  && git pull origin master

[group("Test")]
[doc("Run all tests.")]
test:
  uv run python -m unittest --verbose
