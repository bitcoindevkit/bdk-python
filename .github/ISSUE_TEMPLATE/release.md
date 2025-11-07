---
name: "Release"
about: "Create a new release [for release managers only]"
title: "Release MAJOR.MINOR.PATCH"
---

- [ ] Bump the bdk-ffi submodule to the release tag in bdk-ffi.
- [ ] Delete the `dist`, `build`, and `bdkpython.egg-info` and rust `target` directories to make sure you are building the library from scratch without any caches.
- [ ] Start the virtual environment.
- [ ] Build the library.

```shell
just clean
source .localpythonenv/bin/activate
pip install --requirement requirements.txt
bash ./scripts/generate-macos-arm64.sh # run the script for your particular platform
just build
```

- [ ] Run the tests and adjust if necessary

```shell
pip3 install ./dist/bdkpython-<yourversion>-py3-none-any.whl --force-reinstall
python -m unittest --verbose
```

- [ ] Update the readme if necessary
- [ ] Create a new branch off of `master` called `release/<feature version>`, e.g. `release/0.31`
- [ ] Update library version from `.dev` version to release version
- [ ] Create the tag for the release and make sure to add a link to the bdk-ffi changelog to the tag. Push the tag to GitHub.

```shell
git tag v0.6.0 --sign --edit
git push upstream v0.6.0
```

- [ ] Trigger release through the workflow dispatch with the new tag.
