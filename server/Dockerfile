# DOCKER-VERSION 0.3.4

FROM tomcat:7-jre7

MAINTAINER dev@taverna.incubator.apache.org

ENV TAVERNA_VERSION 2.5.4
ENV WAR_MD5 20d27405b27a3418b783777171734514

# Install time and unzip
#RUN apt-get install -qqy unzip time
#RUN apt-get clean

# Download and unpack Taverna Server
RUN rm -rf webapps/* && cd webapps && \
  wget -q https://launchpad.net/taverna-server/2.5.x/${TAVERNA_VERSION}/+download/TavernaServer-${TAVERNA_VERSION}.war -O ROOT.war && \
  echo "$WAR_MD5 ROOT.war" > ROOT.war.md5 && \
  md5sum -c ROOT.war.md5 && \
  mkdir ROOT && cd ROOT && \
  unzip ../ROOT.war

# Set up unsecured connections, server defaults and users.
ADD web.xml tavernaserver.properties webapps/ROOT/WEB-INF/
ADD users.properties webapps/ROOT/WEB-INF/security/

# Expose both http and ajp
EXPOSE 8080
EXPOSE 8009

# Expose the Taverna Server working directory for debugging.
VOLUME ["/tmp"]
