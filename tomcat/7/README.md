# Taverna Tomcat 7 Docker

Docker image set up for tomcat 7.

The pre-built image is available on the [Docker Hub](http://hub.docker.com) at
[taverna/tomcat](https://registry.hub.docker.com/u/taverna/tomcat/).

## Image details

* **Base image**: [taverna/openjdk-jre-headless](https://registry.hub.docker.com/u/taverna/openjdk-jre-headless/)
* **Tomcat port**: 8080
* **Catalina root**: `/opt/tomcat`
* **Shared volume**: `/opt/tomcat/logs`
