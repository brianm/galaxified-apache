ServerRoot "GXY_DEPLOY_ROOT/httpd"
DocumentRoot "GXY_DEPLOY_ROOT/htdocs"
ServerName "splendiferous"

Listen GXY_PORT
ServerAdmin root@example.com

<Directory />
    Options FollowSymLinks
    AllowOverride None
    Order deny,allow
    Deny from all
</Directory>

<Directory "GXY_DEPLOY_ROOT/htdocs">
    Options Indexes FollowSymLinks
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>

<Location /server-status>
  SetHandler server-status
  Order Deny,Allow
  Deny from all
  Allow from localhost
</Location>

ErrorLog "logs/error_log"
LogLevel warn
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %b" common
CustomLog "logs/access_log" common

DefaultType text/plain

