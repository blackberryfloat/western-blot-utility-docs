# Western Blot Utility (WBU) Docs

This is a centralized public platform for the Western Blot Utility community to provide feedback and get support.

## Documentation

This repo is for user facing documentation of the Western Blot Utility only. All documentation should exist as markdown files in the src folder. 

## Local Host

- [make sure Rust is installed](https://www.rust-lang.org/tools/install)
- [make sure mdbook is installed](https://rust-lang.github.io/mdBook/guide/installation.html)
- download the repo
- open repo in terminal
- in the root repo run `mdbook serve` and then in a parallel terminal `mdbook build && tools/post_build.sh`
- open local host url in browser (printed in stdout by mdbook serve)
- refresh after each rebuild

## Contribution

Anyone and everyone that is a user of the Western Blot Utility is encouraged to contribute to the documentation. If you find an issue with the docs please create an issues. For the best results, create a pull request with recommend changes that is linked to the created issue. It is recommended that most documentation updates be against the tip of main but if you have any documentation updates that are version specific, be sure to open a pull request against the branch representing that minor version (see release process below for more information).

The Western Blot Utility application itself is not open-source, but the documentation for it is. Unless you explicity state otherwise, any contribution intentionally submitted for inclusion in this repository shall be considered available for use by anyone in any context without any additional terms or conditions.

## Release Process

A release uses mdbook to generate a static website that gets hosted as a GitHub page.

Releases are managed through both git tags and branches. Branches are used for convenience and tags actually trigger the relevant release actions. Whenever there is a new major or minor release a branch must be created at the relevant hash in the format v\<major\>.\<minor\> (ie v1.33). Branches with such a format are protected by a ruleset and can only be modified by admins. All release tags must point to hashes on said branch. There is also a ruleset protecting all git tags matching the semantic versioning format v*.*.\* so that only admins can add such tags.

### Major or Minor Release

In summary, you must be an admin and complete the following steps:

- pick a hash
- confirm all automated tests have passed
- confirm the post_build.sh has the correct version number documented
- create a branch at the relevant hash in the format v\<major\>.\<minor\> (ie v1.33).
- if necessary perform any last minuted changes
- create a git tag pointing to the tip of that branch in the format v\<major\>.\<minor\>.0 (ie v1.33.0).

The git tag will kick off an automated process that deploys the crate to crates.io after validating crate version matches the tag version and all automated tests pass.

### Hotfix

For a hotfix you merge a commit to the tip of the associated release branch and create a git tag with the relevant version numbering pointing to that new hash. Also add the changes to main if it has not been addressed there. 

