#!/bin/bash

#install nodejs
sudo apt-get update
sudo DEBIAN_FRONTEND="noninteractive" apt-get install -y --assume-yes ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
# NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo DEBIAN_FRONTEND="noninteractive" apt-get install nodejs -y --assume-yes

#install pm2
npm i pm2 -g -y

npm install -g -y npm@10.2.0

