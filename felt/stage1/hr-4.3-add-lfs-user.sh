#!/bin/bash

# Create LFS User
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

# Grant lfs full access to all the directories under $LFS by making lfs the owner
chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac
