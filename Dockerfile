FROM maven:3.5-jdk-8
MAINTAINER dev@taverna.incubator.apache.org


# Update below according to
# https://taverna.incubator.apache.org/download/server/

ENV TAVSERV_VERSION 3.1.0-incubating
# Find latest checksum in https://www.apache.org/dist/incubator/taverna/source/
ENV TAVSERV_SHA256 0025c85cc115fc5b8c6c969f2a1ae995ca3269a193f63d2508bc8740c095af1c
# NOTE: No need for https for .tar.gz download due to above checksum
ENV TAVSERV_MIRROR http://www.eu.apache.org/dist/
ENV TAVSERV_ARCHIVE http://archive.apache.org/dist/
ENV TAVSERV_FOLDER incubator/taverna/source

WORKDIR /tmp

RUN echo "$TAVSERV_SHA256  taverna-server.zip" > taverna-server.zip.sha256

# Fall-back to archive if this version is no longer in the mirror
RUN path=$TAVSERV_FOLDER/taverna-server-$TAVSERV_VERSION/apache-taverna-server-$TAVSERV_VERSION-source-release.zip &&\ 
    wget -O taverna-server.zip $TAVSERV_MIRROR/$path || wget -O taverna-server.zip $TAVSERV_ARCHIVE/$path
RUN sha256sum -c taverna-server.zip.sha256
RUN unzip taverna-server.zip && mv apache-taverna-server-$TAVSERV_VERSION src

WORKDIR /tmp/src
RUN mvn clean install
RUN mv taverna-server-webapp/target/taverna-server.war /taverna-server.war

# Second stage, Tomcat container
FROM tomcat:8-jre8

# Install "time"
RUN apt-get update && apt-get install -qqy time && apt-get clean

# (assume WORKDIR is in tomcat dir)

# Clear default apps
RUN rm -rf webapps/*

# Get WAR from previous stage, deploy at ROOT
COPY --from=0 /taverna-server.war /tmp/taverna-server.war

# Manual unpack of WAR to customize properties
RUN rm -rf webapps/* && \
  mkdir webapps/ROOT && cd webapps/ROOT && \  
  unzip /tmp/taverna-server.war

# Set up unsecured connections, server defaults and users.
ADD web.xml tavernaserver.properties webapps/ROOT/WEB-INF/
ADD users.properties webapps/ROOT/WEB-INF/security/


# Expose both http and ajp
EXPOSE 8080
EXPOSE 8009

# Expose the Taverna Server working directory for debugging.
VOLUME ["/tmp"]
