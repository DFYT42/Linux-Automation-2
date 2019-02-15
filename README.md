# Linux-Automation-2

LDAP Servers

What does LDAP stand for?
-Lightweight Diretory Access Protocol

Why is it used in large production environments?

-LDAP is a directory server with user information and properties

-LDAP allows employees, from multiple departments, 
to be identidfied and given access to use multiple applications within the orginization, 
based on their directory properties/group permissions.


What does it do?

-Acts as a central directory of user information,
that provides fast search results,
becuase the LDAP server mainly reads and returns information, 
with little writing, that can be time consuming,
and cut into the return response time.

-Allows applications to authorize access based on user identity and permissions
from its central directory information

-Acts as a measure of security that identifies and authorizes users


What is Kerberos?

-Kerberos is a different type of security measure that
uses time-stamped tickets to authenticate user access to applications

-Depends on Network Time Protocol (NTP) and Domain Name Service (DNS)

-Allows applications/servers/nodes to authenticate users by transmitting 
encrypted tickets, instead of passwords


Why is it used in production?

-To authenticate users over networks that may not be secure

-Can provide the Single Sign On (SSO) feature, 
which authenticates processes to servers/applications


What does it do?

-Kerberos is more secure because user passwords are not sent over the network

-Instead, an encrypted, time-stamped ticket is assigned by Kerberos and authenticated against the Kerberos server

-Uses authenticated tickets to access applications/resources, as long as ticket is valid,
and users do not have to reauthenticate every time
