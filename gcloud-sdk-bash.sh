#!/bin/bash
##https://github.com/nic-instruction/hello-nti-310/blob/master/automate.md
#GCloud
##TEST
##sudo su
#tail -f /var/messages

#already has git installed
#Setup for final
#git clone https://github.com/DFYT42/Linux-Automation-2/

#Create seven instances
##LOGSERVER##
gcloud compute instances create nti310-final-logserver \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-a \
#--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=https://github.com/DFYT42/Linux-Automation-2/ldap-rsyslog.sh
sleep 30s

##POSTGRES##
gcloud compute instances create nti310-final-postgres \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=https://github.com/DFYT42/Linux-Automation-2/blob/master/postgres.sh

##LDAPSERVER##
#gcloud compute instances create nti310-final-ldapserver \
#--image-family centos-7 \
#--image-project centos-cloud \
#--zone us-east1-b \
#--tags "http-server","https-server" \
#--machine-type f1-micro \
#--scopes cloud-platform \
#--metadata-from-file startup-script=ldap-server.sh

##NFSSERVER##
#gcloud compute instances create nti310-final-nfsserver \
#--image-family centos-7 \
#--image-project centos-cloud \
#--zone us-east1-b \
#--tags "http-server","https-server" \
#--machine-type f1-micro \
#--scopes cloud-platform \
#--metadata-from-file startup-script=nfs_server_automation.sh

##DJANGOSERVER##
#gcloud compute instances create nti310-final-django-the-j-is-silent-server \
#--image-family centos-7 \
#--image-project centos-cloud \
#--zone us-east1-b \
#--tags "http-server","https-server" \
#--machine-type f1-micro \
#--scopes cloud-platform \
#--metadata-from-file startup-script=nfs_server_automation.sh

##CLIENTNFS##
#Ubuntu 1804 LTS#

##CLIENTLDAP##
#Ubuntu 1804 LTS#


