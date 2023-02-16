#!/usr/bin/env bash
## CONSTANTS
GITHUB_URL="https://github.com/puiterwijk/system-configs"
GIT_URL="${GITHUB_URL}.git"
RAW_BASE="${GITHUB_URL}/raw/main/"

## CODE STARTS HERE
hostname=`hostname --short`

echo "Setting up for hostname: ${hostname}"

if [ -d /nix/store ];
then
    echo "Setting up NixOS system"
    SYSTEM_TYPE=nixos
    echo "nixos setup not done, needs redoing"
    exit 1
else
    echo "Setting up a traditional system"
    SYSTEM_TPYE=traditional

    sudo dnf install -y ansible
    curl --location --fail "${RAW_BASE}/playbooks/bootstrap.yml" | ansible-playbook /dev/stdin --extra-vars "setup_hostname=${hostname}"
    exec ansible-playbook $HOME/system-configs/playbooks/${hostname}.yml
fi
