#!/bin/bash

#install git
yum install -y git

#cd into the tmp directory
cd /tmp

#clone personal repo from github
git clone https://github.com/DFYT42/Linux-Automation-2

#install server and client version of ldap software
yum -y install openldap-servers openldap-clients

#copy first software configuration in its primary installed location to second location
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG

#giving ownership from root to ldap bc ldap has to be owner of ldap daemon to get info
chown ldap. /var/lib/ldap/DB_CONFIG 

#enables ldap daemon slapd
systemctl enable slapd

#startsldap daemon slapd
systemctl start slapd

#install apache server
yum -y install httpd

#install web app for ldap server administration
yum -y install phpldapadmin

#Let's SELinux - know what is going on
#NSA to harden and secure Linux systems
#Apache connecct to ldap
setsebool -P httpd_can_connect_ldap on

#enables apache
systemctl enable httpd

#starts apache
syetmctl start httpd

#modifies our httpd.conf to access from external URL/apache server
sed -i 's,Require local,#Require local\n  Require all granted,g' /etc/httpd/conf.d/phpldapadmin.conf

#unalias cp because means something different than copy
unalias cp

#making backup in case something goes wrong
cp /etc/phpldapadmin/config.php /etc/phpldapadmin/config.php.orig

#copy config file from github repo as config file for phpladap admin web adminsitartion
cp /tmp/Linux-Automation-2/config.php /etc/phpldapadmin/config.php

#changes ownership of ldap:apache to local phpldapadmin
chown ldap:apache /etc/phpldapadmin/config.php

#restarts service after changing ownership
systemctl restart httpd.service

#making sure my stuff is working
echo "phpldapadmin is now up and running"
#making sure my stuff is working still
echo "we are configuring ldap and ldap admin"

#Generates and stores new passwords & restricts only root user to read
newsecret="P@ssw0rd1"

#stores password securely
newhash=$(slappasswd -s "$newsecret")

#sends passwd to root
echo -n "$newsecret" > /root/ldap_admin_pass

#gives read write access
chmod 0600 /root/ldap_admin_pass

#Becomes ldif and configures root domain
#is local
#takes old password and replaces with new
echo -e "dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=nti310,dc=local
\n
dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=ldapadm,dc=nti310,dc=local
\n
dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: $newhash" > db.ldif

#format to exchange and sync data
ldapmodify -Y EXTERNAL  -H ldapi:/// -f db.ldif

#Auth restriction from external
echo 'dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external, cn=auth" read by dn.base="cn=ldapadm,dc=nti310,dc=local" read by * none' > monitor.ldif

#format to exchange and sync data
ldapmodify -Y EXTERNAL -H ldapi:/// -f monitor.ldif

#Generates Certs
openssl req -new -x509 -nodes -out /etc/openldap/certs/nti310ldapcert.pem -keyout /etc/openldap/certs/nti310ldapkey.pem -days 365 -subj "/C=US/ST=WA/L=Seattle/O=SCC/OU=IT/CN=nti310.local"

#change ownership from ldap to local etc/.../cert file location
chown -R ldap. /etc/openldap/certs/nti*.pem

##Error [root@ldap-b tmp]# ldapmodify -Y EXTERNAL  -H ldapi:/// -f certs.ldif
#SASL/EXTERNAL authentication started
#SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
#SASL SSF: 0
#modifying entry "cn=config"
#ldap_modify: Other (e.g., implementation specific) error (80)
#Solved this error by switching 

#put keys inside ldap
echo -e "dn: cn=config
changetype: modify
replace: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/openldap/certs/nti310ldapkey.pem
\n
dn: cn=config
changetype: modify
replace: olcTLSCertificateFile
olcTLSCertificateFile: /etc/openldap/certs/nti310ldapcert.pem" > certs.ldif

##format to exchange and sync data
ldapmodify -Y EXTERNAL  -H ldapi:/// -f certs.ldif

#Test what certs are there: ldapsearch -Y EXTERNAL -H ldapi:/// -b cn=config | grep olcTLS
#Test to see if cert config works
slaptest -u

#let's us know it's working 
echo "it works"

#changes cp alias
unalias cp

##format to exchange and sync data
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif

##format to exchange and sync data
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif

##format to exchange and sync data
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif

#creates group and people structure base
#base.dif needs spaces but can't VIM during automation...so echo
echo -e "dn: dc=nti310,dc=local
dc: nti310
objectClass: top
objectClass: domain
\n
dn: cn=ldapadm,dc=nti310,dc=local
objectClass: organizationalRole
cn: ldapadm
description: LDAP Manager
\n
dn: ou=People,dc=nti310,dc=local
objectClass: organizationalUnit
ou: People
\n
dn: ou=Group,dc=nti310,dc=local
objectClass: organizationalUnit
ou: Group" > base.ldif

