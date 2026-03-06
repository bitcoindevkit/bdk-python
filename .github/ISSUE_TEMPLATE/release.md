---
name: "Release"
about: "Create a new release [for release managers only]"
title: "Release MAJOR.MINOR.PATCH"
---

- [ ] Bump the bdk-ffi submodule to the release tag in bdk-ffi.
- [ ] Delete the `dist`, `build`, and `bdkpython.egg-info` and rust `target` directories to make sure you are building the library from scratch without any caches.
- [ ] Build the library.

```shell
just clean
bash ./scripts/generate-macos-arm64.sh # run the script for your particular platform
just build
```

- [ ] Run the tests and adjust if necessary

```shell
just install
just test
```

- [ ] Update the readme if necessary
- [ ] Create a new branch off of `master` called `release/<feature version>`, e.g. `release/0.31`
- [ ] Update library version from `.dev` version to release version
- [ ] Create the tag for the release and make sure to add a link to the bdk-ffi changelog to the tag. See below for the template of the message we use for tags in this repository.

```shell
git tag v0.6.0 --sign --edit
```

```md
Release 2.3.1

See https://github.com/bitcoindevkit/bdk-ffi/releases/tag/v2.3.1 and https://github.com/bitcoindevkit/bdk-ffi/releases/tag/v2.3.0 as well as our changelog at https://github.com/bitcoindevkit/bdk-ffi/blob/master/CHANGELOG.md for release details.
```

- [ ] Push the tag to GitHub, and let the CI run all tests one more time.

```shell
git push upstream v0.6.0
```

- [ ] Trigger release through the workflow dispatch with the new tag.
