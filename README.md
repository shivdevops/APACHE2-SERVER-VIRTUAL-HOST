# A Apache2 Server Virtual Host Automated Installation Shell Script.

 **Shell script for single domain apache2 server virtual host for ubuntu**
 
 * Download the script.
 
 * Change the file permission with 777 
   
    ` ` ` sudo chmod 777 apache2_virtualhost.sh ` ` `

 * Run the script with sudo.  

     ` ` ` sudo ./apache2_virtualhost.sh ` ` `


## Prerequistes:

* Ubuntu OS.
* Web Server apache2
* Apache2-LAMP installation link: https://github.com/shivdevops/LAMP-INSTALLATION-SHELL-SCRIPT

## Note:

* Provide your respective root folder path by replacing the **"your-root-directory-path"** Line No:4 in the shell script.(i.e /var/www/html or /opt/vhost)

* Provide any name for apache2 virtual host conf by replacing **"your-conf-name"** Line No: 7 in the shell script.

* Provide your respective domain name by replacing the **"your-domain-name"** Line No: 10 in the shell script.

* Provide your generated SSL pem file with full path by replacing the **"your-ssl-pem-file-path"**  Line No: 13 in the shell script.

* Provide you generated SSL key file with full path by replacing the **"your-ssl-key-file-path"** Line No:15 in the shell script.
