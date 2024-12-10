#!/bin/sh

if [ "$#" -ne 1 ]
then
  echo "Usage: Must supply a domain"
  exit 1
fi

#Reads the counter file
CRTCOUNTER=`cat C:/easyrsa/crtcounter.txt`

#Sets the cert serial number based on the cert counter
export EASYRSA_REQ_SERIAL=$CRTCOUNTER

#Increases the cert number
echo $(($value + 1)) > "C:/easyrsa/crtcounter.txt"

#Loops through the vars file
while IFS= read -r line
do
  #Adds equal sign
  stp1="${line// \"/=\"}"

  #Removes related spaces for
  stp2="${stp1//  /}"

  #Sets equals sign and removes last space
  stp3="${stp2// =\"/=\"}"

  #Removes set_var
  stp4="${stp3//set_var/}"

  #Replaces quotes
  stp5="${stp4//\"/}"

  #Imports Variables and Values
  export $stp5
done < "C:\easyrsa\pki\vars"

DOMAIN=$1
EASYRSALOCATION=C:/easyrsa
DOMAINFOLDER=pki/sites/$DOMAIN
SHAREFOLDER=""

cd $EASYRSALOCATION
mkdir -p $DOMAINFOLDER


#Makes RSA Key for site
./openssl.exe genrsa -out $DOMAINFOLDER/$DOMAIN.key

#Makes RSA Request for site
./openssl.exe req -new -key $DOMAINFOLDER/$DOMAIN.key -subj "/CN=$DOMAIN/C=$EASYRSA_REQ_COUNTRY/ST=$EASYRSA_REQ_PROVINCE/L=$EASYRSA_REQ_CITY/O=$EASYRSA_REQ_OU" -out $DOMAINFOLDER/$DOMAIN.req

#Imports the Requested site file
./easyrsa import-req $DOMAINFOLDER/$DOMAIN.req $DOMAIN

#reates the Site cert
./easyrsa sign-req server $DOMAIN

#Copy the Site cert to the correct site folder
cp pki/issued/$DOMAIN.crt $DOMAINFOLDER

#Creates the pfx file for IIS
./openssl.exe pkcs12 -export -out $DOMAINFOLDER/$DOMAIN.pfx -inkey $DOMAINFOLDER/$DOMAIN.key -in $DOMAINFOLDER/$DOMAIN.crt -in $DOMAINFOLDER/$DOMAIN.crt -passout pass:

#Cd to Sites folder
cd pki/sites/

#Compress the site CRT and KEY to a zip into the shared site folder
tar -acf $SHAREFOLDER/$DOMAIN.zip $DOMAIN/$DOMAIN.crt $DOMAIN/$DOMAIN.key $DOMAIN/$DOMAIN.pfx
