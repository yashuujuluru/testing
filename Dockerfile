FROM alpine:3.14
RUN apk update && apk add apache2
COPY loxury/ /var/www/localhost/htdocs
LABEL Yash=Rohit \  
    bad=singam  \
    good=juluru
EXPOSE 444/tcp   
ENV admin=you \
    aa=bb
ADD https://www.free-css.com/free-css-templates/page283/lodge /tmp/docker 
CMD ["httpd", "-D", "FOREGROUND"]