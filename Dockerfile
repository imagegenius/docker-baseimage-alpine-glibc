FROM hydaz/baseimage-alpine:latest

# environment settings
ARG VERSION

# ld-linux-x86-64.so.2 -> /usr/glibc-compat/lib/ld-linux-x86-64.so.2
# https://github.com/sgerrand/alpine-pkg-glibc/pull/180

RUN  \
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
	for i in glibc glibc-bin glibc-i18n; do \
		curl -o \
        	/tmp/${i}-${VERSION}.apk -L \
        	"https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${VERSION}/${i}-${VERSION}.apk"; \
    	apk add --force-overwrite /tmp/${i}-${VERSION}.apk; \
	done && \
	(/usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true) && \
	echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
	ln -fs /usr/glibc-compat/lib/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2 && \
	echo "**** cleanup ****" && \
	apk del \
		build-dependencies \
		glibc-i18n && \
	rm -rf \
		/etc/apk/keys/sgerrand.rsa.pub \
		/tmp/*
