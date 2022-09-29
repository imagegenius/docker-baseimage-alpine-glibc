## docker-baseimage-alpine-glibc

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/baseimage-alpine-glibc) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/baseimage-alpine-glibc?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-baseimage-alpine-glibc/actions?query=workflow%3A"Auto+Builder+CI")

A custom base image built with [Alpine Linux][appurl], [glibc][glibcurl] and [s6 overlay][s6overlay]

To those who say *why install glibc on alpine? :unamused:*
I say the resulting images are still almost 50% smaller with no tradeoffs

## Credits

-   [sgerrand/alpine-pkg-glibc](https://github.com/sgerrand/alpine-pkg-glibc) for the glibc packages

[appurl]: https://alpinelinux.org
[glibcurl]: https://www.gnu.org/software/libc/
[s6overlay]: https://github.com/just-containers/s6-overlay
