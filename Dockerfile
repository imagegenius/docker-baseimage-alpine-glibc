FROM vcxpz/baseimage-alpine

# environment settings
ARG VERSION
ENV LANG=C.UTF-8

RUN \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
      curl \
      wget && \
   curl -o \
      /etc/apk/keys/sgerrand.rsa.pub \
      "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" && \
   cd /tmp && \
   wget -q \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${VERSION}/glibc-${VERSION}.apk" \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${VERSION}/glibc-bin-${VERSION}.apk" \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${VERSION}/glibc-i18n-${VERSION}.apk" && \
   echo "**** install runtime packages ****" && \
   apk add --no-cache \
      glibc-${VERSION}.apk \
      glibc-bin-${VERSION}.apk \
      glibc-i18n-${VERSION}.apk && \
   /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true && \
   echo "export LANG=$LANG" > /etc/profile.d/locale.sh && \
   echo "**** cleanup ****" && \
   apk del \
      glibc-i18n && \
   apk del --purge \
      build-dependencies && \
   rm -rf \
      /etc/apk/keys/sgerrand.rsa.pub \
      /root/.wget-hsts \
      /tmp/*
