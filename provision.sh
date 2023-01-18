sudo apt update

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt -y install postgresql-10

 доступ к серверу PostgreSQL
echo "------------- listen_addresses on postgresql.conf"
sudo sed -i "s/#listen_address.*/listen_addresses = '*'/" /etc/postgresql/10/main/postgresql.conf

echo "------------- postgres pg_hba.conf file"
sudo cat >> /etc/postgresql/10/main/pg_hba.conf <<EOF
host    all             all             0.0.0.0/0               md5
EOF

echo "--------------- перезапуск postgresql"
sudo systemctl restart postgresql

echo "---------------- Настройки параметров брандмауэра"
sudo ufw allow from any to any port 5432 proto tcp

echo "----------------- создание роли и логина"
sudo su postgres -c "psql -c \"CREATE ROLE vagrant SUPERUSER LOGIN PASSWORD 'vagrant'\" "

echo "------------------ создание db test"
sudo su postgres -c "createdb vagrant"