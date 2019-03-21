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
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=ldap-rsyslog.sh
sleep 30s

##POSTGRES##
gcloud compute instances create nti310-final-postgres \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=postgres.sh
sleep 30s

##LDAPSERVER##
gcloud compute instances create nti310-final-ldapserver \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=ldap-server.sh
sleep 30s

##NFSSERVER##
gcloud compute instances create nti310-final-nfsserver \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nfs_server_automation.sh
sleep 30s

##DJANGOSERVER##
gcloud compute instances create nti310-final-django-the-j-is-silent-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=ldap-django-postgres-migration.sh

##CLIENTNFS##
#Ubuntu 1804 LTS#
gcloud compute instances create nti310-final-nfs-client \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nfs_client_automation.sh

##CLIENTLDAP##
#Ubuntu 1804 LTS#
gcloud compute instances create nti310-final-nfs-client \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west1-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=ldap-client-automation.sh


