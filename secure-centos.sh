#!/bin/bash

# Load Common
#################################
. ./common.sh

# VARS
#################################
# ...

# Checks
#################################
if [ $UID -ne 0 ]; then
  echo "Need to be ran as root." >&2
  exit 1
fi

# Update & Install Deps
#################################
msg "Updating, Upgrading & Installing Dependencies."
yum -y update
yum install -y yum-cron ufw

# Run
#################################
msg "Enabeling & Configuring Automatic Security Updates"
# TODO: Update config file
systemctl enable yum-cron
systemctl start yum-cron
systemctl status yum-cron
echo "Done."

msg "Configuring & Enabeling Firewall (UFW) :"
yes | ufw reset
ufw default reject incoming
ufw default reject routed
ufw default allow outgoing
ufw logging full
ufw allow https/tcp
ufw allow http/tcp
ufw allow $SYSTEM_SSH_PORT/tcp
ufw limit $SYSTEM_SSH_PORT/tcp
yes | ufw enable
ufw status numbered verbose
