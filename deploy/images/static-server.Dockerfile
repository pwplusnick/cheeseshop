FROM nginx:1.13-alpine

RUN apk add --no-cache bash

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
USER nginx
COPY ./conf/static-nginx.conf /nginx-sites/cheeseshop-static.template
COPY ./cheeseshop/static /cheeseshop-static/static
USER root
RUN mkdir /var/run/nginx
RUN chown nginx:root /nginx-sites
RUN chown nginx:nginx /var/run/nginx

USER nginx
CMD ["/bin/bash", "-c", "envsubst < /nginx-sites/cheeseshop-static.template > /nginx-sites/cheeseshop-static.conf && nginx"]
