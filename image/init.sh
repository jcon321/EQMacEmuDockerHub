#!/bin/bash


echo "Initializing Database"
cd data/alkabor*

# expose mysql to all IPs (so host can directly talk to db)
sed -i 's/127\.0\.0\.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

service mariadb start 
echo "Drop and create database"
mariadb -e "DROP DATABASE IF EXISTS peq; \
	CREATE DATABASE peq; \
	CREATE USER IF NOT EXISTS 'peq'@'%' identified by 'peqpass'; \
	GRANT ALL PRIVILEGES on *.* to 'peq'@'%';"
echo "Sourcing alkabor..."
for f in alkabor_*.sql; do mariadb --database=peq -e "source $f"; done
echo "Sourcing data_tables..."
for f in data_tables_*.sql; do mariadb --database=peq -e "source $f"; done
echo "Sourcing login_tables..."
for f in login_tables_*.sql; do mariadb --database=peq -e "source $f"; done
echo "Sourcing player_tables..."
for f in player_tables_*.sql; do mariadb --database=peq -e "source $f"; done
echo "Sourcing loginserver..."
cd /src/loginserver/login_util && mariadb --database peq -e "source tblloginserversettings.sql"

echo "Sourcing local development scripts"
cd /src/.devcontainer/base/db/local && for f in *.sql; do mariadb --database=peq -e "source $f"; done


echo "Preparing environment"
cd /
mkdir src/build/bin/logs
mkdir src/build/bin/shared
echo "Symlinking Maps and quests"
ln -s /Maps src/build/bin/Maps
ln -s /quests src/build/bin/quests
echo "Copying static opcodes"
cp -Rup /src/loginserver/login_util/*.conf src/build/bin
cp -Rup /src/utils/patches/*.conf src/build/bin
echo "Copying env files"
cp -Rup /src/.devcontainer/base/eqemu_config.json src/build/bin
sed -i 's#/src/.devcontainer/bin/zone#/src/build/bin/zone#g' /src/build/bin/eqemu_config.json
cp -Rup /src/.devcontainer/base/login.ini src/build/bin

