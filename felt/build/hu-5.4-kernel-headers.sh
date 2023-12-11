#!/bin/bash

# ===| Setup |=================================================================

# Cat the file contents out.
cat ./"${BASH_SOURCE[0]}" && read -p "*** Press enter to continue..."

PACKAGE_SOURCES=$LFS/sources
PACKAGE_BASEMAME=linux-6.4.12
PACKAGE_EXTENSION=.tar.xz

# =============================================================================

# ===| Main |==================================================================

cd $PACKAGE_SOURCES
tar -vxf $PACKAGE_BASEMAME$PACKAGE_EXTENSION
cd $PACKAGE_BASEMAME

make mrproper

make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr

# -----------------------------------------------------------------------------

rm -rfv $PACKAGE_SOURCES/$PACKAGE_BASEMAME 

# =============================================================================
