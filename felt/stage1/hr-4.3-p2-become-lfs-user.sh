#!/bin/bash

# Cat the file contents out.
cat ./"${BASH_SOURCE[0]}"
read -p "Press enter to continue..."

# The script ==================================================================

# Ensure LFS Var is set
if [[ -z "$LFS" ]]; then
  source ./hr-2.6-export-lfs-var.sh
fi

# Become LFS User..
su - lfs
