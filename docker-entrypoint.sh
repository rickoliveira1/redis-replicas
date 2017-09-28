#!/bin/bash

set -e
set -x
echo "#bind 127.0.0.1" > /etc/redis-stable/redis.conf
echo "protected-mode no" >> /etc/redis-stable/redis.conf
echo "port $PORT" >> /etc/redis-stable/redis.conf
echo "pidfile /var/run/redis-$PORT.pid" >> /etc/redis-stable/redis.conf
echo "cluster-enabled yes" >> /etc/redis-stable/redis.conf
echo "cluster-config-file nodes-$PORT.conf" >> /etc/redis-stable/redis.conf
echo "cluster-node-timeout 15000" >> /etc/redis-stable/redis.conf

echo "#bind 127.0.0.1" > /etc/redis-stable/redis-slave.conf
echo "protected-mode no" >> /etc/redis-stable/redis-slave.conf
echo "port $PORTSLAVE" >> /etc/redis-stable/redis-slave.conf
echo "pidfile /var/run/redis-$PORTSLAVE.pid" >> /etc/redis-stable/redis-slave.conf
echo "cluster-enabled yes" >> /etc/redis-stable/redis-slave.conf
echo "cluster-config-file nodes-$PORTSLAVE.conf" >> /etc/redis-stable/redis-slave.conf
echo "cluster-node-timeout 15000" >> /etc/redis-stable/redis-slave.conf

if [ -v SLAVEA ]; then
  set -- $@ "/etc/redis-stable/src/redis-trib.rb add-node --slave --master-id [master-first] master-first:6381 master-third:6381"
fi
if [ -v SLAVEB ]; then
  set -- $@ "/etc/redis-stable/src/redis-trib.rb add-node --slave --master-id [master-second] master-second:6379 master-first:6379"
fi
if [ -v SLAVEC ]; then
  set -- $@ "/etc/redis-stable/src/redis-trib.rb add-node --slave --master-id [master-third] master-third:6380 master-second:6380"
fi

cat /etc/redis-stable/redis.conf
cat /etc/redis-stable/redis-slave.conf

exec $@
exec "/etc/redis-stable/src/redis-trib.rb create master-first:6379 master-second:6380 master-third:6381"
