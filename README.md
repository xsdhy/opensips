



docker run -itd --network=host --name opensips \
    -v /data/docker/opensips/opensips.cfg:/usr/local/etc/opensips/opensips.cfg \
    -v /data/docker/opensips/cert/domain.pem:/usr/local/etc/opensips/cert/domain.pem \
    -v /data/docker/opensips/cert/domain.key:/usr/local/etc/opensips/cert/domain.key \
    xsdhy/opensips:2.4.11

