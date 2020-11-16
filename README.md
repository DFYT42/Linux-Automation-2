# Linux-Automation-2
<b>NTI 310</b>
<ul>
<li>Mid-Level Linux automation scripts for spinning up network devices.</li>
</ul>
<b>LDAP Servers</b>

What does LDAP stand for?
<li>Lightweight Diretory Access Protocol</li>

Why is it used in large production environments?
<li>LDAP is a directory server with user information and properties</li>
<li>LDAP allows employees, from multiple departments, to be identidfied and given access to use multiple applications within the orginization, based on their directory properties/group permissions.</li>

What does it do?
<li>Acts as a central directory of user information, that provides fast search results, becuase the LDAP server mainly reads and returns information, with little writing, that can be time consuming, and cut into the return response time</li>
<li>Allows applications to authorize access based on user identity and permissions from its central directory information</li>
<li>Acts as a measure of security that identifies and authorizes users</li>

What is Kerberos?
<li>Kerberos is a different type of security measure thatuses time-stamped tickets to authenticate user access to applications</li>
<li>Depends on Network Time Protocol (NTP) and Domain Name Service (DNS)</li>
<li>Allows applications/servers/nodes to authenticate users by transmitting encrypted tickets, instead of passwords</li>

Why is it used in production?
<li>To authenticate users over networks that may not be secure</li>
<li>Can provide the Single Sign On (SSO) feature, which authenticates processes to servers/applications</li>

What does it do?
<li>Kerberos is more secure because user passwords are not sent over the network</li>
<li>Instead, an encrypted, time-stamped ticket is assigned by Kerberos and authenticated against the Kerberos server</li>
<li>Uses authenticated tickets to access applications/resources, as long as ticket is valid, and users do not have to reauthenticate every time</li>

What is NFS?
<li>Network File System</li>
<li>Remote file system that users and programs can access common files</li>

What is Samba?
<li>Windows component</li>
<li>Integrates Unix devices into AD environments</li>
<li>Can be a domain controller or member</li>

When would you use an NFS system and when would you use a SMB system for your network?
<li>NFS for Unix/Linux</li>
<li>SMB for Windows</li>

What is the purpose of centralizing files on a network file system?
<li>Multiple users, devices, or programs can access the same files remotely and from different systems</li>

How does LDAP integrate with NFS?
<li>LDAP provides authentication</li>

What does "stateful" mean?  What about "stateless"?
<li>Statefull</li>
  <li>Connections remain open and logs activity</li>
  <li>Maintains original input and all subsequent input for all output</li>
  <li>Stateless do not maintain the connection or historical inout information</li>

What are some of the benefits of using NFS4 over NFS3?
<li>Security</li>
<li>Ease of use because do not need as many protocols to bind to</li>

What do nfsstat and netstat each do?
<li>nfsstat - shows statistics abouut the nfs server</li>
<li>netstat - displays TCP connections, routing, networking, ports in all their states, etc.</li>

What is automounting?  Why is it used?
<li>Automounting is when file systems are automatically installed based on anither programs activities</li>
<li>It is used to autoinstall and complete installations, when programs are found missing, to complete the task</li>
