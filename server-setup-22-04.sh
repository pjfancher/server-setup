#!/bin/bash


##################################################################################################################
#
#	Do This First:
#	https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-22-04
#
##################################################################################################################

# USERS
#*****************************************************************************
USERS=('pj', 'dev')
GROUPS=('sudo' 'www-data' 'docker', 'dev')

# TOOLS
#*****************************************************************************
TOOLS=(
	# Required Dev Tools
	'git'
	'mosh'
	'curl'
	'vim'
	'build-essential'
	'certbot'
	'python3-certbot-dns-cloudflare'

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
#*****************************************************************************
REMOVE_TOOLS=(
	'snapd'
	'apache'
	'mysql'
)

#*****************************************************************************
#*****************************************************************************

printf "Setup Success!\n"
exit;

# Install Tools
#*****************************************************************************
sudo apt update

for TOOL in "${TOOLS[@]}"; do
	printf "sudo apt install ${TOOL} -y\n"
done

# Remove some tools that may be pre-installed
#*****************************************************************************
for TOOL in "${REMOVE_TOOLS[@]}"; do
	sudo systemctl mask ${TOOL}.service
done

# Install Docker
#*****************************************************************************
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce

# Install Docker-Compose
#*****************************************************************************
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.11.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose


# Add Users and assign Groups
#*****************************************************************************
for USER in "${USERS[@]}"; do
	sudo useradd -m $USER

	# Add users to groups
	for GROUP in "${GROUPS[@]}"; do
		sudo usermod -a -G $GROUP $USER
	done
done
