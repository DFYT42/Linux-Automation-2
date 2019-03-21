#!/bin/bash
#Using Ubuntu
###LDAP CLIENT###
apt-get install ldap-client

showmount -e ldap_server_automation-test
mkdir /mnt/test
echo "10.142.0.3/var/ldapshare/testing       /mnt/test   ldap  defaults 0 0" >> /etc/fstab
mount -a

#Need to ifconfig the ipaddess?
