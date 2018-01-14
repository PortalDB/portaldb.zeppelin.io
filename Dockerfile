FROM apache/zeppelin:0.7.3

COPY temporal-graph-project_2.11-1.0.jar ${Z_HOME}
COPY portal-assembly-1.0.jar ${Z_HOME}
COPY dblp ${Z_HOME}/dblp

RUN rm -rf ${Z_HOME}/notebook
RUN rm -rf ${Z_HOME}/conf

COPY conf ${Z_HOME}/conf
COPY notebook ${Z_HOME}/notebook

# Install Java and some tools
RUN apt-get -y update &&\
    apt-get -y install curl less &&\
    apt-get install -y default-jdk

##########################################
# SPARK
##########################################
ARG SPARK_VERSION="2.2.0"
ARG HADOOP_VERSION="2.7"

ARG SPARK_ARCHIVE=http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN mkdir /usr/local/spark

ENV SPARK_HOME /usr/local/spark

ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -s ${SPARK_ARCHIVE} | tar -xz -C  /usr/local/spark --strip-components=1