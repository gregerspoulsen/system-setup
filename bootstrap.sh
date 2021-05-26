#!/bin/bash
# SytUp Bootstrap Script
# Bootstrap the system setup. The first argument to this script can be a
# url for the personal repo to use.

# Exit on error:
set -e

# Create main dir if not excisting
sudo mkdir -p /sytup
sudo chown $USER:$USER /sytup

# Install ansible:
sudo apt install python3-pip
pip3 install --user ansible

# Install ansible:
sudo apt install git

# Deploy sytup base repo, skip if exist
if [[ -d "/sytup/base" ]]
then
    echo "/sytup/base already exists - left intact."
else
    git clone https://github.com/gregerspoulsen/system-setup.git /sytup/base
fi

# Deploy personal repo, skip if exist
if [[ -d "/sytup/personal" ]]
then
    echo "/sytup/personal already exists - left intact."
else
    # Use first argument to script - if unset use gp:
    URL=${1:-https://github.com/gregerspoulsen/sys-setup-gp.git}  
    git clone $URL /sytup/personal
fi

ansible-playbook -i localhost /sytup/base/recipes/basic.yaml