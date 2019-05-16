#!/bin/bash

#already has git installed
#Setup for final
echo "clone repos"
#git clone https://github.com/DFYT42/Linux-Automation-2/
#sleep 30s
git clone https://github.com/DFYT42/Linux-Automation-3/
sleep 30s
##SETTING PROJECT##
echo "CREATING PROJECT"
gcloud config set project nti-320-networkmonitoring

#Create nine instances
##LOGSERVER##
echo "LOGSERVER"
gcloud compute instances create nti320-mt-logserver \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west2-a \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/g42dfyt/Linux-Automation-2/ldap-rsyslog.sh
sleep 30s

##POSTGRES##
echo "POSTGRES"
gcloud compute instances create nti320-mt-postgres \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west2-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/g42dfyt/Linux-Automation-2/postgres.sh
sleep 30s

##LDAPSERVER##
echo "LDAPSERVER"
gcloud compute instances create nti320-mt-ldapserver \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west2-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/g42dfyt/Linux-Automation-2/ldap-server.sh
sleep 30s

##NFSSERVER##
echo "NFSSERVER"
gcloud compute instances create nti320-mt-nfsserver \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west2-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/g42dfyt/Linux-Automation-2/nfs_server_automation.sh
sleep 30s

##DJANGOSERVER##
echo "DJANGOSERVER"
gcloud compute instances create nti320-mt-django-the-j-is-silent-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west2-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/g42dfyt/Linux-Automation-2/ldap-django-postgres-migration.sh
sleep 30s

##CLIENTNFS##
#Ubuntu 1804 LTS#
gcloud compute instances create nti320-mt-nfs-client \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west2-a \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/g42dfyt/Linux-Automation-2/nfs_client_automation.sh
sleep 30s

##CLIENTLDAP##
#Ubuntu 1804 LTS#
gcloud compute instances create nti320-mt-ldap-client \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west2-a \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/g42dfyt/Linux-Automation-2/ldap-client-automation.sh

##NAGIOS##
echo "NAGIOS"
gcloud compute instances create nagios-a \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west2-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/g42dfyt/Linux-Automation-3/nagios_install.sh
sleep 30s

##CACTI##
echo "CACTI"
gcloud compute instances create nti320-mt-cacti-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west2-a \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=/home/g42dfyt/Linux-Automation-3/cacti_install.sh
sleep 30s

##ADD SERVERS TO NAGIOS MONITORING##
bash /home/g42dfyt/Linux-Automation-3/for_loop.sh
sleep 30s
#for servername in $( gcloud compute instances list | awk '{print $1}' | sed "1 d" | grep -v nagios-a );  do 
#    echo $servername;
#    serverip=$( gcloud compute instances list | grep $servername | awk '{print $4}');
#    echo $serverip ;
#    bash /home/g42dfyt/Linux-Automation-3/scp_to_nagios.sh $servername $serverip
#done
#gcloud compute ssh --zone us-west2-a g42dfyt@nagios-a --command='sudo systemctl restart nagios'

##Not sure yet##
bash /home/g42dfyt/Linux-Automation-3/for_loop_for_nrpe_install.sh
sleep 30s
#for servername in $( gcloud compute instances list | awk '{print $1}' | sed "1 d" | grep -v nagios-a );  do 
#    gcloud compute ssh --zone us-west2-a g42dfyt@$servername --command='sudo yum -y install wget && sudo wget https://raw.githubusercontent.com/DFYT42/Linux-Automation-3/master/nagios-client-configuration.sh && sudo bash nagios-client-configuration.sh'
#done
