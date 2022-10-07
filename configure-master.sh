#!/bin/bash
POSTGRES_CONF='/etc/postgresql/14/main/postgresql.conf'

sudo -u postgres psql -U postgres -d postgres -c "ALTER ROLE postgres PASSWORD 'password'"

sudo sed -i '/^# .*listen on a non-local/a host replication postgres 192.168.56.20/24 md5' /etc/postgresql/14/main/pg_hba.conf

sudo sed -i "s/.*listen_addresses.*/listen_addresses = 'localhost, 192.168.56.10'/" $POSTGRES_CONF
sudo sed -i "s/.*wal_level.*/wal_level = hot_standby/" $POSTGRES_CONF
sudo sed -i "s/.*archive_mode.*/archive_mode = on/" $POSTGRES_CONF
sudo sed -i "s/.*archive_command.*/archive_command = 'cd .'/" $POSTGRES_CONF
sudo sed -i "s/.*max_wal_senders.*/max_wal_senders = 8/" $POSTGRES_CONF
sudo sed -i "s/.*hot_standby.*/hot_standby = on/" $POSTGRES_CONF
sudo systemctl restart postgresql