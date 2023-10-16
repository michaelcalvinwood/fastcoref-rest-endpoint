#!/bin/bash
sudo DEBIAN_FRONTEND="noninteractive" apt -y --assume-yes update
sudo DEBIAN_FRONTEND="noninteractive" apt -y --assume-yes upgrade
DEBIAN_FRONTEND="noninteractive" apt -y --assume-yes install python3-pip
DEBIAN_FRONTEND="noninteractive" apt -y --assume-yes install python3-venv

