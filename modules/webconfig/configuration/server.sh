#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2 git

sudo systemctl restart apache2
sudo git clone https://github.com/Azure-Samples/msdocs-flask-postgresql-sample-app.git