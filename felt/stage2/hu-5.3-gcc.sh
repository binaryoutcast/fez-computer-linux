#!/bin/bash

# ===| Setup |=================================================================

# Cat the file contents out.
cat ./"${BASH_SOURCE[0]}" && read -p "*** Press enter to continue..."

PACKAGE_SOURCES=$LFS/sources
PACKAGE_BASEMAME=gcc-13.2.0
PACKAGE_EXTENSION=.tar.xz
PACKAGE_EXT_GZ=.tar.gz

PACKAGE_MPFR=mpfr-4.2.0
PACKAGE_GMP=gmp-6.3.0
PACKAGE_MPC=mpc-1.3.1

# =============================================================================

# ===| Main |==================================================================

cd $PACKAGE_SOURCES
tar -vxf $PACKAGE_BASEMAME$PACKAGE_EXTENSION
cd $PACKAGE_BASEMAME

# -----------------------------------------------------------------------------

tar -vxf ../$PACKAGE_MPFR$PACKAGE_EXTENSION
mv -v $PACKAGE_MPFR mpfr

tar -vxf ../$PACKAGE_GMP$PACKAGE_EXTENSION
mv -v $PACKAGE_GMP gmp

tar -vxf ../$PACKAGE_MPC$PACKAGE_EXT_GZ
mv -v $PACKAGE_MPC mpc

# -----------------------------------------------------------------------------

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac

# -----------------------------------------------------------------------------

mkdir -v build
cd build

../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=2.38 \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --enable-default-pie      \
    --enable-default-ssp      \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++

make && make install

# -----------------------------------------------------------------------------

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h

# -----------------------------------------------------------------------------

rm -rfv $PACKAGE_SOURCES/$PACKAGE_BASEMAME 

# =============================================================================
