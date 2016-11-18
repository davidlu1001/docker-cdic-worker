FROM centos:7
RUN yum update && yum install -y sudo vim curl net-tools java-1.7.0-openjdk-devel.x86_64
WORKDIR /usr/src/cdic-worker/worker1
RUN mkdir -p /usr/src/cdic-worker/worker1/logs
RUN groupadd cdic
RUN useradd -g cdic -d /home/cdic -s /bin/bash cdic
COPY cdic-boot-0.0.2-SNAPSHOT.jar /usr/src/cdic-worker
COPY worker1/run.sh /usr/src/cdic-worker/worker1/
COPY worker1/cdic /usr/src/cdic-worker/worker1/
RUN chown cdic:cdic /usr/src/cdic-worker -R
RUN chmod a+x /usr/src/cdic-worker/worker1/*
EXPOSE 25199
#CMD ["bash", "cdic", "start", "worker1"]
CMD ["ping", "cdic, start, worker1"]
