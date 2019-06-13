#!/bin/bash

##########BASED ON##########
###based on tutorial: https://github.com/nic-instruction/hello-nti-310/blob/master/postgres.md
###https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-django-application-on-centos-7
#sudo su
yum install -y epel-release
yum install -y python-pip
pip install virtualenv
pip install --upgrade pip
yum install -y telnet

mkdir ~/myproject
cd ~/myproject

##install virtual python envitroinment to safely upgrade system python whenever we need to 
#creates that environment for us and change into environment
virtualenv myprojectenv
source myprojectenv/bin/activate
#install Django with pip and install the psycopg2 package to us use the database configured
pip install django psycopg2
#create a child directory of the same name to hold the code itself, 
#and will create a management script within the current directory
django-admin.py startproject myproject .

#setting up machine to run as rsyslog client to server rsyslog
#install this on a server
#rsyslog should be first server run up
#rsyslog client automation
yum update -y && yum install -y rsyslog 	#CentOS 7

systemctl enable rsyslog
systemctl start rsyslog

#on the rsyslog client
#add to end of file
echo "*.* @@nti320-final-logserver:514" >> /etc/rsyslog.conf

#subnet
#10.142.0.0/32
python manage.py makemigrations
python manage.py migrate

wget -O ~/myproject/myproject/settings.py https://github.com/DFYT42/Linux-Automation-2/blob/master/settings.py
