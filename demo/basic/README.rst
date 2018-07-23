Minimal 🐍 Django + 🐋 Docker application example
===============================================

This directory contains an example of a Django application running in a Docker container.
The Django application is deliberately simple, intended to show off the Docker integration.
The Django application runs as a WSGI server, managed uwsgi daemon.
Nginx sits in front of this as a web server, also serving the front end assets.

To run this example application in development mode:

.. code-block:: python

	$ docker-compose build
	$ docker-compose up
	# In another terminal
	$ docker-compose exec backend ./manage.py migrate

For an example of how to run it and its required applications in production:

.. code-block:: python

	$ docker-compose build
	$ ./run-in-production.sh

Note that you should use some sort of orchestration service
to start all the required services in production,
rather than the example script.
The example script merely shows what services are required and how to connect them.
