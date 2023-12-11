#!/bin/bash

# ===| Setup |=================================================================

# Cat the file contents out.
cat ./"${BASH_SOURCE[0]}" && read -p "\nPress enter to continue...\n"

# =============================================================================

# ===| Main |==================================================================

mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

mkdir -pv $LFS/tools

# =============================================================================