#Turn off SELinux to test
setenforce 0

#authenticate with this user and build org specifications from imported base.ldif
#authenticate sourcing from previously created passwd w -y
ldapadd -x -W -D "cn=ldapadm,dc=nti310,dc=local" -f base.ldif -y /root/ldap_admin_pass

#Create Groups
echo -e "# Generated by phpLDAPadmin (http://phpldapadmin.sourceforge.net) on January 25, 2019 3:08 am
# Version: 1.2.3
\n
version: 1
\n
# Entry 1: cn=towels,ou=Group,dc=nti310,dc=local
dn: cn=towels,ou=Group,dc=nti310,dc=local
cn: towels
gidnumber: 500
objectclass: posixGroup
objectclass: top
\n
# Entry 2: cn=42,ou=Group,dc=nti310,dc=local
dn: cn=42,ou=Group,dc=nti310,dc=local
cn: 42
gidnumber: 501
objectclass: posixGroup
objectclass: top
\n
# Entry 3: cn=hitchhiker,ou=Group,dc=nti310,dc=local
dn: cn=hitchhiker,ou=Group,dc=nti310,dc=local
cn: hitchhiker
gidnumber: 502
objectclass: posixGroup
objectclass: top" > /tmp/GroupAdd.ldif

#reads password and passes through
ldapadd -x -W -D "cn=ldapadm,dc=nti310,dc=local" -f /tmp/GroupAdd.ldif -y /root/ldap_admin_pass

#Create users
echo -e "# Generated by phpLDAPadmin (http://phpldapadmin.sourceforge.net) on January 25, 2019 2:15 am
# Version: 1.2.3
\n
version: 1
\n
# Entry 1: cn=Doug Lasa,ou=People,dc=nti310,dc=local
dn: cn=Doug Lasa,ou=People,dc=nti310,dc=local
cn: Doug Lasa
gidnumber: 500
givenname: Bob
homedirectory: /home/dlasa
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: Lasa
uid: dlasa
uidnumber: 1000
userpassword: {SHA}IjmeQt7XATM3GuSJWO44Jkd+d2g=
\n
# Entry 2: cn=Bob Miller,ou=People,dc=nti310,dc=local
dn: cn=Bob Miller,ou=People,dc=nti310,dc=local
cn: Bob Miller
gidnumber: 501
givenname: Bob
homedirectory: /home/bmiller
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: Miller
uid: bmiller
uidnumber: 1001
userpassword: {SHA}IjmeQt7XATM3GuSJWO44Jkd+d2g=
\n
# Entry 3: cn=Boy Kitten,ou=People,dc=nti310,dc=local
dn: cn=Boy Kitten,ou=People,dc=nti310,dc=local
cn: Boy Kitten
gidnumber: 502
givenname: Boy
homedirectory: /home/bkitten
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: Kitten
uid: bkitten
uidnumber: 1002
userpassword: {SHA}IjmeQt7XATM3GuSJWO44Jkd+d2g=
\n
# Entry 4: cn=Apple Orange,ou=People,dc=nti310,dc=local
dn: cn=Apple Orange,ou=People,dc=nti310,dc=local
cn: Apple Orange
gidnumber: 500
givenname: Apple
homedirectory: /home/aorange
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: Orange
uid: aorange
uidnumber: 1003
userpassword: {SHA}IjmeQt7XATM3GuSJWO44Jkd+d2g=
\n
# Entry 5: cn=Depressed Robot,ou=People,dc=nti310,dc=local
dn: cn=Depressed Robot,ou=People,dc=nti310,dc=local
cn: Depressed Robot
gidnumber: 502
givenname: Depressed
homedirectory: /home/drobot
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: Robot
uid: drobot
uidnumber: 1004
userpassword: {SHA}IjmeQt7XATM3GuSJWO44Jkd+d2g=
\n
# Entry 6: cn=Zaphod Beeblebrox,ou=People,dc=nti310,dc=local
dn: cn=Zaphod Beeblebrox,ou=People,dc=nti310,dc=local
cn: Zaphod Beeblebrox
gidnumber: 502
givenname: Zaphod
homedirectory: /home/zbeeblebrox
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: Beeblebrox
uid: zbeeblebrox
uidnumber: 1005
userpassword: {SHA}IjmeQt7XATM3GuSJWO44Jkd+d2g=" > /tmp/UserAdd.ldif

#reads password and passes through
ldapadd -x -W -D "cn=ldapadm,dc=nti310,dc=local" -f /tmp/UserAdd.ldif -y /root/ldap_admin_pass

#restart web application/apache
systemctl restart httpd

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
