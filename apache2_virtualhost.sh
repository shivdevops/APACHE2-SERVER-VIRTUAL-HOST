#!/bin/bash

echo -n "Provide Your Server or Domain  Name:"
read domainname;
echo -n "Provide virtual host conf name:"
read confname;
echo
echo -n "Provide your Directory Root or Path:"
read directorypath;
echo 
echo -n "Provide your ssl pem file path with file name:"
read sslpem;
echo
echo -n "Provide your ssl key file path with file name:"
read sslkey;
echo


mkdir -p $directorypath$domainname
touch /etc/apache2/sites-available/$confname.conf

cat > /etc/apache2/sites-available/$confname.conf <<EOF
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        ServerName $domainname
        ServerAlias www.$domainname
        DocumentRoot $directorypath$domainname


        <Directory $directorypath$domainname/>

                Options Indexes FollowSymLinks
                AllowOverride All
                Require all granted

        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

</VirtualHost>


<IfModule mod_ssl.c>
        <VirtualHost _default_:443>
        ServerAdmin webmaster@localhost
        ServerName $domainname
        ServerAlias www.$domainname
        DocumentRoot $directorypath$domainname


       <Directory $directorypath$domainname/>
               
           Options Indexes FollowSymLinks
           AllowOverride All
           Require all granted

       
        </Directory>


                ErrorLog \${APACHE_LOG_DIR}/error.log
                CustomLog \${APACHE_LOG_DIR}/access.log combined

                SSLEngine on
               SSLEngine on

                SSLCertificateFile     $sslpem
                SSLCertificateKeyFile  $sslkey

                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                                SSLOptions +StdEnvVars
                </FilesMatch>
                   
                <Directory /usr/lib/cgi-bin>
                               
                      SSLOptions +StdEnvVars
                
                </Directory>

        </VirtualHost>
</IfModule>

EOF

a2ensite $confname.conf -q
  a2enmod ssl -q
  systemctl reload apache2

echo  "Virtual Host Created sucessfully..! " >> /$directorypath$domainname/index.html
echo
echo "Virtual Host Created Sucessfully"
echo
echo "virtual host conf name: $confname.conf"
echo
echo "virtual host conf path: /etc/apache2/sites-available/$confname.conf"
echo
echo "Directory Root or Path and Directory Name for you domain: $directorypath$domainname"
echo
echo "check in your browser by:https://$domainname or check in your browser by:http://$domainname"
echo
