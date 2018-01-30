# Taverna Server Docker

Docker image set up for [Apache Taverna Server](https://taverna.incubator.apache.org/download/server/).

See the [documentation](http://taverna.incubator.apache.org/documentation/server/) for details.

For production use you should use this as a base image and set more secure
passwords, etc.

The pre-built image is available on the [Docker Hub](http://hub.docker.com) as
[taverna/taverna-server](https://hub.docker.com/r/taverna/taverna-server/).

## Image details

* **Base image**: [tomcat](https://registry.hub.docker.com/u/_/tomcat/):8-jre8
* **Port**: 8080 (http), 8009 (AJP)
* **Taverna user**: `taverna`
* **Taverna password**: `taverna`
* **Taverna Server root**: `/`
* **Shared volumes**: `/tmp`
* **REST API**: `http://localhost:8080/rest/`  (replace with full hostname)
* **WSDL API**: `http://localhost:32778/soap?wsdl`  (replace with full hostname)

## Usage

It is assumed that you have installed [Docker](http://docker.io) on your
machine. There are
[comprehensive installation instructions](http://docs.docker.com/installation/)
for many platforms on the [Docker documentation site](http://docs.docker.com/).

Please refer to the [Docker User Guide](http://docs.docker.com/userguide/) for
the following sections.

### Using the pre-built image

You can pull the pre-built image in the usual way:

```shell
$ sudo docker pull taverna/taverna-server:<tag>
```

When running the container you will need to map the port number that tomcat
listens on to a port on your machine. In most cases you will also want to run
the container as a daemon.

The following example runs the container tagged with `3.1.0` as a daemon,
gives it a name (`taverna`) and maps the port 8081 on the local machine
to go to the Tomcat port (8080) within the Docker container.

```shell
$ sudo docker run -p 8081:8080 -d --name taverna taverna/taverna-server:3.1.0
```

The following addresses are now accessible from your Web browser:

* `http://localhost:8081`: Taverna Server root

Note that the hostname you first access Taverna Server with will be used in 
subsequent replies, so remember to access with the full hostname if the
installation is to be used outside `localhost`.

### Default users
The docker image has 3 default users included, see the file users.properties for more info.  
taverna: password 'taverna'  
taverna_alt: password 'qwerty'  
admin: password ADMIN  
You should change these via the admin interface available via `/admin`.

### Building the image from scratch

Clone this repository to your local machine and run:

```shell
$ sudo docker build -t <yourname>/<imagename>:<tag> server/
```

or

```shell
$ cd server
$ sudo docker build -t <yourname>/<imagename>:<tag> .
```

`yourname`, `imagename` and `tag` can be whatever you like but should be
sensible if you will be uploading the resulting image to the
[Docker Hub](http://hub.docker.com)

You can now run the resulting image as above:

```shell
$ sudo docker run -p 8080:8080 -d <yourname>/<imagename>:<tag>
```

Add a `--name` option if you would rather not let docker assign a default name
for your container.

### Debugging a running container

The container share some useful volumes so that you can see what is happening
while it is running. You can simply run another container and connect to these
volumes to see logs and temporary files in the Taverna Server container. The
volumes exported are:

* `/tmp`: Taverna Server temporary data for each workflow execution.

You can see the Tomcat logs from a running docker container named `taverna` using:

```shell
docker logs taverna
```

Assuming you started your Taverna Server container with the name `taverna`, then
to view the shared data run:

```shell
$ sudo docker run -i -t --volumes-from taverna ubuntu:14.04 /bin/bash
```

You can also jump into the running Taverna Server Tomcat container using:

```shell
$ sudo docker exec -it taverna /bin/bash
```

