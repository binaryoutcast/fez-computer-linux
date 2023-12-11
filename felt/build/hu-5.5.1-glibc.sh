#!/bin/bash

# ===| Setup |=================================================================

# Cat the file contents out.
cat ./"${BASH_SOURCE[0]}" && read -p "*** Press enter to continue..."

PACKAGE_SOURCES=$LFS/sources
PACKAGE_BASEMAME=glibc-2.38
PACKAGE_EXTENSION=.tar.xz

# =============================================================================

# ===| Main |==================================================================

cd $PACKAGE_SOURCES
tar -vxf $PACKAGE_BASEMAME$PACKAGE_EXTENSION
cd $PACKAGE_BASEMAME

# -----------------------------------------------------------------------------

case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

# -----------------------------------------------------------------------------

patch -Np1 -i ../glibc-2.38-fhs-1.patch

mkdir -v build
cd build

# -----------------------------------------------------------------------------

echo "rootsbindir=/usr/sbin" > configparms

../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=4.14               \
      --with-headers=$LFS/usr/include    \
      libc_cv_slibdir=/usr/lib

make
make DESTDIR=$LFS install

sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

# -----------------------------------------------------------------------------

rm -rfv $PACKAGE_SOURCES/$PACKAGE_BASEMAME 

# =============================================================================
