#!/bin/bash
if ! which redis-server >/dev/null 2>&1; then
	source /etc/profile.d/redis.sh
fi
 
#sysctl -w net.core.somaxconn=1024 
#sysctl -w vm.overcommit_memory=1 
#echo never > /sys/kernel/mm/transparent_hugepage/enabled
#echo never > /sys/kernel/mm/transparent_hugepage/defrag

#useradd -u 6379 redis
#chown -R redis.redis /data/redis/data
#chown -R redis.redis /opt/apply/redis 
#chown -R redis.redis /usr/bin/redis-server
#chown -R redis.redis /usr/bin/redis-cli
#chmod +x /usr/bin/redis-server
#chmod +x /usr/bin/redis-cli

sed -i "/^#[[:space:]]\+requirepass/c requirepass '$PASSWD'" /opt/apply/redis/etc/redis.conf

exec "$@"
