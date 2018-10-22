##When configuring HA for the NameNode, do not install
##hadoop-hdfs-secondarynamenode. After completing the HA software configuration,
## follow the installation instructions under Deploying HDFS High Availability.

#Cloudera recommends that you install (or update) and start a ZooKeeper cluster
#before proceeding. This is a requirement if you are deploying high availability
#(HA) for the NameNode.
sudo yum install zookeeper
#Installing the ZooKeeper Server Package and Starting ZooKeeper on a Single Serve
sudo yum install zookeeper-server
mkdir -p /var/lib/zookeeper
chown -R zookeeper /var/lib/zookeeper/
sudo service zookeeper-server init
sudo service zookeeper-server start

##Installing ZooKeeper in a Production Environment
sudo cat <<EOF >/home/vagrant/zoo.cfg
tickTime=2000
dataDir=/var/lib/zookeeper/
clientPort=2181
initLimit=5
syncLimit=2
server.1=zoo1:2888:3888
server.2=zoo2:2888:3888
server.3=zoo3:2888:3888
EOF
sudo mkdir -p /var/lib/zookeeper
sudo cp /home/vagrant/zoo.cfg /var/lib/zookeeper/zoo.cfg
sudo yum install zookeeper
sudo yum install zookeeper-server
#The file must contain only a single line, and that line must consist of a
#single unique number between 1 and 255; this is the id component mentioned in
# the previous step. In this example, the server whose hostname is zoo1 must
#  have a myid file that contains only 1.
sudo cat <<EOF >/home/vagrant/myid
1
EOF
sudo service zookeeper-server init
sudo service zookeeper-server start

##Resource Manager host (analogous to MRv1 JobTracker) running:
sudo yum clean all
sudo yum install hadoop-yarn-resourcemanager

##NameNode host running:
sudo yum clean all
sudo yum install hadoop-hdfs-namenode

##Secondary NameNode host (if used) running:
sudo yum clean all
sudo yum install hadoop-hdfs-secondarynamenode

##All cluster hosts except the Resource Manager running:
sudo yum clean all
sudo yum install hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce

##One host in the cluster running:
sudo yum clean all
sudo yum install hadoop-mapreduce-historyserver hadoop-yarn-proxyserver

##All client hosts running:
sudo yum clean all
sudo yum install hadoop-client
