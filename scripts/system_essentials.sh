sudo yum install python perl python-psycopg2 iproute -y

sudo yum install dnsmasq chrony -y
sudo echo 'net.ipv6.conf.all.disable_ipv6=1' >> /etc/sysctl.conf
sudo echo 'net.ipv6.conf.default.disable_ipv6=1' >> /etc/sysctl.conf
sudo sysctl -p

sudo cat <<EOF >/etc/dnsmaq.conf
server=8.8.8.8
server=8.8.4.4
listen-address= 192.168.100.101
domain=bigdata.es
address=/madbd00.bigdata.es/192.168.100.101
address=/master01.bigdata.es/192.168.100.11
address=/master02.bigdata.es/192.168.100.12

address=/0.centos.pool.ntp.org/85.199.214.98
ptr-record=101.100.168.192.in-addr.arpa.,maddb00.bigdata.es
ptr-record=11.100.168.192.in-addr.arpa,master01.bigdata.es
ptr-record=12.100.168.192.in-addr.arpa,master02.bigdata.es
ptr-record=21.100.168.192.in-addr.arpa,worker01.bigdata.es
EOF

sudo cat <<EOF >/etc/chronyd.conf
# Record the rate at which the system clock gains/losses time.
driftfile /var/lib/chrony/drift
# Allow the system clock to be stepped in the first three updates
# if its offset is larger than 1 second.
makestep 1.0 3
# Enable kernel synchronization of the real-time clock (RTC).
rtcsync
# Enable hardware timestamping on all interfaces that support it.
#hwtimestamp *
# Increase the minimum number of selectable sources required to adjust
# the system clock.
#minsources 2
# Allow NTP client access from local network.
allow 192.168.100.0/24
# Serve time even if not synchronized to a time source.
local stratum 10
# Specify file containing keys for NTP authentication.
#keyfile /etc/chrony.keys
EOF

sudo systemctl enable dnsmasq
sudo systemctl start dnsmasq
sudo systemctl enable chronyd
sudo systemctl start chronyd
