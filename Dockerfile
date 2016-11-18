FROM openjdk:7
RUN apt-get update && apt-get install -y sudo vim curl net-tools
WORKDIR /usr/src/cdic-worker
RUN groupadd cdic
RUN useradd -g cdic -d /home/cdic -s /bin/bash cdic
RUN mkdir -p /usr/src/cdic-worker/worker1
COPY cdic-boot-0.0.2-SNAPSHOT.jar /usr/src/cdic-worker
COPY worker1/run.sh /usr/src/cdic-worker/worker1/
COPY worker1/cdic /usr/src/cdic-worker/worker1/
RUN chown cdic:cdic /usr/src/cdic-worker -R
RUN chmod a+x /usr/src/cdic-worker/worker1/*
EXPOSE 25199
CMD ["bash", "/usr/src/cdic-worker/worker1/cdic", "start", "worker1"]
