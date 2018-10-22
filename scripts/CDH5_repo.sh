sudo usermod -aG wheel vagrant
sudo yum clean all
sudo curl "https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo" -o /etc/yum.repos.d/cloudera-cdh5.repo
sudo cul  "https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo" -o /etc/yum.repos.d/cloudera-manager.repo
sudo yum update -y
sudo systemctl stop firewalld
