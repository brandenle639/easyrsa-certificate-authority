Linux:

THIS IS ONLY FOR LINUX CONFIGURATION AND APACHE

WARNING: MOST COMMANDS ARE DESIGNED FOR APACHE BEING INSTALLED DIRECTLY ON TO THE MACHINE

Required:
    EasyRSA (3-1.0 for download in repo)
    openssl

Optional for web interface:
    php
    apache (httpd)

Requirements install:
    
    1. Download the EasyRSA zip file
    
    2. Extract the zip file
    
    3. Move the extracted zip folder to /opt/easyrsa
    
    4. Run command: sudo chmod -R 777 /opt/easyrsa

    5. Run command: sudo chmod +x /opt/easyrsa/easyrsa
    
    6. Run command to check if openssl is installed: openssl version
        a. If not installed then it must be installed

Web Interface Requirements install:
    
    1. Run command to check if httpd/Apache is install: sudo systemctl status httpd
        a. If not installed then it must be installed
    
    2. Run command to check if php is install: php -v
        a. If not installed then it must be installed

Configure EasyRSA (Commands):
    
    1. cd /opt/easyrsa
    
    2. sudo vi var
    
    3. Enter the following from below adding your information where the <> are (Remove brackets when adding; leave the quotes):
        set_var EASYRSA_BATCH          "1"
        set_var EASYRSA_REQ_CN         "<Your Common Name>"
        set_var EASYRSA_REQ_COUNTRY    "<Your Country Code (Example: US)>"
        set_var EASYRSA_REQ_PROVINCE   "<Your State>"
        set_var EASYRSA_REQ_CITY       "<Your City>"
        set_var EASYRSA_REQ_ORG        "<Your Organization>"
        set_var EASYRSA_REQ_EMAIL      "<Related Company Email>"
        set_var EASYRSA_REQ_OU         "<Your Organizational Unit>"
        set_var EASYRSA_ALGO           "ec"
        set_var EASYRSA_DIGEST         "sha512"
    
    4. ./easyrsa init-pki

    5. Setting up the CA Authority:

        Without password:

            ./easyrsa build-ca nopass

        With password:

            ./easyrsa build-ca

                Fill out requested information

                Common Name should match the CN in the var file

                ***Warning: The Web Interface will not currently work when using a password***

To get the related files:

    The CA Authority Cert: /opt/easyrsa/pki/ca.crt
    
    The Related Site Certs: /opt/easyrsa/pki/sites/<example>
        <example> would be the url of your web server

Configure General Bash Scripts:

    1. Download the scripts folder

    2. Open the scripts folder

    3. Edit the 'SHAREFOLDER' variable in 'camaker.sh' and 'ziprm.sh' to where you want the related site zips stored after creating the related certificate

    4. Edit the following line "openssl req -new -key $DOMAINFOLDER/$DOMAIN.key -subj "/CN=$DOMAIN/C=US/ST=Indiana/L=Fort Wayne/O=Ray" -out $DOMAINFOLDER/$DOMAIN.req" and change the "C, ST, L, O" with the related information
        C=Country
        ST=State
        L=City
        O=Organization

    5. sudo chmod +x camaker.sh

    6. sudo chmod +x ziprm.sh

To use the bash scripts scripts:

    1. ./camaker.sh <example>
        <example> would be the url of your web server

    2. ./ziprm.sh <example>
        a. WARNING: All related files from the EasyRSA folders and the related Zip file will be permently deleted
        b. <example> would be the url of your web server

To Install Web Interface:

    1. sudo mkdir -p /var/www/html/sharing/zips

    2. Copy the contents of the 'webinterface' folder into the root of /var/www/html/sharing

    3. sudo chown -R apache:apache /var/www/html/sharing

    4. sudo chmod +x /var/www/html/sharing/scripts/camaker.sh && sudo chmod +x /var/www/html/sharing/scripts/ziprm.sh

To Configure Site for Apache (Unsecured):

    1. Go to /etc/httpd/conf.d

    2. vi 'sharing.conf'

    3. Enter the following information (Replace {example.com} with your information):
        <VirtualHost *:80>
        ServerName {example.com}
        ServerAlias {example.com}
        DocumentRoot /var/www/html/sharing
        </VirtualHost>

    4. sudo systemctl restart httpd

