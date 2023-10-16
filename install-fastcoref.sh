#!/bin/bash
ufw allow 5005/tcp
mkdir -p /home/nlpkit/python/services/fastcoref
cp fastcoref_rest_endpoint.py /home/nlpkit/python/services/fastcoref/
cd /home/nlpkit/python/services/fastcoref
python3 -m venv .
source ./bin/activate
pip install torch --no-cache-dir
pip install -U spacy
python -m spacy download en_core_web_sm
pip install fastcoref
pip install flask
pm2 start python fastcoref_rest_endpoint.py
deactivate


