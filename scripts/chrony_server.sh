sudo yum install chrony -y
#configuracion de ntp para servidor de NTP
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
sudo systemctl enable chronyd
sudo systemctl start chronyd
echo 'Instalación chrony server ****************'
