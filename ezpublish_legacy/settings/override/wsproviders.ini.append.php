<?php /*

#######################
### CLIENT SETTINGS ###
#######################

# Definition of webservice servers that can be called by template or php code:
# . for every remote server, a configuration block is used.
# . the name of the block can be chosen at will (it must be unique of course)
#   and will be used in php/template code to send calls to the server
# . within the block, a collection of variables, some mandatory, some optional

#[myserver]

# mandatory variables
#providerType=JSONRPC, SOAP, PhpSOAP, REST, eZJSCore or XMLRPC
#providerUri=http://my.test.server/wsendpoint.php

# deprecated variables. Use Options[] instead
#providerUsername=
#providerPassword=
#timeout=60

# optional variables
#Options[]
#Options[timeout]=60 (in seconds)
#Options[login]=...
#Options[password]=...
#Options[authType]=1(basic), 2(digest), 4(GSS-Negotiate), 8(NTLM), 16(Digest with IE flavour)
#[requestCompression]=gzip, deflate. Useful only when the php zlib extension is enabled AND if the server supports compressed requests!
#Options[acceptedCompression]=gzip, deflate or 'gzip, deflate'. Set it to empty string to disable, as it is automatically enabled when the php zlib extension is enabled
#Options[forceCURL]=0 or 1 to force curl usage (HTTP 1.1 request instead of HTTP 1.0)

# NB: the following two are only useful for SOAP servers
#Options[soapVersion]=1 (for soap 1.1), 2 (for soap 1.1)
#Options[cacheWSDL]=0 (none), 1 (disk), 2 (memory) or 3 (both). If not set, defaults to value in php.ini

# NB: the following are only useful for REST servers
#Options[method]=GET or POST (defaults to GET)
#Options[nameVariable]=... name of the GET/POST variable used to hold the webservice method name. By default it is empty, meaning that the method name will not be put in the query string but appended as last part of the url path
#Options[accept]=... used in the Accept header of the request. Useful e.g. for eZPublish REST v2 API
#Options[responseType]=application/json (or other content type) to force parsing response as this format, when server sends an unrecognized content-type header. Useful for REST calls only
#Options[requestType]=application/x-www-form-urlencoded, application/json, application/x-httpd-php, application/vnd.php.serialized

# more options: proxy
# If these variables are not set here, the Proxy defined globally in site.ini ProxySerrings block will be used
# (nb: a variable with an empty value is still considered to be set. To unset it, remove or comment the line)
#ProxyServer=myproxy:8080
#ProxyUser=
#ProxyPassword=


# SOAP server using wsdl: only PhpSOAP is supported
# providerUri empty means use the uri specified in the wsdl, otherwise it will be used instead of that
#[mySOAPserver]
#providerType=PhpSOAP
#providerUri=
#WSDL=http://mydomain.com/NUSOAP/Hellowsdl.php?wsdl
# deprecated: soap version to be used. Defaults to soap11 (use Options[soapVersion] instead)
#SoapVersion=soap12

[provinciaBolzano]
providerType=PhpSOAP
providerUri=https://demo-wave.ws.siag.it/wsdl/CourseManagementTasks.wsdl
WSDL=https://demo-wave.ws.siag.it/wsdl/CourseManagementTasks.wsdl

*/ ?>