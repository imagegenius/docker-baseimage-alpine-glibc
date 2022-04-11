FROM vcxpz/baseimage-alpine:latest

# environment settings
ARG VERSION

RUN set -xe && \
	echo "**** install build packages ****" && \
	apk add --no-cache --virtual=build-dependencies \
		jq && \
	if [ -z ${VERSION} ]; then \
		VERSION=$(curl -sL "https://api.github.com/repos/hydazz/docker-baseimage-alpine-glibc/releases/latest" | \
			jq -r '.tag_name'); \
	fi && \
	curl -o \
		/etc/apk/keys/sgerrand.rsa.pub \
		"https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" && \
	curl -o \
		/tmp/glibc-${VERSION}.apk -L \
		"https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${VERSION}/glibc-${VERSION}.apk" && \
	curl -o \
		/tmp/glibc-bin-${VERSION}.apk -L \
		"https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${VERSION}/glibc-bin-${VERSION}.apk" && \
	curl -o \
		/tmp/glibc-i18n-${VERSION}.apk -L \
		"https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${VERSION}/glibc-i18n-${VERSION}.apk" && \
	echo "**** install runtime packages ****" && \
	apk add --no-cache \
		/tmp/*.apk && \
	/usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
	echo "**** cleanup ****" && \
	apk del \
		build-dependencies \
		glibc-bin \
		glibc-i18n && \
	rm -rf \
		/etc/apk/keys/sgerrand.rsa.pub \
		/tmp/*
