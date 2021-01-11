[appurl]: https://alpinelinux.org
[s6overlay]: https://github.com/just-containers/s6-overlay
[glibcurl]: https://www.gnu.org/software/libc/

## docker-baseimage-alpine-glibc
[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/baseimage-alpine-glibc) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/baseimage-alpine-glibc?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-baseimage-alpine-glibc/actions?query=workflow%3A"Auto+Builder+CI")

**This image is not intended for public consumption**

A custom base image built with [Alpine Linux][appurl], [glibc][glibcurl] and [s6 overlay][s6overlay]

## Version Information
![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![s6 overlay](https://img.shields.io/badge/s6_overlay-2.1.0.2-blue?style=for-the-badge) ![glibc](https://img.shields.io/badge/glibc-2.32-blue?style=for-the-badge)

**[See here for a list of packages](https://github.com/hydazz/docker-baseimage-alpine-glibc/blob/main/package_versions.txt)**

## Credits
* [sgerrand/alpine-pkg-glibc](https://github.com/sgerrand/alpine-pkg-glibc) for the glibc packages
