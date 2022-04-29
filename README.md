# calculadora-envios

1) Importar: "inu-calc-envios-dump.sql" en una DB llamada inu_calc_envios
2) Pegar carpeta "calc-envios" dentro de htdocs de xampp

3) Al final de la configuracion del apache de xampp "C:\xampp\apache\conf\httpd.conf" agregar lo siguiente:

Listen 3000

<VirtualHost *:80>
    DocumentRoot "C:/xampp/htdocs"
    ServerName localhost
    ErrorLog "logs/localhost-error.log"
    CustomLog "logs/localhost-access.log" common
</VirtualHost>

<VirtualHost *:80>
    DocumentRoot "C:/xampp/htdocs/calc-envios/frontend"
    ServerName calc-envios.localhost
    ErrorLog "logs/calc-envios.localhost-frontend-error.log"
    CustomLog "logs/calc-envios.localhost-frontend-access.log" common
</VirtualHost>

<VirtualHost *:3000>
    DocumentRoot "C:/xampp/htdocs/calc-envios/backend"
    ServerName calc-envios.localhost
    ErrorLog "logs/calc-envios.localhost-backend-error.log"
    CustomLog "logs/calc-envios.localhost-backend-access.log" common
</VirtualHost>

4) Reiniciar apache

5) En "C:\Windows\System32\drivers\etc\hosts" agregar calc-envios.localhost a 127.0.0.1, de modo que quede así:

127.0.0.1       localhost calc-envios.localhost

5) Listo, reiniciar el navegador de ser necesario y dirigirse a calc-envios.localhost
