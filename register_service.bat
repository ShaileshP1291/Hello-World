set server=C:\R2016x\3DSpace
set build=true
set deploy=true
set webappname=3dspace
set connectorPort=9085
set shutdownPort=9030
set ajpPort=9031
set version=R2016x
set jvmsize=medium

set serviceurl=https://enovia.elotouch.com:447
set	SWYM_URL=
set	PASSPORT_URL=https://3dpassport-prod.elotouch.com:444/3dpassport
set	SEARCH_URL=https://3dsearch-prod.elotouch.com:448/federated
set	ENOVIA_URL=https://enovia.elotouch.com:447
set	DASHBOARD_URL=https://3ddashboard-prod.elotouch.com:446/3ddashboard
set	MYAPPS_URL=https://enovia.elotouch.com:447/3dspace
set	MX_SMTP_HOST=localhost
set	MX_SMTP_SENDER=admin_platform@elotouch.com
set	MX_PAM_AUTHENTICATE_CLASS=com.dassault_systemes.plmsecurity.authentication.CASAuthenticationWithReauth
set	MX_PAM_AUTHENTICATE_ARG=remote_user

if "%SWYM_URL%"=="" set EnvVariables=PASSPORT_URL_EQUAL_%PASSPORT_URL%\0SEARCH_URL_EQUAL_%SEARCH_URL%\0ENOVIA_URL_EQUAL_%ENOVIA_URL%\0MYAPPS_URL_EQUAL_%MYAPPS_URL%\0DASHBOARD_URL_EQUAL_%DASHBOARD_URL%\0MX_SMTP_HOST_EQUAL_%MX_SMTP_HOST%\0MX_PAM_AUTHENTICATE_CLASS_EQUAL_%MX_PAM_AUTHENTICATE_CLASS%\0MX_PAM_AUTHENTICATE_ARG_EQUAL_%MX_PAM_AUTHENTICATE_ARG%\0MX_SMTP_SENDER_EQUAL_%MX_SMTP_SENDER%
if NOT "%SWYM_URL%"=="" set EnvVariables=SWYM_URL_EQUAL_%SWYM_URL%\0PASSPORT_URL_EQUAL_%PASSPORT_URL%\0SEARCH_URL_EQUAL_%SEARCH_URL%\0ENOVIA_URL_EQUAL_%ENOVIA_URL%\0MYAPPS_URL_EQUAL_%MYAPPS_URL%\0DASHBOARD_URL_EQUAL_%DASHBOARD_URL%\0MX_SMTP_HOST_EQUAL_%MX_SMTP_HOST%\0MX_PAM_AUTHENTICATE_CLASS_EQUAL_%MX_PAM_AUTHENTICATE_CLASS%\0MX_PAM_AUTHENTICATE_ARG_EQUAL_%MX_PAM_AUTHENTICATE_ARG%\0MX_SMTP_SENDER_EQUAL_%MX_SMTP_SENDER%
	
rem fixed
set os=win_b64

rem fixed
set serviceNameTomEE=3DSpaceTomEE2

rem Activate Passport fragment
set fragments_path=%server%\%os%\resources\warutil\fragment

rem fragment holding Passport filters
set fragmentname=PassportAuthentication.web.xml.part
set fragmentname_orig=PassportAuthentication.web.xml.part.deactivated

rem emxSystem.properties
set file1=%server%\managed\properties\emxSystem.properties
set file1save=%server%\managed\properties\emxSystem.properties.sav

set file2=%server%\STAGING\ematrix\properties\emxSystem.properties
set file2save=%server%\STAGING\ematrix\properties\emxSystem.properties.sav

rem TomEE instances
set tomcat_install=%server%\%os%\code\tomcat\current2
set tomcat_installNoCAS=%server%\%os%\code\tomcat\currentNoCAS

rem  remove previous backup of emxSystem.properties
echo removing backups of %file1% ...

call CreateTomcatService2.bat %server% %webappname% %version% %jvmsize% %serviceNameTomEE% "true" %EnvVariables%