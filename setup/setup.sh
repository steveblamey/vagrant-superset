#!/bin/bash
DBNAME="superset"
DBROLE="superset"
DBPASS="superset"
ADMINUSER="admin"
ADMINPASS="admin"

# Install prequisites
sudo apt-get update
sudo apt-get -y install build-essential libssl-dev libffi-dev python3-dev python-pip libsasl2-dev libldap2-dev
sudo apt-get -y install python3-venv
sudo apt-get -y install postgresql

# postgresql configs
sudo echo "listen_addresses = '*'" >> /etc/postgresql/10/main/postgresql.conf
sudo cp /vagrant/setup/pg_hba.conf /etc/postgresql/10/main/pg_hba.conf
sudo systemctl restart postgresql.service

# Create a virtualenv and install superset and requirements
cd ~
python3 -m venv ./env
source env/bin/activate
pip install --upgrade setuptools pip
pip install apache-superset
pip install psycopg2-binary

# Create a postgres role and database
sudo -u postgres psql -c "CREATE ROLE ${DBROLE} WITH LOGIN PASSWORD '${DBPASS}'"
sudo -u postgres createdb -O $DBROLE $DBNAME

# Create supset config and set its location
cp /vagrant/setup/superset_config.py ~/superset_config.py
echo "export SUPERSET_CONFIG_PATH=/home/vagrant/superset_config.py" >> ~/.bashrc
export SUPERSET_CONFIG_PATH=/home/vagrant/superset_config.py

# Set-up the superset database
fabmanager create-admin --app superset --username $ADMINUSER --password $ADMINPASS --firstname admin --lastname user --email ss@example.com
superset db upgrade
superset init
