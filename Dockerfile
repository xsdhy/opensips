FROM centos:7

WORKDIR /opt/

RUN yum -y install gcc gcc-c++ make flex bison ncurses libncurses-dev ncurses-devel pcre-devel libmicrohttpd wget vim libxml2-devel openssl-devel

RUN rpm -ivh https://repo.mysql.com//mysql57-community-release-el7-11.noarch.rpm && \
	rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022 && \
	yum install mysql-devel mysql-community-client.x86_64 -y  && \
	yum clean all

RUN yum -y install librdkafka-devel


RUN yum -y install git python36 python36-pip python36-devel gcc mysql-devel python36-mysql python36-sqlalchemy python36-pyOpenSSL
RUN git clone https://github.com/opensips/opensips-cli /opt/opensips-cli && \
	cd /opt/opensips-cli && \
	python3 setup.py install clean

RUN cd /opt/ && \
	wget --no-check-certificate https://github.com/OpenSIPS/opensips/archive/refs/tags/3.2.6.tar.gz && \
	tar -zxvf 3.2.6.tar.gz && \
	cd opensips-3.2.6 && \
	export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig && \
	ldconfig && \
	make all include_modules="db_mysql proto_tls proto_wss tls_mgm" install

VOLUME [/usr/local/etc/opensips]

EXPOSE 5060/udp 5061/tcp 5062/tcp

ENTRYPOINT ["/usr/local/sbin/opensips","-FE"]