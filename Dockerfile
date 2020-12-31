FROM vcxpz/baseimage-alpine

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="glibc version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Alex Hyde"

RUN \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
      curl && \
   curl -o \
      /etc/apk/keys/sgerrand.rsa.pub \
      "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" && \
   curl -o \
      /tmp/glibc-${VERSION}.apk \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${VERSION}/glibc-${VERSION}.apk" && \
   curl -o \
      /tmp/glibc-bin-${VERSION}.apk \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${VERSION}/glibc-bin-${VERSION}.apk" && \
   curl -o \
      /tmp/glibc-i18n-${VERSION}.apk \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${VERSION}/glibc-i18n-${VERSION}.apk" && \
   echo "**** install runtime packages ****" && \
   apk add --no-cache \
      "/tmp/glibc-${VERSION}.apk" \
      "/tmp/glibc-bin-${VERSION}.apk" \
      "/tmp/glibc-i18n-${VERSION}.apk" && \
   /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true && \
   echo "export LANG=$LANG" > /etc/profile.d/locale.sh && \
   echo "**** cleanup ****" && \
   apk del --purge \
      glibc-i18n \
      build-dependencies && \
   rm -rf \
      /etc/apk/keys/sgerrand.rsa.pub \
      /tmp/*
