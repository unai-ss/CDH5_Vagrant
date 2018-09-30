sudo yum install python perl python-psycopg2 iproute -y
sudo yum install dnsmasq lsof vim -y
sudo echo 'net.ipv6.conf.all.disable_ipv6=1' >> /etc/sysctl.conf
sudo echo 'net.ipv6.conf.default.disable_ipv6=1' >> /etc/sysctl.conf
sudo sysctl -p

sudo cat <<EOF >/etc/dnsmaq.conf
server=8.8.8.8
server=8.8.4.4
listen-address= 192.168.100.10
domain=bigdata.es
address=/servidorntp.bigdata.es/192.168.100.10
address=/manager.bigdata.es/192.168.100.10
address=/edget.bigdata.es/192.168.100.11
address=/dn01.bigdata.es/192.168.100.21
address=/dn02.bigdata.es/192.168.100.22
address=/dn03.bigdata.es/192.168.100.23

address=/0.centos.pool.ntp.org/85.199.214.98
ptr-record=10.100.168.192.in-addr.arpa.,manager.bigdata.es
ptr-record=10.100.168.192.in-addr.arpa.,servidorntp.bigdata.es
ptr-record=11.100.168.192.in-addr.arpa,egdet.bigdata.es
ptr-record=21.100.168.192.in-addr.arpa,dn01.bigdata.es
ptr-record=22.100.168.192.in-addr.arpa,dn02.bigdata.es
ptr-record=23.100.168.192.in-addr.arpa,dn03.bigdata.es
EOF

sudo systemctl enable dnsmasq
sudo systemctl start dnsmasq
