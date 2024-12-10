#!/bin/sh

if [ "$#" -ne 1 ]
then
  echo "Usage: Must supply a domain"
  exit 1
fi

DOMAIN=$1
EASYRSALOCATION=C:/easyrsa
DOMAINFOLDER=pki/sites/$DOMAIN
SHAREFOLDER=""

cd $EASYRSALOCATION

rm pki/reqs/$DOMAIN.req
rm -R $DOMAINFOLDER
rm pki/issued/$DOMAIN.crt
rm $SHAREFOLDER/$DOMAIN.zip
echo "Completed the removals"
