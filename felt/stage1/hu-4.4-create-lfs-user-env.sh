#!/bin/bash

# ===| Setup |=================================================================

# Cat the file contents out.
cat ./"${BASH_SOURCE[0]}" && read -p "\nPress enter to continue...\n"

# =============================================================================

# ===| Main |==================================================================

# Create Bash Profile
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

# -----------------------------------------------------------------------------

# Create Bash RC
cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE

alias dir='LC_COLLATE=C ls -halF --group-directories-first'
alias cls="clear"
alias edit="nano"
alias untar="tar -xf"
export PS1="\n(LFS Mount Point: \$LFS)\n\[\033[32m\]\u@\H \[\033[35m\]HOST-LINUX \[\033[33m\]\${PWD}\[\033[0m\]\n$ "
EOF

# -----------------------------------------------------------------------------

echo "\nPlease execute the last command in Chapter 4.4 manually."

# =============================================================================