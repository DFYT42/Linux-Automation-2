#!/bin/bash
# based off of https://www.tecmint.com/configure-ldap-client-to-connect-external-authentication
# with some additions that make it work, as opposed to not work

#If ldap.secret file exists, then do not run
if [ -e /etc/ldap.secret]; then

  exit 0;

fi

#Do not need to sudo in bc runs as root
#apt-get update get newest information for packages from repositories
apt-get update
#apt-get install installs package(s) listed
#-y confirms the installation question, which would normally pause the install
apt-get install -y debconf-utils

#Suspend interactive GUI
export DEBIAN_FRONTEND=noninteractive
#install with confirmation package(s) listed
apt-get --yes install libnss-ldap libpam-ldap ldap-utils nscd
#activates interactive GUI so it will prompt
unset DEBIAN_FRONTEND

#write following configurations to file tempfile
echo "ldap-auth-config ldap-auth-config/bindpw password
nslcd nslcd/ldap-bindpw password
ldap-auth-config ldap-auth-config/rootbindpw password
ldap-auth-config ldap-auth-config/move-to-debconf boolean true
nslcd nslcd/ldap-sasl-krb5-ccname string /var/run/nslcd/nslcd.tkt
nslcd nslcd/ldap-starttls boolean false
libpam-runtime libpam-runtime/profiles multiselect unix, ldap, systemd, capability
nslcd nslcd/ldap-sasl-authzid string
ldap-auth-config ldap-auth-config/rootbinddn string cn=ldapadm,dc=nti310,dc=local
nslcd nslcd/ldap-uris string ldap://nti320-final-ldapserver
nslcd nslcd/ldap-reqcert select
nslcd nslcd/ldap-sasl-secprops string
ldap-auth-config ldap-auth-config/ldapns/ldap_version select 3
ldap-auth-config ldap-auth-config/binddn string cn=proxyuser,dc=example,dc=net
nslcd nslcd/ldap-auth-type select none
nslcd nslcd/ldap-cacertfile string /etc/ssl/certs/ca-certificates.crt
nslcd nslcd/ldap-sasl-realm string
ldap-auth-config ldap-auth-config/dbrootlogin boolean true
ldap-auth-config ldap-auth-config/override boolean true
nslcd nslcd/ldap-base string dc=nti310,dc=local
ldap-auth-config ldap-auth-config/pam_password select md5
nslcd nslcd/ldap-sasl-mech select
nslcd nslcd/ldap-sasl-authcid string
ldap-auth-config ldap-auth-config/ldapns/base-dn string dc=nti310,dc=local
ldap-auth-config ldap-auth-config/ldapns/ldap-server string ldap://nti320-final-ldapserver
nslcd nslcd/ldap-binddn string
ldap-auth-config ldap-auth-config/dblogin boolean false" >> tempfile

#while reading configurations in tempfile, echo each line into debconf-set-selections configurations
while read line; do echo "$line" | debconf-set-selections; done < tempfile

#echo ldap server pwd to ldap secret
echo "P@ssw0rd1" > /etc/ldap.secret

#elevate permissions for the ldap.secret file to read/write so the pwd can be passed for server access
chown 600 /etc/ldap.secret
#configures client to use ldap
sudo auth-client-config -t nss -p lac_ldap
#so we don't have to use a pwd to su to dif users
echo "account sufficient pam_succeed_if.so uid = 0 use_uid quiet" >> /etc/pam.d/su

#need to modify /etc/ldap.conf file with base, ldap, and rootbind info
sed -i 's/base dc=example,dc=net/base dc=nti310,dc=local/g' /etc/ldap.conf
sed -i 's,uri ldapi:///,uri ldap://nti320-final-ldapserver,g' /etc/ldap.conf
sed -i 's/rootbinddn cn=manager,dc=example,dc=net/rootbinddn cn=ldapadm,dc=nti310,dc=local/g' /etc/ldap.conf

#need to restart and enable changes to system
systemctl restart nscd
systemctl enable nscd
