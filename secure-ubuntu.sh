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
apt-get update
apt-get install -y ufw iptables unattended-upgrades

# Run
#################################
msg "Enabeling & Configuring Automatic Security Updates"
sed -i '3 s/\/\///' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '46 s/\/\///' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '46 s/false/true/' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '50 s/\/\///' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '50 s/false/true/' /etc/apt/apt.conf.d/50unattended-upgrades
cat > /etc/apt/apt.conf.d/02periodic <<EOL
APT::Periodic::Enable "1";
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOL
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
