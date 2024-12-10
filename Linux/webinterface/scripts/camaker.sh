#!/bin/sh

if [ "$#" -ne 1 ]
then
  echo "Usage: Must supply a domain"
  exit 1
fi

DOMAIN=$1
DOMAINFOLDER=pki/sites/$DOMAIN
SHAREFOLDER=/var/www/html/sharing/zips

cd /opt/easyrsa
mkdir -p $DOMAINFOLDER


#Makes RSA Key for site
openssl genrsa -out $DOMAINFOLDER/$DOMAIN.key

#Makes RSA Request for site
openssl req -new -key $DOMAINFOLDER/$DOMAIN.key -subj "/CN=$DOMAIN/C=US/ST=Indiana/L=Fort Wayne/O=Ray" -out $DOMAINFOLDER/$DOMAIN.req

#Imports the Requested site file
./easyrsa import-req $DOMAINFOLDER/$DOMAIN.req $DOMAIN

#Creates the Site cert
cat << EOF | ./easyrsa sign-req server $DOMAIN
yes
EOF

#Copy the Site cert to the correct site folder
cp pki/issued/$DOMAIN.crt $DOMAINFOLDER

#Creates the pfx file for IIS
openssl pkcs12 -export -out $DOMAINFOLDER/$DOMAIN.pfx -inkey $DOMAINFOLDER/$DOMAIN.key -in $DOMAINFOLDER/$DOMAIN.crt -in $DOMAINFOLDER/$DOMAIN.crt -passout pass:

#Cd to Sites folder
cd pki/sites/

#Compress the site CRT and KEY to a zip into the shared site folder
zip $SHAREFOLDER/$DOMAIN.zip $DOMAIN/$DOMAIN.crt $DOMAIN/$DOMAIN.key $DOMAIN/$DOMAIN.pfx
