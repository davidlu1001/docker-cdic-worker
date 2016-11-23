#FROM centos:7
FROM dinglu/systemd-base
RUN yum update && yum install -y sudo vim curl python python-pip telnet net-tools java-1.7.0-openjdk-devel.x86_64 nfs-utils nfs-utils-lib libnfsidmap
WORKDIR /usr/src/cdic-worker/worker1
RUN mkdir -p /usr/src/cdic-worker/worker1/logs
RUN groupadd cdic
RUN useradd -g cdic -d /home/cdic -s /bin/bash cdic
RUN mkdir -p /data/crce/cdic /data/xdr/cdic /data/crm/cdic
RUN chown cdic:cdic /data/crce /data/xdr /data/crm -R
COPY cdic-boot-0.0.2-SNAPSHOT.jar /usr/src/cdic-worker
COPY worker1/run.sh /usr/src/cdic-worker/worker1/
COPY worker1/cdic /usr/src/cdic-worker/worker1/
COPY rabbitmqadmin /usr/src/cdic-worker/worker1/
RUN chown cdic:cdic /usr/src/cdic-worker -R
RUN chmod a+x /usr/src/cdic-worker/worker1/*
RUN echo "10.100.104.6:/data/crce/cdic  /data/crce/cdic         nfs     rw,hard,intr,rsize=32768,wsize=32768,nfsvers=3     1  1" >> /etc/fstab
RUN echo "10.100.104.9:/data/xdr/cdic  /data/xdr/cdic          nfs     rw,hard,intr,rsize=32768,wsize=32768,nfsvers=3     1  1" >> /etc/fstab
RUN echo "10.100.104.8:/data/crm/cdic  /data/crm/cdic          nfs     rw,hard,intr,rsize=32768,wsize=32768,nfsvers=3     1  1" >> /etc/fstab
RUN systemctl enable rpcbind
#RUN systemctl start rpcbind
RUN mount -a
EXPOSE 25199
#CMD ["bash", "-x", "cdic", "start", "worker1"]
CMD ["ping", "localhost"]
