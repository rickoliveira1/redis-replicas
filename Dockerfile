FROM ubuntu:xenial
MAINTAINER Ricardo Santos (rc.ricardosantos@gmail.com)
MAINTAINER Ruan Santos (ruansvictor@gmail.com)

RUN apt-get update && \
apt-get -y upgrade && \
apt-get install make gcc libc6-dev tcl rubygems wget -y 

WORKDIR /etc/

RUN wget http://download.redis.io/redis-stable.tar.gz && \
tar xvzf redis-stable.tar.gz

WORKDIR /etc/redis-stable
RUN make install && \
gem install redis

RUN chmod 660 /etc/redis-stable/redis.conf

COPY ["docker-entrypoint.sh", "/usr/local/bin/"]

#RUN apt-get install -y supervisor && mkdir -p /var/log/supervisor

#COPY  ["supervisord.conf", "/etc/supervisor/conf.d/"]

#RUN chown -R 1001 /etc/supervisor/
#RUN chown 1001 -R /usr/bin/supervisord
RUN chown 1001 /usr/local/bin/docker-entrypoint.sh
RUN chown 1001 -R /etc/redis-stable

USER 1001

#CMD ["/usr/bin/supervisord"]
