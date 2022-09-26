#!/bin/bash

# https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-22-04
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04

# Users, Groups, Versions, Dirs
#*****************************************************************************
USERS=('dev' 'pj')
USERGROUPS=('sudo' 'www-data' 'docker' 'dev')
NVM_DIR="$HOME/.nvm"

# Set Env Vars
export NVM_VERSION=0.39.1
export NODE_VERSION=14.20.0
export NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules
export PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH


#*****************************************************************************
#*****************************************************************************
# Tools
#*****************************************************************************
TOOLS=(
	# Required Dev Tools
	'git'
	'mosh'
	'curl'
	'vim'
	'npm'
	'ufw'
	'build-essential'
	'certbot'
	'python3-certbot-dns-cloudflare'
	'sqlite3'

	# Helpful Tools but not critical
	'dtrx'
	'ncdu'
	'tig'
	'htop'
	'trash-cli'
	'tmux'
	'zsh'
	'silversearcher-ag'
	'finger'
	'bat'
	'direnv'
	'unzip'
)

# Tools that may be pre-installed that we'd like to remove
REMOVE_TOOLS=(
	'snapd'
	'apache'
	'mysql'
)

# Install Tools
sudo apt update && sudo upgrade -y
for TOOL in "${TOOLS[@]}"; do
	printf "sudo apt install ${TOOL} -y\n"
done

# Remove some tools that may be pre-installed
#*****************************************************************************
for TOOL in "${REMOVE_TOOLS[@]}"; do
	sudo systemctl mask ${TOOL}.service
done


#*****************************************************************************
#*****************************************************************************
# Install Docker
#*****************************************************************************
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce -y

# Install Docker-Compose
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.11.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose


#*****************************************************************************
#*****************************************************************************
# Setup Firewall
#*****************************************************************************
sudo ufw allow OpenSSH # SSH
sudo ufw allow 1337    # Backend
sudo ufw allow 2096    # Frontend
sudo ufw allow 80      # http
sudo ufw allow 8443    # https
sudo ufw enable
sudo ufw status


#*****************************************************************************
#*****************************************************************************
# Add Users, assign Groups, enable access
#*****************************************************************************
for USER in "${USERS[@]}"; do
	sudo adduser $USER

	# Add users to groups
	for GROUP in "${USERGROUPS[@]}"; do
		sudo usermod -aG $GROUP $USER
	done

	# Enable External Access for Users
	sudo rsync --archive --chown=${USER}:${USER} /root/.ssh /home/${USER}
done
