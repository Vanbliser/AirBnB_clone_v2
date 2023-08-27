-This script prepares a MySQL server
CREATE DATABASE IF NOT EXISTS hbnb_test_db;

--This creates a new user
CREATE USER IF NOT EXISTS 'hbnb_test'@'localhost' IDENTIFIED BY 'hbnb_test_pwd';

--Grant privileges
GRANT ALL PRIVILEGES ON hbnb_test_db . * TO 'hbnb_test'@'localhost';
GRANT SELECT TO performance_schema . * ON 'hbnb_test'@'localhost';
