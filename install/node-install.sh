#!/bin/bash

# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04#option-3-installing-node-using-the-node-version-manager

NVM_VERSION=0.39.1
NODE_VERSION=14.20.0

printf "Installing Node, NPM, NVM, Yarn\n"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash
source $HOME/.bashrc
zsh $HOME/.zshrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install v$NODE_VERSION
node -v

sudo apt install npm -y
sudo npm install -g npm
sudo npm install -g yarn
