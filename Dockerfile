FROM vcxpz/baseimage-alpine:latest

# environment settings
ARG GLIBC_RELEASE
ENV LANG=C.UTF-8

RUN set -xe && \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
      curl \
      wget && \
   curl -o \
      /etc/apk/keys/sgerrand.rsa.pub \
      "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" && \
   cd /tmp && \
   wget \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_RELEASE}/glibc-${GLIBC_RELEASE}.apk" \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_RELEASE}/glibc-bin-${GLIBC_RELEASE}.apk" \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_RELEASE}/glibc-i18n-${GLIBC_RELEASE}.apk" && \
   echo "**** install runtime packages ****" && \
   apk add --no-cache \
      glibc-${GLIBC_RELEASE}.apk \
      glibc-bin-${GLIBC_RELEASE}.apk \
      glibc-i18n-${GLIBC_RELEASE}.apk && \
   cd / && \
   /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true && \
   echo "export LANG=$LANG" >/etc/profile.d/locale.sh && \
   echo "**** cleanup ****" && \
   apk del \
      glibc-i18n && \
   apk del --purge \
      build-dependencies && \
   rm -rf \
      /etc/apk/keys/sgerrand.rsa.pub \
      /root/.wget-hsts \
      /tmp/*
