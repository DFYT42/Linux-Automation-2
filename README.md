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

Answer the following questions:

1) What is NFS?
-Network File System
-Remote file system that users and programs can access common files

2) What is Samba?
-Windows component
-integrates Unix devices into AD environments
-can be a domain controller or member

3) When would you use an NFS system and when would you use a SMB system for your network?
-NFS for Unix/Linux
-SMB for Windows

4) What is the purpose of centralizing files on a network file system?
-multiple users, devices, or programs can access the same files remotely and from different systems

5) How does LDAP integrate with NFS?
-LDAP provides authentication

6) What does "stateful" mean?  What about "stateless"?
-statefull 
--connections remain open and logs activity
--maintains original input and all subsequent input for all output
-stateless do not maintain the connection or historical inout information

7) What are some of the benefits of using NFS4 over NFS3?
-Security
-ease of use because do not need as many protocols to bind to

8) What do nfsstat and netstat each do?
-nfsstat - shows statistics abouut the nfs server
-netstat - displays TCP connections, routing, networking, ports in all their states, etc.

9) What is automounting?  Why is it used?
-automounting is when file systems are automatically installed based on anither programs activities
-is used to autoinstall and complete installations, when programs are found missing, to complete the task
