FROM httpd:latest
COPY /root/app/index.html /usr/local/apache2/htdocs
EXPOSE 80
