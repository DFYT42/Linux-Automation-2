# Linux-Automation-2
<b>NTI 310</b>
<ul>
<li>Mid-Level Linux automation scripts for spinning up network devices.</li>
</ul>
<b>LDAP Servers</b>
<ul></ul>
<b>What does LDAP stand for?</b>
<li>Lightweight Diretory Access Protocol</li>
<ul></ul>
<b>Why is it used in large production environments?</b>
<li>LDAP is a directory server with user information and properties</li>
<li>LDAP allows employees, from multiple departments, to be identidfied and given access to use multiple applications within the orginization, based on their directory properties/group permissions.</li>
<ul></ul>
<b>What does it do?</b>
<li>Acts as a central directory of user information, that provides fast search results, becuase the LDAP server mainly reads and returns information, with little writing, that can be time consuming, and cut into the return response time</li>
<li>Allows applications to authorize access based on user identity and permissions from its central directory information</li>
<li>Acts as a measure of security that identifies and authorizes users</li>
<ul></ul>
<b>What is Kerberos?</b>
<li>Kerberos is a different type of security measure thatuses time-stamped tickets to authenticate user access to applications</li>
<li>Depends on Network Time Protocol (NTP) and Domain Name Service (DNS)</li>
<li>Allows applications/servers/nodes to authenticate users by transmitting encrypted tickets, instead of passwords</li>
<ul></ul>
<b>Why is it used in production?</b>
<li>To authenticate users over networks that may not be secure</li>
<li>Can provide the Single Sign On (SSO) feature, which authenticates processes to servers/applications</li>
<ul></ul>
<b>What does it do?</b>
<li>Kerberos is more secure because user passwords are not sent over the network</li>
<li>Instead, an encrypted, time-stamped ticket is assigned by Kerberos and authenticated against the Kerberos server</li>
<li>Uses authenticated tickets to access applications/resources, as long as ticket is valid, and users do not have to reauthenticate every time</li>
<ul></ul>
<b>What is NFS?</b>
<li>Network File System</li>
<li>Remote file system that users and programs can access common files</li>
<ul></ul>
<b>What is Samba?</b>
<li>Windows component</li>
<li>Integrates Unix devices into AD environments</li>
<li>Can be a domain controller or member</li>
<ul></ul>
<b>When would you use an NFS system and when would you use a SMB system for your network?</b>
<li>NFS for Unix/Linux</li>
<li>SMB for Windows</li>
<ul></ul>
<b>What is the purpose of centralizing files on a network file system?</b>
<li>Multiple users, devices, or programs can access the same files remotely and from different systems</li>
<ul></ul>
<b>How does LDAP integrate with NFS?</b>
<li>LDAP provides authentication</li>
<ul></ul>
<b>What does "stateful" mean?  What about "stateless"?</b>
<li>Statefull</li>
  <li>Connections remain open and logs activity</li>
  <li>Maintains original input and all subsequent input for all output</li>
  <li>Stateless do not maintain the connection or historical inout information</li>
<ul></ul>
<b>What are some of the benefits of using NFS4 over NFS3?</b>
<li>Security</li>
<li>Ease of use because do not need as many protocols to bind to</li>
<ul></ul>
<b>What do nfsstat and netstat each do?</b>
<li>nfsstat - shows statistics abouut the nfs server</li>
<li>netstat - displays TCP connections, routing, networking, ports in all their states, etc.</li>
<ul></ul>
<b>What is automounting?  Why is it used?</b>
<li>Automounting is when file systems are automatically installed based on anither programs activities</li>
<li>It is used to autoinstall and complete installations, when programs are found missing, to complete the task</li>
