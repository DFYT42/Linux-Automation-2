#!/bin/bash
##https://github.com/nic-instruction/hello-nti-310/blob/master/automate.md
#GCloud
##TEST
##sudo su
tail -f /var/messages

#already has git installed
#Setup for final
git clone https://github.com/DFYT42/Linux-Automation-2/

#Create seven instances
##LOGSERVER##
gcloud compute instances create rsyslog-server-test \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
#--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=ldap-rsyslog.sh
gcloud compute instances create postgres-server-test \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=postgres.sh
gcloud compute instances create ldap-server-test \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=ldap-server.sh
gcloud compute instances create nfs_server_automation-test \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nfs_server_automation.sh




