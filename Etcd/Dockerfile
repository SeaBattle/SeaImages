FROM ubuntu:trusty

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
    curl \
    tar

RUN mkdir /opt/app
RUN cd /opt/app; \
    curl -L https://github.com/coreos/etcd/releases/download/v3.0.1/etcd-v3.0.1-linux-amd64.tar.gz -o etcd-v3.0.1-linux-amd64.tar.gz && \
    tar xzvf etcd-v3.0.1-linux-amd64.tar.gz && \
    cd etcd-v3.0.1-linux-amd64 && \
    ln -s /opt/app/etcd-v3.0.1-linux-amd64/etcd /usr/bin/etcd && \
    ln -s /opt/app/etcd-v3.0.1-linux-amd64/etcdctl /usr/bin/etcdctl

RUN etcd & \ 
    etcdctl set /config/database/hosts 127.0.0.1:27017 && \
    etcdctl set /config/database/pool/size 1000 && \
    etcdctl set /config/database/pool/overflow 10000 && \
    etcdctl set /config/database/pool/overflow_ttl 900000 && \
    etcdctl set /config/database/pool/overflow_check 60000

RUN etcd & \ 
    etcdctl set /config/email/domain sandboxcfc84583119b44f8ad8361e9604be0d1.mailgun.org && \
    etcdctl set /config/email/api_url https://api.mailgun.net/v3/ && \
    etcdctl set /config/email/api_key key-0377cf183a7e365e67fd03c5acf991e6
    
RUN etcd & \
    etcdctl set /config/email/user_service/http/port 8080 && \
    etcdctl set /config/email/user_service/http/acceptors 100

EXPOSE 2379
EXPOSE 2380
    
ENTRYPOINT ["etcd"]
