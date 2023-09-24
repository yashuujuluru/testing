FROM alpine:3.14
RUN apk update && apk add apache2
CMD ["httpd", "-D", "FOREGROUND"]