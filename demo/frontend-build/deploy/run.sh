#!/bin/bash

set -e

# Run upgrade in the background
function upgrade() {
	./manage.py migrate --noinput --no-input
	./manage.py collectstatic --noinput --no-input
}
upgrade &

# Start uwsgi
exec /usr/local/bin/uwsgi \
	--master \
	--processes 2 \
	--plugins  python3 \
	--die-on-term \
	--uwsgi-socket 0.0.0.0:80 \
	--chdir /opt/my-web-app \
	--module mywebapp.wsgi:application
