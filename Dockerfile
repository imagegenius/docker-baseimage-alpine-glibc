# syntax=docker/dockerfile:1

FROM ghcr.io/imagegenius/baseimage-alpine:3.19

# set version label
ARG BUILD_DATE
ARG VERSION
ARG GLIBC_VERSION
LABEL build_version="ImageGenius Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydazz"

# ld-linux-x86-64.so.2 -> /usr/glibc-compat/lib/ld-linux-x86-64.so.2
# https://github.com/sgerrand/alpine-pkg-glibc/pull/180

RUN \
  echo "**** install packages ****" && \
  if [ -z ${GLIBC_VERSION} ]; then \
    GLIBC_VERSION=$(curl -sL "https://packages.imagegenius.io/v3.19/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
      && awk '/^P:'"glibc"'$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
  fi && \
  apk add --no-cache --force-overwrite \
    glibc==${GLIBC_VERSION} \
    glibc-bin==${GLIBC_VERSION} \
    glibc-i18n==${GLIBC_VERSION} && \
  (/usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true) && \
  echo "export LANG=C.UTF-8" >/etc/profile.d/locale.sh && \
  ln -fs /usr/glibc-compat/lib/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2 && \
  echo "**** cleanup ****" && \
  apk del \
    glibc-i18n && \
  rm -rf \
    /tmp/*
