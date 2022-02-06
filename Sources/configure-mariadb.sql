CREATE DATABASE fusionsuite_db;
CREATE USER 'fusionsuite_user'@'localhost' IDENTIFIED BY 'StrongDBPassword';
GRANT ALL PRIVILEGES ON fusionsuite_db.* TO 'fusionsuite_user'@'localhost';
FLUSH PRIVILEGES;