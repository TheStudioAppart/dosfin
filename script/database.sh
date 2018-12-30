#!/bin/bash 

DB="TheStudioAppart";
USER="user";
PASS="password";

echo "Create TheStudioAppart database";
echo "Create an admin user";

sudo mysql -uroot \
        -e "DROP DATABASE IF EXISTS $DB; \
        DROP USER IF EXISTS '$USER'@'localhost'; \
        CREATE DATABASE $DB COLLATE=utf8_general_ci; \
        CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASS'; \
        GRANT ALL PRIVILEGES ON *.* TO '$USER'@'localhost';";

echo "Create TheStudioAppart tables";
sudo mysql -uroot < CreateDatabaseAndTable.sql;

# TODO check if everything is correctly setup (Grosse blague, comme si j'allais le faire!).