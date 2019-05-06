
FROM centos:7.5.1804
MAINTAINER "xhaihua 851628816@qq.com"

ENV PASSWD="Wx@1234."

RUN yum -y install gcc gcc-c++ make net-tools iproute wget tree jemalloc-devel \
    && wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo \
    && mkdir -p /opt/apply/redis

WORKDIR /tmp

COPY redis-4.0.12.tar.gz /tmp/


VOLUME ["/data/redis/data"]

RUN  tar xf redis-4.0.12.tar.gz && cd redis-4.0.12 \
     && make PREFIX=/opt/apply/redis install \
     && mkdir /opt/apply/redis/{etc,var} \
     && echo "export PATH=/opt/apply/redis/bin/:$PATH" >> /etc/profile.d/redis.sh \
     && source /etc/profile.d/redis.sh

COPY redis.conf  /opt/apply/redis/etc/
COPY entrypoint.sh /opt/apply/redis/bin/

RUN  chmod +x /opt/apply/redis/bin/entrypoint.sh \
     && yum clean all \
     && rm -rf /tmp/redis-4.0.12 \
     && rm -rf /tmp/redis-4.0.12.tar.gz \
     && ln -s /opt/apply/redis/bin/redis-server /usr/bin/redis-server \
     && ln -s /opt/apply/redis/bin/redis-cli /usr/bin/redis-cli 

EXPOSE 6379/tcp

VOLUME ["/opt/apply/redis/var"]
ENTRYPOINT ["/opt/apply/redis/bin/entrypoint.sh"]


CMD ["/usr/bin/redis-server","/opt/apply/redis/etc/redis.conf"]
