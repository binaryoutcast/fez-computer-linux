#!/bin/bash

# ===| Setup |=================================================================

# Cat the file contents out.
cat ./"${BASH_SOURCE[0]}" && read -p "*** Press enter to continue..."

PACKAGE_SOURCES=$LFS/sources
PACKAGE_BASEMAME=coreutils-9.3
PACKAGE_EXTENSION=.tar.xz

# =============================================================================

# ===| Main |==================================================================

cd $PACKAGE_SOURCES
tar -vxf $PACKAGE_BASEMAME$PACKAGE_EXTENSION
cd $PACKAGE_BASEMAME

# -----------------------------------------------------------------------------

./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --enable-install-program=hostname \
            --enable-no-install-program=kill,uptime \
            gl_cv_macro_MB_CUR_MAX_good=y

make
make DESTDIR=$LFS install

mv -v $LFS/usr/bin/chroot $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' $LFS/usr/share/man/man8/chroot.8

# -----------------------------------------------------------------------------

rm -rfv $PACKAGE_SOURCES/$PACKAGE_BASEMAME 

# =============================================================================
