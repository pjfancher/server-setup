# Server Setup Script Ubuntu 22.04 - September 2022

https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-22-04
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04
https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04

- `ssh root@[IP]`
- `git clone https://github.com/pjfancher/server-setup && cd server-setup && ./server-setup-22-04.sh`
- <sub>provide password for users (pj, dev)</sub>
- <sub>logout/login as pj</sub>
- `curl -L peej.io | bash`
- <sub>Run node-install.sh docker-compose-install.sh per user as neccessary.</sub>
- `git clone https://github.com/pjfancher/server-setup && cd server-setup/install/ && ./node-install.sh && ./docker-compose-install.sh && source ~/.zshrc`
