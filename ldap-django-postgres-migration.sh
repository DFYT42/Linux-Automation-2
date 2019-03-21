#!/bin/bash

##########BASED ON##########
###based on tutorial: https://github.com/nic-instruction/hello-nti-310/blob/master/postgres.md
###https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-django-application-on-centos-7
#sudo su
yum install -y python-pip
pip install virtualenv
pip install --upgrade pip
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

#vim ~/myproject/myproject/settings.py
#below cannot be sed or perled in
perl -i -pe 's/DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}/DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'myproject',
        'USER': 'myprojectuser',
        'PASSWORD': 'password',
        'HOST': 'postgres-b',
        'PORT': '5432',
    }
}/g' ~/myproject/myproject/settings.py

#setting up machine to run as client rsyslog to server rsyslog
#install this on a server
#rsyslog should be first server sun up
#client automation
sudo yum update -y && yum install -y rsyslog 	#CentOS 7
sudo systemctl start rsyslog
sudo systemctl enable rsyslog
#on the client
#add to end of file
echo "*.* @@ldap-rsyslog-1:514" >> /etc/rsyslog.conf
#subnet
#10.142.0.0/32
python manage.py makemigrations
python manage.py migrate