To use the Web Interface:

    1. To create a Certificate:

        a. Enter the Site Uri in the "Cite Url to Create:" textbox and then click the related submit button

        b. All relavent information will be displayed

    2. To remove a Certificate:

        a. Enter the Site Uri in the "Cite Url to Remove:" textbox and then click the related submit button

        b. All relavent information will be displayed

        c. WARNING: All related files from the EasyRSA folders and the related Zip file will be permently deleted

    3. To update the list pane on the right hand side:

        a. Right click in the pane

        b. Click "Reload frame"

To Password Protect site:

    1. Go to /etc/httpd/conf.d

    2. vi 'sharing.conf'

    3. Enter the following information (Replace {example.com} with your information):
        <VirtualHost *:80>
            DocumentRoot /var/www/html/sharing

            <Directory "/var/www/html/sharing">
                AuthType Basic
                AuthName "Password Required"
                Require valid-user
                AuthUserFile /etc/httpd/.htpasswd
            </Directory>
        </VirtualHost>

    4. sudo htpasswd /etc/httpd/.htpasswd <Username>

    5. sudo chmod 644 /etc/httpd/.htpasswd

    6. sudo systemctl restart httpd

Potential Error Fixes:

    If "pfx" Creation failes:
        
        Re-run:
            
            openssl pkcs12 -export -out /opt/easyrsa/pki/sites/<example>/<example>.pfx -inkey /opt/easyrsa/pki/sites/<example>/<example>.key -in /opt/easyrsa/pki/sites/<example>/<example>.crt -in /opt/easyrsa/pki/sites/<example>/<example>.crt -passout pass:
            
                <example> would be the url of your web server

Outside Repos/Infomartion:

    https://github.com/OpenVPN/easy-rsa

Windows (x86):

To Install:

    1. Extract the "EasyRSA-3.1.1-win64.zip" to "C:\easyrsa"

    2. Copy build.sh, camaker.sh, vars, ziprm.sh to "C:\easyrsa"

    3. Right click and unblock "C:\easyrsa\EasyRSA-Start.bat"

To Configure:

   1. In "C:\easyrsa\vars" edit:

        set_var EASYRSA_REQ_CN         "<Your Common Name>"
        set_var EASYRSA_REQ_COUNTRY    "<Your Country Code (Example: US)>"
        set_var EASYRSA_REQ_PROVINCE   "<Your State>"
        set_var EASYRSA_REQ_CITY       "<Your City>"
        set_var EASYRSA_REQ_ORG        "<Your Organization>"
        set_var EASYRSA_REQ_EMAIL      "<Related Company Email>"
        set_var EASYRSA_REQ_OU         "<Your Organizational Unit>"
        set_var EASYRSA_KEY_SIZE       "<Key Length EXAMPLE: 512,1024>"
        set_var EASYRSA_CERT_EXPIRE    "<How long until the cert expires>"
        set_var EASYRSA_CRL_DAYS       "<The next pbulshing date for a new cert>"

            Recommended EASYRSA_CERT_EXPIRE and EASYRSA_CRL_DAYS be the same number

    2. Edit the 'SHAREFOLDER' variable in 'camaker.sh' and 'ziprm.sh' to where you want the related site zips stored after creating the related certificate

            Use forward slashes "/" for the path like the other variables

To Build CA Authority:

    1. Open "C:\easyrsa\EasyRSA-Start.bat"

    2. type "./build.sh"

    3. If have to move or copy vars in to "C:\easyrsa\pki" or rename "C:\easyrsa\vars" to "C:\easyrsa\vars.using"

To make a site cert:

    1. Open "C:\easyrsa\EasyRSA-Start.bat"

    2. type: ./camaker.sh <example>
        <example> would be the url of your web server

To remove a site cert:

    1. Open "C:\easyrsa\EasyRSA-Start.bat"

    2. type: ./ziprm.sh <example>
        a. WARNING: All related files from the EasyRSA folders and the related Zip file will be permently deleted
        b. <example> would be the url of your web server

To get the related files:

    The CA Authority Cert: C:\easyrsa\pki\ca.crt
    
    The Related Site Certs: C:\easyrsa\pki\sites\<example>
        <example> would be the url of your web server
