#!/bin/bash

# Cat the file contents out.
cat ./"${BASH_SOURCE[0]}"
read -p "Press enter to continue..."

# The script ==================================================================
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

mkdir -pv $LFS/tools
