Usage
-----

The /opt/graphite directory is used as location for persistent storage between containers.

Clone this repository to your host system. This host contains a git submodule for `graphite-web` so we will need to initialize this one:

	$ git clone git@github.com:kevwilde/graphite-web.git

Set up a data container

	docker run --name graphite-data -v /opt/graphite/storage -i -t kevwilde/graphite-dev true

This will create a docker data container whose sole purpose is to provide volumes to be used by the other containers.

Mounting the submodule from your host inside your docker container is not done automatically for portability reasons. Instead use the `-v` argument when running Docker. We will also use the volumes provided by our data container.

	docker run --volumes-from graphite-data -v "`pwd`/graphite-web:/opt/graphite-web" -i -t kevwilde/graphite-dev
