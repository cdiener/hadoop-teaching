FROM openjdk:jre-alpine
MAINTAINER "Christian Diener <mail (at) cdiener.com>"

ENV HADOOP_VERSION="2.8.2"
ENV HADOOP_CONF_DIR="/etc/hadoop"

COPY start_server /bin
RUN apk add --no-cache ca-certificates wget bash && update-ca-certificates
RUN cd /root && \
    wget -q http://www-eu.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz && cp -rf hadoop-${HADOOP_VERSION}/* .. && \
    rm -rf hadoop-${HADOOP_VERSION} && rm hadoop-${HADOOP_VERSION}.tar.gz && \
    chmod a+x /bin/start_server

ENTRYPOINT [ "/bin/bash", "/bin/start_server" ]
