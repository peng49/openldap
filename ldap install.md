### Step 1: 更新系统源
在一个全新的系统安装ldap,请确保系统已更新和升级
```
sudo apt -y update
sudo apt -y upgrade
sudo reboot
```

### Step 2: 安装OpenLDAP

> sudo apt -y install slapd ldap-utils

### Step 3: 为用户和组添加基本DN
下一步是为用户和组添加基本DN。创建一个名为basedn.ldif的文件
> vim basedn.ldif

内容如下
```
dn: ou=people,dc=fly-develop,dc=com
objectClass: fly-develop
ou: people

dn: ou=groups,dc=fly-develop,dc=com
objectClass: fly-develop
ou: groups
```

其中fly-develop和com是域组件，如**slapcat**命令所示。

保存文件后，使用下面的命令应用配置:

> sudo ldapadd -x -D cn=admin,dc=fly-develop,dc=com -W -f basedn.ldif

.......
Enter LDAP Password:
adding new entry "ou=people,dc=fly-develop,dc=com"                
adding new entry "ou=groups,dc=fly-develop,dc=com"

### Step 4: Add User Accounts and Groups
Generate a password for the user account to add.

> slappasswd

New password:
Re-enter new password:
{SSHA}5D94oKzVyJYzkCq21LhXDZFNZpPQD9uE
Create ldif file for adding users.

> vim ldapusers.ldif
```
dn: uid=jmutai,ou=people,dc=computingforgeeks,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
cn: Josphat
sn: Mutai
userPassword: {SSHA}5D94oKzVyJYzkCq21LhXDZFNZpPQD9uE
loginShell: /bin/bash
homeDirectory: /home/testuser
uidNumber: 3000
gidNumber: 3000
```

Replace jmutai with the username to add
dc=computingforgeeks,dc=com with your correct domain values.
cn & sn with your user details
{SSHA}5D94oKzVyJYzkCq21LhXDZFNZpPQD9uE with your hashed password generated.
Apply config:

> ldapadd -x -D cn=admin,dc=computingforgeeks,dc=com -W -f ldapusers.ldif

Enter LDAP Password:
adding new entry "uid=jmutai,ou=people,dc=computingforgeeks,dc=com"
A group is added in similar way.

Do the same of group. Create ldif file:

> cat ldapgroups.ldif
```
dn: cn=jmutai,ou=groups,dc=computingforgeeks,dc=com
objectClass: posixGroup
cn: jmutai
gidNumber: 3000
memberUid: jmutai
```

> ldapadd -x -D cn=admin,dc=computingforgeeks,dc=com -W -f ldapgroups.ldif


Enter LDAP Password:
adding new entry "cn=jmutai,ou=groups,dc=computingforgeeks,dc=com"
The two files can be combined into a single file.

### Step 5: Install LDAP Account Manager on Debian 10 (Buster)
We’ll install and use LDAP Account Manager as our OpenLDAP Server graphical management dashboard. LDAP Account Manager (LAM) is a web frontend for managing entries (e.g. users, groups, DHCP settings) stored in an LDAP director

Features of LDAP Account Manager
Manages Unix, Samba 3/4, Kolab 3, Kopano, DHCP, SSH keys, a group of names and much more
Has support for 2-factor authentication
Support for account creation profiles
CSV file upload
Automatic creation/deletion of home directories
setting file system quotas
PDF output for all accounts
schema and LDAP browser
manages multiple servers with different configurations
wget http://prdownloads.sourceforge.net/lam/ldap-account-manager_6.8-1_all.deb
sudo dpkg -i ldap-account-manager_6.8-1_all.deb
If you encounter errors during installation, run:

sudo apt -f install
sudo dpkg -i ldap-account-manager_6.8-1_all.deb

### Step 6: Configure LDAP Account Manager
Access  LDAP Account Manager web interface from a trusted machine network on

http://(server’s hostname or IP address)/lam
The LDAP Account Manager Login form will be shown. We need to set our LDAP server profile by clicking on[LAM configuration] at the upper right corner.

Then click on,Edit server profiles

ldap acount manager edit server profiles min
This will ask you for LAM Profile name Password:

ldap account manager default password min
Default password is lam
The first thing to change is Profile Password, this is at the end of General Settings page.

ldap account manager set profie password min
Next is to set LDAP Server address and Tree suffix. Mine looks like below, you need to use your Domain components as set in server hostname.

ldap account manager set server url suffix min
Set Dashboard login by specifying the admin user account and domain components under “Security settings” section.

ldap account manager set valid users min
Switch to “Account types” page and set Active account types LDAP suffix and List attributes.

ldap account manager set user groups min
You can also enable other available account types you wish to use. User and Group modules can be enabled and disabled on “Modules” page.

When done with the settings, click the Save button at the bottom of the page.

### Step 7: Add user accounts and groups with LDAP Account Manager
Login with the accountadmin to LAM dashboard to start managing user accounts and groups.

ldap account manager login interface min
You’ll use the Users and Groups links to manage user accounts and groups.

Add User Group
You need to add a user group before the actual user account. Click on Groups > New Group

ldap account manager add new user min
Give the group a name, optional group ID and description.

ldap account manager add new group min
Do the same to add other groups.

Add User Accounts
Once you have the groups for user accounts to be added, click on Users > New user to add a new user account to your LDAP server. You have three sections for user management:

Personal – This contains user’s personal information like the first name, last name, email, phone, department, address e.t.c
ldap account manager add new user set shell home min
Unix: This section is where you set the Username, Common name, UID number(optional), User comment, User Primary group, and Secondary groups, Home directory and the default Login shell.
ldap account manager add new user set shell home min 1
Shadow: This section is where you add Shadow account extension, things related to password aging/expiry.
ldap account manager add new user set password expiry min
You may have more sections depending on the Modules enabled for User and Group management.

Our next guide will cover how to configure the LDAP client on Debian 10 Buster. Also check:

How to Install and configure OpenLDAP Server on Ubuntu 18.04 LTS

Secure LDAP Server with SSL/TLS on Ubuntu