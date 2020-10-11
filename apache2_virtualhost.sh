#!/bin/bash

# provide the root directory path (eg:/var/www/html/ or /opt/vhost/)
ROOT_DIRECTORY_PATH="your-root-directory-path"

#provide apache2 virtual host conf name
APACHE2_CONF_NAME="your-conf-name"

#provide your domain name i.e domain.com domain.in etc 
DOMAIN_NAME="your-domain-name"

#provide your ssl pem file path fully
SSL_PEM="your-ssl-pem-file-path"

#provide your ssl key file path fully
SSL_KEY="your-ssl-pem-file-path"

mkdir -p $ROOT_DIRECTORY_PATH$DOMAIN_NAME
touch /etc/apache2/sites-available/$APACHE2_CONF_NAME.conf

cat > /etc/apache2/sites-available/$APACHE2_CONF_NAME.conf <<EOF
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        ServerName $DOMAIN_NAME
        ServerAlias www.$DOMAIN_NAME
        Redirect  / https://www.$DOMAIN_NAME
        DocumentRoot $ROOT_DIRECTORY_PATH$DOMAIN_NAME


        <Directory $ROOT_DIRECTORY_PATH$DOMAIN_NAME/>

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
        ServerName $DOMAIN_NAME
        ServerAlias www.$DOMAIN_NAME
        DocumentRoot $ROOT_DIRECTORY_PATH$DOMAIN_NAME


       <Directory $ROOT_DIRECTORY_PATH$DOMAIN_NAME/>
               
           Options Indexes FollowSymLinks
           AllowOverride All
           Require all granted

       
        </Directory>


                ErrorLog \${APACHE_LOG_DIR}/error.log
                CustomLog \${APACHE_LOG_DIR}/access.log combined

                SSLEngine on
               SSLEngine on

                SSLCertificateFile     $SSL_PEM
                SSLCertificateKeyFile  $SSL_KEY
SSL_PEM
                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                                SSLOptions +StdEnvVars
                </FilesMatch>
                   
                <Directory /usr/lib/cgi-bin>
                               
                      SSLOptions +StdEnvVars
                
                </Directory>

        </VirtualHost>
</IfModule>

EOF

  a2ensite $APACHE2_CONF_NAME.conf -q
  a2enmod ssl -q
  systemctl reload apache2

echo  "Virtual Host Created sucessfully..! " >> /$ROOT_DIRECTORY_PATH$DOMAIN_NAME/index.html
echo
echo "Virtual Host Created Sucessfully"
echo
echo "virtual host conf name: $APACHE2_CONF_NAME
.conf"
echo
echo "virtual host conf path: /etc/apache2/sites-available/$APACHE2_CONF_NAME.conf"
echo
echo "Directory Root or Path and Directory Name for you domain: $ROOT_DIRECTORY_PATH$DOMAIN_NAME
"
echo
echo "check in your browser by:$DOMAIN_NAME or by:https://$DOMAIN_NAMEor by:http://$DOMAIN_NAME"
echo
