FROM openjdk:7
RUN apt-get update && apt-get install -y vim curl net-tools
WORKDIR /usr/src/cdic-worker
COPY cdic-boot-0.0.2-SNAPSHOT.jar /usr/src/cdic-worker
COPY worker1 /usr/src/cdic-worker/worker1/
EXPOSE 25199
CMD ["bash", "/usr/src/cdic-worker/worker1/cdic", "start"]
