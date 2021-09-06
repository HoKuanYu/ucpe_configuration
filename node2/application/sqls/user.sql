CREATE USER 'admin'@'%' IDENTIFIED BY 'ucpe';
GRANT ALL PRIVILEGES ON ccio.* TO 'admin'@'%';
GRANT ALL PRIVILEGES ON ospos.* TO 'admin'@'%';
CREATE USER 'repliuser'@'%' IDENTIFIED BY 'ucpe';
GRANT REPLICATION SLAVE ON *.* TO 'repliuser'@'%';
FLUSH PRIVILEGES;

