#!/bin/bash

GLIBC=$(grep <package_versions.txt -E "glibc.*?-" | sed -n 1p | cut -c 7- | sed -E 's/-r.*//g')

sed -i -E \
	-e "s/glibc-.*?-blue/glibc-${GLIBC}-blue/g" \
	README.md
