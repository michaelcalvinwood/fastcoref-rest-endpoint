# Installation Instructions

## Setup a fresh Ubuntu 22.04 server

Go to Digital Ocean, Linode, Vultr, etc. and create an Ubuntu 22.04 instance.

**Important:** The server needs a minimum of 2GB RAM and 25GB disk.

## Get a host name

If you do not have a host name, you can create a free hostname at https://no-ip.com.

## Point the DNS A Record

Using your DNS provider (or no-ip.com), assign the Ubuntu 22.04 IP address to your hostname. In other words, create an A record to map the hostname to the server IP address.

## Login to your Ubuntu server

ssh root@{hostname}

## Make a config directory

mkdir config

cd config

## Install git

sudo DEBIAN_FRONTEND="noninteractive" apt -y --assume-yes install git

## Clone the github repository

git clone https://github.com/michaelcalvinwood/fastcoref-rest-endpoint.git

cd fastcoref-rest-endpoint

## Modify the python file if you want to change the host or port
If you want the REST Endpoint to be a localhost service, edit fastcoref_rest_endpoint.py (replace 0.0.0.0 with 127.0.0.1).

If you want the REST Endpoint to run on a different port, edit fastcoref_rest_endpoint.py (replace 5005 with the desired port number). Then, in the terminal, execute the following command: ufw allow {port}/tcp

## Run the setup scripts
chmod +x *.sh

./setup-linux.sh {hostname} {databasePassword} {emailAddress}

./install-fastcoref.sh




