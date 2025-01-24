-- create user.sql

CREATE USER 'andrea'@'%' IDENTIFIED BY '..Andr3+a17v,n';
GRANT ALL PRIVILEGES ON gamesatin.* TO 'andrea'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
