FROM alpine:3.14
RUN apk update && apk add apache2
CMD ["httpd", "-D", "FOREGROUND"]
COPY loxury/ /var/www/localhost/htdocs 
