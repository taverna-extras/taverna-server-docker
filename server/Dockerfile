# DOCKER-VERSION 0.3.4

FROM taverna/tomcat:7.0.55

MAINTAINER support@mygrid.org.uk

ENV TAVERNA_VERSION 2.5.4

# Install time and unzip
RUN apt-get install -qqy unzip time
RUN apt-get clean

# Download and unpack Taverna Server
RUN wget -q https://launchpad.net/taverna-server/2.5.x/${TAVERNA_VERSION}/+download/TavernaServer-${TAVERNA_VERSION}.war -O /tmp/taverna.war
RUN mkdir /opt/tomcat/webapps/taverna-${TAVERNA_VERSION}
RUN unzip -qq /tmp/taverna.war -d /opt/tomcat/webapps/taverna-${TAVERNA_VERSION}
RUN rm -f /tmp/taverna.war

# Set up unsecured connections, server defaults and users.
ADD web.xml /opt/tomcat/webapps/taverna-${TAVERNA_VERSION}/WEB-INF/
ADD tavernaserver.properties /opt/tomcat/webapps/taverna-${TAVERNA_VERSION}/WEB-INF/
ADD users.properties /opt/tomcat/webapps/taverna-${TAVERNA_VERSION}/WEB-INF/security/

# Expose the Taverna Server working directory for debugging.
VOLUME ["/tmp"]
