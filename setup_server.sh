#!/bin/bash

# Create new user "codeagency" with SSH key
useradd -m -s /bin/bash codeagency
mkdir -p /home/codeagency/.ssh
cp /root/.ssh/codeagency_key.pub /home/codeagency/.ssh/authorized_keys
chown -R codeagency:codeagency /home/codeagency/.ssh

# Add user "codeagency" to sudo and docker groups
usermod -aG sudo codeagency
usermod -aG docker codeagency

# Update and upgrade packages
apt-get update
apt-get upgrade -y

# Enable unattended upgrades
apt-get install -y unattended-upgrades
dpkg-reconfigure --priority=low unattended-upgrades

# Install Docker and Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker codeagency
systemctl enable docker
systemctl start docker
apt-get install -y docker-compose
echo "Welcome to the server! This is a custom MOTD message." > /etc/motd
apt-get install -y build-essential wget curl git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
cargo install du-dust
sudo apt install ctop


