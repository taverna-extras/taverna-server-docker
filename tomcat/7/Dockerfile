# DOCKER-VERSION 0.3.4

FROM taverna/openjdk-jre-headless:7u65

MAINTAINER support@mygrid.org.uk

ENV TOMCAT_VERSION 7.0.55

# Install the tomcat native library and wget.
RUN apt-get install -qqy libtcnative-1 wget
RUN apt-get clean

# Install and minimize tomcat.
RUN wget -q http://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/catalina.tar.gz
RUN tar xzf /tmp/catalina.tar.gz -C /opt
RUN ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat
RUN rm /tmp/catalina.tar.gz
RUN rm -rf /opt/tomcat/webapps/examples /opt/tomcat/webapps/docs

# Expose the logs for debugging if needed.
VOLUME ["/opt/tomcat/logs"]

# Tomcat uses port 8080 by default.
EXPOSE 8080

# Set up environment and run tomcat.
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin
ENTRYPOINT ["/opt/tomcat/bin/catalina.sh", "run"]
