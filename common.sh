#!/bin/bash

# Common vars
SYSTEM_SSH_PORT="$(grep -i port /etc/ssh/sshd_config | grep -v '#' | cut -d' ' -f2 | tr -d [:space:])"

function msg {
  echo "########################################"
  echo $1
  echo "########################################"
}
