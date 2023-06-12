#!/bin/bash
#Author       : Pakpahan
#DateCreated  : 20230301
#Notes        : Auto Install Openvpn in Ubuntu 20.04
sudo timedatectl set-timezone Asia/Jakarta
sudo apt update && apt -y install ca-certificates wget net-tools gnupg
sudo wget https://as-repository.openvpn.net/as-repo-public.asc -qO /etc/apt/trusted.gpg.d/as-repository.asc
sudo echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/as-repository.asc] http://as-repository.openvpn.net/as/debian focal main">/etc/apt/sources.list.d/openvpn-as-repo.list
sudo apt update && apt -y install openvpn-as &> /home/ubuntu/ovpn-password.txt