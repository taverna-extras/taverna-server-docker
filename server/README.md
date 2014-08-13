# Taverna Server Docker

Docker image set up for a generic Taverna Server.

For production use you should use this as a base image and set more secure
passwords, etc.

The pre-built image is available on the [Docker Hub](http://hub.docker.com) as
[taverna/server](https://registry.hub.docker.com/u/taverna/server/).

## Image details

* **Base image**: [taverna/tomcat](https://registry.hub.docker.com/u/taverna/tomcat/)
* **Container**: Tomcat 7
* **Port**: 8080
* **Taverna user**: `taverna`
* **Taverna password**: `taverna`
* **Taverna Server root**: `/taverna-<version>` (e.g. `/taverna-2.5.4`)
* **Shared volumes**: `/opt/tomcat/logs`, `/tmp`

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
$ sudo docker pull taverna/server:<tag>
```

When running the container you will need to map the port number that tomcat
listens on to a port on your machine. In most cases you will also want to run
the container as a daemon.

The following example runs the container tagged with `2.5.4` as a daemon,
gives it a name (`t254`) and maps the tomcat port (8080) to port 8080 on the
local machine.

```shell
$ sudo docker run -p 8080:8080 -d --name t254 taverna/server:2.5.4
```

The following addresses are now accessible from your Web browser:

* `http://localhost:8080`: tomcat root.
* `http://localhost:8080/taverna-2.5.4`: Taverna Server root.

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

* `/opt/tomcat/logs`: tomcat and Taverna Server logs.
* `/tmp`: Taverna Server temporary data for each workflow execution.

Assuming you started your Taverna Server container with the name `t254`, then
to view the shared data run:

```shell
$ sudo docker run -i -t --volumes-from t254 ubuntu:14.04 /bin/bash
```

This will start an Ubuntu 14.04 container and give you an interactive bash
shell so that you can inspect the Taverna Server logs. Simply `cd` into the
logs directory:

```shell
# cd /opt/tomcat/logs
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
