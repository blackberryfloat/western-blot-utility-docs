# Western Blot Utility (WBU) Docs

This is a centralized public platform for the Western Blot Utility community to provide feedback and get support.

## Documentation

This repo is for user facing documentation of the Western Blot Utility only. All documentation should exist as markdown files in the docs folder. 

## Contribution

Anyone and everyone that is a user of the Western Blot Utility is encouraged to contribute to the documentation. If you find an issue with the docs please create an issues. For the best results, create a pull request with recommend changes.

That Western Blot Utility itself is not open-source but the documentation for it is. Unless you explicity state otherwise, any contribution intentionally submitted for inclusion in this repository shall be considered available for use by anyone in any context without any additional terms or conditions.

## Release Process

Releases are managed through both git tags and branches. Branches are used for convenience and tags actually trigger the relevant release actions. Whenever there is a new major or minor release a branch must be created at the relevant hash in the format v\<major\>.\<minor\> (ie v1.33). Branches with such a format are protected by a ruleset and can only be modified by admins. All release tags must point to hashes on said branch. There is also a ruleset protecting all git tags matching the semantic versioning format v*.*.\* so that only admins can add such tags.

### Major or Minor Release

In summary, you must be an admin and complete the following steps:

- pick a hash
- confirm all automated tests have passed
- create a branch at the relevant hash in the format v\<major\>.\<minor\> (ie v1.33).
- if necessary perform any last minuted changes
- create a git tag pointing to the tip of that branch in the format v\<major\>.\<minor\>.0 (ie v1.33.0).

The git tag will kick off an automated process that deploys the crate to crates.io after validating crate version matches the tag version and all automated tests pass.

