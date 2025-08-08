[group("Repo")]
[doc("Default command; list all available commands.")]
@list:
  just --list --unsorted

[group("Repo")]
[doc("Open repo on GitHub in your default browser.")]
repo:
  open https://github.com/bitcoindevkit/bdk-ffi

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
  python3 -m build --wheel --verbose

[group("Build")]
[doc("Install the wheel locally (force reinstall).")]
install:
  pip3 install dist/bdkpython-*.whl --force-reinstall

[group("Submodule")]
[doc("Initialize bdk-ffi submodule to committed hash.")]
submodule-init:
  git submodule update --init

[group("Submodule")]
[doc("Hard reset the bdk-ffi submodule to committed hash.")]
submodule-reset:
  git submodule update --force

[group("Test")]
[doc("Run all tests.")]
test:
  python3 -m unittest --verbose
