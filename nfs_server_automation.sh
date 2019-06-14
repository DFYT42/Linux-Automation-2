#!/bin/bash
############AUTOMATE NFS SERVER INSTALL############
###https://www.howtoforge.com/nfs-server-and-client-on-centos-7
yum -y install nfs-utils


############CREATE PLACE TO HOUSE STUFF############
mkdir /var/nfsshare 
mkdir /var/nfsshare/devstuff 
mkdir /var/nfsshare/testing 
mkdir /var/nfsshare/home_dirs

############OPEN TO ALL FOR PROBLEM SOLVING: READING, WRITING, EXECUTING############
###enables root to read through newly
chmod -R 777 /var/nfsshare/

############ENABLE AND STARTING SERVICES TO RUN AT BOOT############
#for service in rpcbind nfs-server nfs-lock nfs-idmap; do echo "systemctl enable $service"; done
#for service in rpcbind nfs-server nfs-lock nfs-idmap; do systemctl start $service; done
#for service in rpcbind nfs-server nfs-lock nfs-idmap; do systemctl enable $service; done
#for service in rpcbind nfs-server nfs-lock nfs-idmap; do systemctl start $service; done
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap

############SHARE NFS DIRECTORY WITH NETWORK############
cd /var/nfsshare/

#####EXPORT NFS CFG FILES#####
echo "/var/nfsshare/home_dirs *(rw,sync,no_all_squash)
/var/nfsshare/devstuff  *(rw,sync,no_all_squash)
/var/nfsshare/testing   *(rw,sync,no_all_squash)" >> /etc/exports

#####REATSART NFS-SERVER#####
systemctl restart nfs-server

#####INSTALL NET-TOOLS TO USE IFCONFIG CMD#####
yum -y install net-tools
##HOW TO TEST: FROM CLIENT, AS ROOT--showmount -e $ipaddress

#grabs the current internal ip that is needed for client install
ifconfig -a | awk 'NR==2{ sub(/^[^0-9]*/, "", $2); printf "This is your Ip Address: %s\n", $2; exit }'

#setting up machine to run as rsyslog client to server rsyslog
#install this on a server
#rsyslog should be first server run up
#rsyslog client automation
yum update -y && yum install -y rsyslog 	#CentOS 7
systemctl start rsyslog
systemctl enable rsyslog
#on the rsyslog client
#add to end of file
echo "*.* @@10.138.0.204:514" >> /etc/rsyslog.conf

#restart rsyslog
sudo systemctl restart rsyslog
