sudo yum install epel-release python perl python-psycopg2 iproute -y
sudo yum install lsof vim -y
sudo echo 'net.ipv6.conf.all.disable_ipv6=1' >> /etc/sysctl.conf
sudo echo 'net.ipv6.conf.default.disable_ipv6=1' >> /etc/sysctl.conf
sudo sysctl -p
sudo setenforce Permissive
sudo sed -i 's/enforcing/disabled/ /etc/sysconfig/selinux
sudo systemctl restart selinux
