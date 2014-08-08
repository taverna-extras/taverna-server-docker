# taverna-server-docker

Docker image set up for a generic Taverna Server.

The pre-built image is available on the [Docker Hub](http://hub.docker.com) as
[taverna/server](https://registry.hub.docker.com/u/taverna/server/).

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
$ sudo docker pull taverna/server:254
```

When running the container you will need to map the port number that tomcat
listens on to a port on your machine. In most cases you will also want to run
the container as a daemon.

The following example runs the container as a daemon, gives it a name (`t254`)
and maps the tomcat port (8080) to port 3000 on the local machine.

```shell
$ sudo docker run -p 3000:8080 -d --name t254 -t taverna/server:254
```

The following addresses are now accessible from your Web browser:

* `http://localhost:3000`: tomcat root.
* `http://localhost:3000/taverna-254`: Taverna Server root.

### Building the image from scratch

Clone this repository to your local machine and run:

```shell
$ sudo docker build -t <yourname>/<imagename>:<tag> .
```

Note the `.` on the end of the line. `yourname`, `imagename` and `tag` can be
whatever you like but should be sensible of you will be uploading the resulting
image to the [Docker Hub](http://hub.docker.com)

You can now run the resulting image as above:

```shell
$ sudo docker run -p 3000:8080 -d --name t254 -t <yourname>/<imagename>:<tag>
```

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
