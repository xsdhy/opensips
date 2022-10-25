FROM centos:7

WORKDIR /opt/

RUN yum -y install gcc gcc-c++ make flex bison ncurses libncurses-dev ncurses-devel pcre-devel libmicrohttpd wget vim libxml2-devel openssl-devel

RUN rpm -ivh https://repo.mysql.com//mysql57-community-release-el7-11.noarch.rpm && \
	rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022 && \
	yum install mysql-devel mysql-community-client.x86_64 -y  && \
	yum clean all

# 安装扩展cachedb_redis所需
RUN wget --no-check-certificate https://github.com/redis/hiredis/archive/refs/tags/v1.0.2.tar.gz && \
	tar -zxvf v1.0.2.tar.gz && \
	cd hiredis-1.0.2 && \
	make -j && make install

# 安装扩展rest_client所需
RUN cd /opt/ && \
	wget  --no-check-certificate https://curl.haxx.se/download/curl-7.65.0.tar.gz && \
	tar  -zxf  curl-7.65.0.tar.gz && \
	cd curl-7.65.0 && \
	./configure && make && make install

RUN cd /opt/ && \
	wget --no-check-certificate https://github.com/OpenSIPS/opensips/archive/refs/tags/2.4.11.tar.gz && \
	tar -zxvf 2.4.11.tar.gz && \
	cd opensips-2.4.11 && \
	export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig && \
	ldconfig && \
	make all include_modules="db_mysql proto_tls proto_wss tls_mgm cachedb_redis rest_client" install

EXPOSE 5060/udp 5061/tcp 5062/tcp

ENTRYPOINT ["/usr/local/sbin/opensips","-FE"]