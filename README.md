# Taverna Server Docker

Docker image set up for a generic [Taverna Server](http://taverna.incubator.apache.org/documentation/server/).

For production use you should use this as a base image and set more secure
passwords, etc.

The pre-built image is available on the [Docker Hub](http://hub.docker.com) as
[taverna/taverna-server](https://registry.hub.docker.com/u/taverna/taverna-server/).

## Image details

* **Base image**: [tomcat](https://registry.hub.docker.com/u/_/tomcat/) 7
* **Container**: Tomcat 7/OpenJDK 7 (base image [tomcat](https://registry.hub.docker.com/u/library/tomcat/))
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

The following example runs the container tagged with `2.5.4` as a daemon,
gives it a name (`t254`) and maps the port 8080 on the local machine
to go to the Tomcat port (8080) within the Docker container.

```shell
$ sudo docker run -p 8080:8080 -d --name t254 taverna/taverna-server:2.5.4
```

The following addresses are now accessible from your Web browser:

* `http://localhost:8080`: Taverna Server root

Note that the hostname you first access Taverna Server with will be used in 
subsequent replies, so remember to access with the full hostname if the
installation is to be used outside `localhost`.

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

You can see the Tomcat logs from a running docker container named `t254` using:

```shell
docker logs t254
```

Assuming you started your Taverna Server container with the name `t254`, then
to view the shared data run:

```shell
$ sudo docker run -i -t --volumes-from t254 ubuntu:14.04 /bin/bash
```

This will start an Ubuntu 14.04 container and give you an interactive bash
shell so that you can inspect the Taverna Server `/tmp`. Simply `cd` into the
logs directory:

```shell
# cd /tmp
# ls
```

## Known issues

* Problem routing interaction requests internally
  ([T3-809](http://dev.mygrid.org.uk/issues/browse/T3-809)). A workaround is
  to ensure that the tomcat port in the container is always mapped to the same
  port number on the local machine for now, e.g.

  ```shell
  $ sudo docker run -p 8080:8080 -d --name t254 taverna/server:2.5.4
  ```
* The URL you first access the Taverna Server with is remembered by the server
  for the returned links, so be sure to use the full hostname to avoid
  exposing `http://localhost:8080/rest` unless you only want to expose
  the server to localhost.  This can be a problem if you are using
  `--link` to access the server from a different docker image, as
  you will need to ensure a consistent hostname. 


