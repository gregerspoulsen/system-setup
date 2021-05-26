#!/bin/bash
# Bootstrap system setup. The first argument to this script can be a
# url for the personal repo to use.

# Exit on error:
set -e

# Create main dir if not excisting
sudo mkdir -p /sys-setup
sudo chown $USER:$USER /sys-setup

# Install bootstrap dependenciess
./install_git.sh
./install_ansible.sh

# Deploy sys-setup repo, skip if exist
if [[ -d "/sys-setup/base" ]]
then
    echo "/sys-setup/base already exists - left intact."
else
    git clone https://github.com/gregerspoulsen/system-setup.git /sys-setup/base
fi

# Deploy personal repo, skip if exist
if [[ -d "/sys-setup/personal" ]]
then
    echo "/sys-setup/personal already exists - left intact."
else
    # Use first argument to script - if unset use gp:
    URL=${1:-https://github.com/gregerspoulsen/sys-setup-gp.git}  
    git clone $URL /sys-setup/personal
fi

