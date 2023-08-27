--This script prepares a MySQL server
CREATE DATABASE IF NOT EXISTS hbnb_dev_db;

--This creates a new user
CREATE USER IF NOT EXISTS 'hbnb_dev'@'localhost' IDENTIFIED BY 'hbnb_dev_pwd';

--Grant privileges
GRANT ALL PRIVILEGES ON hbnb_dev_db . * TO 'hbnb_dev'@'localhost';
GRANT SELECT TO performance_schema . * ON 'hbnb_dev'@'localhost';
