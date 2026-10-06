---
name: "Release"
about: "Create a new release [for release managers only]"
title: "Release MAJOR.MINOR.PATCH"
---

## Todo list for publishing the release

- [ ] Create a new branch off of `master` called `release/<feature version>`, e.g. `release/3.1`
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

- [ ] Update library version from `.dev` version to release version.
- [ ] PR the changes above (submodule tag bump + library version bump) above and merge.
- [ ] Create the tag for the release and make sure to add a link to the bdk-ffi changelog to the tag. See below for the template of the message we use for tags in this repository.

```shell
git tag v3.0.0 --sign --edit
```

```md
Release 3.0.0

For details on this release, see the bdk-ffi repository and [our release notes for the 3.0.0 release](https://github.com/bitcoindevkit/bdk-ffi/releases/tag/v3.0.0) as well as our [Changelog](https://github.com/bitcoindevkit/bdk-ffi/blob/master/CHANGELOG.md).
```

- [ ] Push the tag to GitHub, and let the CI run all tests one more time.

```shell
git push upstream v3.0.0
```

- [ ] Trigger release through the workflow dispatch with the new tag.
