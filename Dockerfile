FROM alpine:3.14
RUN apk update && apk add apache2
COPY loxury/ /var/www/localhost/htdocs
CMD ["httpd", "-D", "FOREGROUND"]

