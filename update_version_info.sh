#!/bin/bash

OVERLAY_VERSION=$(curl -sX GET "https://raw.githubusercontent.com/hydazz/docker-baseimage-alpine/main/version_info.json" | jq -r .overlay_version)
GLIBC_RELEASE=$(grep <package_versions.txt -E "glibc.*?-" | sed -n 1p | cut -c 7- | sed -E 's/-r.*//g')
OLD_OVERLAY_VERSION=$(jq <version_info.json -r .overlay_version)
OLD_GLIBC_RELEASE=$(jq <version_info.json -r .glibc_release)

sed -i \
	-e "s/${OLD_OVERLAY_VERSION}/${OVERLAY_VERSION}/g" \
	-e "s/${OLD_GLIBC_RELEASE}/${GLIBC_RELEASE}/g" \
	README.md

NEW_VERSION_INFO="overlay_version|glibc_release
${OVERLAY_VERSION}|${GLIBC_RELEASE}"

jq -Rn '
( input  | split("|") ) as $keys |
( inputs | split("|") ) as $vals |
[[$keys, $vals] | transpose[] | {key:.[0],value:.[1]}] | from_entries
' <<<"$NEW_VERSION_INFO" >version_info.json
