FROM library/redis:3.2
MAINTAINER Cory Buecker <email@corybuecker.com>

RUN touch /etc/redis.conf

RUN chmod 660 /etc/redis.conf

COPY ["docker-entrypoint.sh", "/usr/local/bin/"]

RUN chown 1001 /usr/local/bin/docker-entrypoint.sh

USER 1001