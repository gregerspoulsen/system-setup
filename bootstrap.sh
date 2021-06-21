#!/bin/bash
# SytUp Bootstrap Script
# 
# Arguments:
# 1: user
#    target user to apply the setup to, default is current user
# 2: user link
#    link for user repo to use, default is
#    https://github.com/gregerspoulsen/sys-setup-gp.git
# 3: extra_vars
#    extra_vars to pass to ansible provisioning

# Exit on error:
set -e

# Process arguements:
TARGET_USER=${1:-$USER}
USER_REPO=${2:-https://github.com/gregerspoulsen/sys-setup-gp.git}
MAIN_DIR=~"$TARGET_USER/sytup"
EXTRA_VARS=${3:-user=$TARGET_USER}

# Expand ~ in MAIN_DIR
if [ "${MAIN_DIR:0:1}" == \~ ]; then
    eval MAIN_DIR="$(printf '~%q' "${MAIN_DIR#\~}")"
fi

echo "Installing for user: $TARGET_USER at $MAIN_DIR"
echo "Using user repo: $USER_REPO"

# Create main dir if not excisting
sudo -u $TARGET_USER mkdir -p $MAIN_DIR

# Update System:
sudo apt update
sudo apt upgrade -y

# Install ansible:
sudo apt install -y python3-pip
sudo apt remove -y ansible # Pip cannot upgrade apt installed pkg as of 20210610
sudo pip3 install "ansible>=4"

# Install required galaxy roles
ansible-galaxy install sicruse.powerline-fonts gantsign.antigen oefenweb.locales gantsign.keyboard
# To enable the user to execute the plays when logged in, install for user:
#sudo -u $TARGET_USER ansible-galaxy install sicruse.powerline-fonts gantsign.antigen oefenweb.locales gantsign.keyboard

# Install git
sudo apt -y install git

# Deploy sytup base repo, skip if exist
if [[ -d "$MAIN_DIR/base" ]]
then
    echo "$MAIN_DIR/base already exists - left intact."
else
    sudo -u $TARGET_USER git clone https://github.com/gregerspoulsen/system-setup.git $MAIN_DIR/base
fi

# Deploy user repo, skip if exist
if [[ -d "$MAIN_DIR/user" ]]
then
    echo "$MAIN_DIR/user already exists - left intact."
else
    # Use first argument to script - if unset use gp:
    URL=$USER_REPO
    sudo -u $TARGET_USER git clone $URL $MAIN_DIR/user
fi

# Set correct owner of $MAIN_DIR
sudo chown -R $TARGET_USER:$TARGET_USER $MAIN_DIR
echo "running provisining with --extra-vars: $EXTRA_VARS"
ansible-playbook --extra-vars "$EXTRA_VARS" $MAIN_DIR/base/recipes/basic.yaml
