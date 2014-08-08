# DOCKER-VERSION 0.3.4

FROM consol/tomcat-7.0

MAINTAINER support@mygrid.org.uk

# Install the tomcat native library
RUN apt-get update -qq
RUN apt-get install -qqy unzip time libtcnative-1

# Download and unpack Taverna Server
RUN wget -q https://launchpad.net/taverna-server/2.5.x/2.5.4/+download/TavernaServer-2.5.4.war -O /tmp/taverna-254.war
RUN mkdir /opt/tomcat/webapps/taverna-254
RUN unzip -qq /tmp/taverna-254.war -d /opt/tomcat/webapps/taverna-254
RUN rm -f /tmp/taverna-254.war

# Set up unsecured connections
ADD web.xml /opt/tomcat/webapps/taverna-254/WEB-INF/

# Set up server defaults
ADD tavernaserver.properties /opt/tomcat/webapps/taverna-254/WEB-INF/

# Set up users
ADD users.properties /opt/tomcat/webapps/taverna-254/WEB-INF/security/

# Volumes for debugging
VOLUME ["/opt/tomcat/logs", "/tmp"]

# Clean up
RUN apt-get clean
