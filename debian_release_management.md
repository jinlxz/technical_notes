Debian release management
--
## Debian release
Each debian release or build version contains a comprehend set of software with specific version number, each release has a code name, e.g. `buster`, `strech`, ..., also there are some special names for tracking debian releases as follows:
- `stable` represents the latest stable debian release, current `stable` release is buster, stable release will become into the next stable release when the next stable release is release.
- `testing` represent the release will be released as the next stable release, it contains more newer version of softwares in the previous stable release and more software, it is under testing.
- `unstable` represent the release being in development.

## Debian backport
Debian backport is a special distribution which contains newer version of software in stable release, these software is usually included in current testing release and built in the stable release environment, thus underlying libraries are not upgraded, each stable release has a backport release, the backport release will be frozen when the next stable release is published as all packages in the backport repository will be included in the current testing release and delivered as next stable release.

backport sloppy distribution will be opened when the next stable release is published as the backport release is frozen, it can include packages in new testing release.

## use packages in backport and sloppy distribution
users can use packages in backport and sloppy distribution by adding a package source in the configuration file `source.list`


