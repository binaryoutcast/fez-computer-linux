#!/bin/bash

# ===| Setup |=================================================================

# Cat the file contents out.
cat ./"${BASH_SOURCE[0]}" && read -p "*** Press enter to continue..."

PACKAGE_SOURCES=$LFS/sources
PACKAGE_BASEMAME=m4-1.4.19
PACKAGE_EXTENSION=.tar.xz

# =============================================================================

# ===| Main |==================================================================

cd $PACKAGE_SOURCES
tar -vxf $PACKAGE_BASEMAME$PACKAGE_EXTENSION
cd $PACKAGE_BASEMAME

# -----------------------------------------------------------------------------

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install

# -----------------------------------------------------------------------------

rm -rfv $PACKAGE_SOURCES/$PACKAGE_BASEMAME 

# =============================================================================
