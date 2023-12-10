#!/bin/bash

# Sources are being sent to LFS sysroot
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources

# Download all the sources
wget --input-file=../resources/wget-list-sysv --continue --directory-prefix=$LFS/sources

# Verify integrity of sources
pushd $LFS/sources
  md5sum -c md5sums
popd

# Set ownership
chown root:root $LFS/sources/*
