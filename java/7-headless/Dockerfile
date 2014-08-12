# DOCKER-VERSION 0.3.4

FROM debian:jessie

MAINTAINER support@mygrid.org.uk

# Set version to install here
ENV JAVA_VERSION 7u65

# Install Headless JRE after updating installed packages.
RUN apt-get update -qqy
RUN apt-get upgrade -qqy
RUN apt-get install -qqy openjdk-7-jre-headless="${JAVA_VERSION}"*
RUN apt-get clean
