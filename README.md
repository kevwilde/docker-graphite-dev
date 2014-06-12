## Warning

	THIS CONTAINER SHOULD NEVER EVER EVER BE USED IN PRODUCTION. IT RUNS A DEVELOPMENT SERVER WITH JUST ENOUGH CONFIGURATION TO RUN.

## Usage

The `/opt/graphite` directory is used as location for persistent storage between containers.

Clone this repository to your host system. This host contains a git submodule for `graphite-web` so we will need to initialize this one:

	$ git clone git@github.com:kevwilde/docker-graphite-dev.git

Set up a data container

	$ docker run --name graphite-data -v /opt/graphite/storage -i -t kevwilde/graphite-dev true

This will create a docker data container whose sole purpose is to provide volumes to be used by the other containers.


	$ docker run --volumes-from graphite-data -v "`pwd`/graphite-web:/opt/graphite-web" -i -t kevwilde/graphite-dev python /opt/graphite-web/webapp/graphite/manage.py syncdb --noinput

### Running the Container

Let's now run the container to start our development server. Mounting the submodule from your host inside your docker container is not done automatically for portability reasons. Instead use the `-v` argument when running Docker. We will also use the volumes provided by our data container.

	$ docker run -p 8080:8080 --volumes-from graphite-data -v "`pwd`/graphite-web:/opt/graphite-web" -i -t kevwilde/graphite-dev

If you wish to send data to graphite from your host machine, don't forget to add these ports:

	-p 2003:2003

### Started Processes

The following processes are being managed by supervisord inside the container:

 * **carbon-cache.py**

	   The carbon daemon running on port 2003. Client applications use it to send metrics.

	   Tis is done in the following format:

	   	my.metric.value value unix_timestamp

	   For example:

	   	performance.servers.www01.cpuUsage 42.5 1208815315

 * **run-graphite-devel-server.py**
    
       The development server for `graphite-web`. This automatically restarts the server when the code has been changed.

 * **examples/example-client.py"**
   	
   	   This application sends some CPU-related statistics to the carbon daemon to populate it with some metrics.
