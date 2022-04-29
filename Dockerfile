ARG NGINX_VERSION=1.21.6

FROM nginx:${NGINX_VERSION}
USER root
## Redeclare NGINX_VERSION so it can be used as a parameter inside this build stage
ARG NGINX_VERSION

## Install required packages and build dependencies
RUN apt-get update
RUN apt-get install -y dirmngr gpg gpg-agent curl build-essential libpcre3-dev zlib1g-dev libperl-dev git

RUN cd /tmp && \
    git clone https://github.com/nginx-modules/ngx_cache_purge.git 

RUN cd /tmp && \
    curl -O http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz  && \
    tar xzf nginx-${NGINX_VERSION}.tar.gz

## Compile NGINX with desired module

RUN cd /tmp/nginx-${NGINX_VERSION} && \    
    ./configure --prefix=/etc/nginx --add-dynamic-module=/tmp/ngx_cache_purge --with-compat && \
    make modules


RUN cp /tmp/nginx-${NGINX_VERSION}/objs/ngx_http_cache_purge_module.so /etc/nginx/modules/

CMD ["nginx", "-g", "daemon off;"]



