sudo yum install hbase-master -y
sudo service hbase-master start
sudo systemctl enable hbase-master
curl http://localhost:60010
sudo systemctl stop firewalld
