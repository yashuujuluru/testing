FROM alpine:3.14
RUN apk update && apk add apache2
COPY loxury/ /var/www/localhost/htdocs
LABEL Yash=Rohit \  
    bad=singam  \
    good=juluru
EXPOSE 444/tcp   
ENV admin=you \
    aa=bb
ADD https://github.com/readmeio/import-samples/blob/master/import-sample-multiple-versions.zip /var/www/localhost/htdocs/
CMD ["httpd", "-D", "FOREGROUND"]