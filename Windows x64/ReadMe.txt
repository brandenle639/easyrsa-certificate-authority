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
