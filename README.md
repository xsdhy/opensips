# opensips2.4.11版本

## 容器说明
### 文件挂载
生产环境运行时，一般挂载3个文件即可
#### opensips.cfg 
这是opensips运行的必要配置文件，容器内的目录必须是/usr/local/etc/opensips/opensips.cfg
#### wss所需的证书文件
证书文件在容器内的目录，主要是根据opensips.cfg配置文件来决定的，推荐在usr/local/etc/opensips/cert/目录 

### 端口说明
容器可用5060/udp 5061/tcp 5062/tcp三个端口，也可直接使用host模式

### 日志收集
opensips.cfg配置文件设置log_stderror=yes，即可通过docker logs查看opensips日志

### 启动
```
docker run -itd --network=host --name opensips \
    -v /data/docker/opensips/opensips.cfg:/usr/local/etc/opensips/opensips.cfg \
    -v /data/docker/opensips/cert/self.pem:/usr/local/etc/opensips/cert/self.pem \
    -v /data/docker/opensips/cert/self.key:/usr/local/etc/opensips/cert/self.key \
    xsdhy/opensips:2.4.11
```
