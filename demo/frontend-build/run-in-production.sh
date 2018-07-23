#!/bin/bash
#
# This file is an example of how you would invoke this service in production.
# You should use something like OpenShift, Kubernetes, Docker Cloud, or another
# orchestration service in order to actually run your application

HERE="$( cd $( dirname -- "$0" ) ; pwd -P )"
cd "$HERE"

name='mywebapp'

# The name of various services
app_name="${name}_django"
network_name="${name}_network"
database_name="${name}_database"
nginx_name="${name}_nginx"

# Where to store static files and uploaded media
data="${HERE}/assets"
mkdir -p "${data}"

# Nginx config
nginx_config="${HERE}/nginx.conf"
cat > "${nginx_config}" <<NGINX
upstream uwsgi_app {
	# How to reach the application
	server ${app_name}:80;
}

server {
	listen 80;
	server_name _;

	location / {
		# Serve the application
		uwsgi_pass uwsgi_app;
		include uwsgi_params;
	}

	location @app {
		# Named location to serve the application
		uwsgi_pass uwsgi_app;
		include uwsgi_params;
	}

	location /assets {
		# Serve static files and media
		autoindex on;
		alias /opt/assets;
		try_files \$uri \$uri/ @app;
	}
}
NGINX


echo "Making '${network_name}' network"
docker network create "${network_name}"
echo ""


echo "Starting the database container '${database_name}'"
docker run \
	--rm -d \
	--name "${database_name}" \
	--network "${network_name}" \
	postgres
echo ""


echo "Waiting for database"
sleep 5
echo ""


echo "Starting the Django container '${app_name}'"
docker run \
	--rm \
	--detach \
	--name "${app_name}" \
	--hostname "${app_name}" \
	--network "${network_name}" \
	--env DATABASE_URL="postgres://postgres@${database_name}/postgres" \
	--env DJANGO_DEBUG=0 \
	--env DJANGO_HOSTNAME='mywebapp.example.com' \
	--env DJANGO_SECRET_KEY='123abc' \
	--env DJANGO_STATIC_ROOT='/opt/my-web-app/assets/static/' \
	--volume "${data}:/opt/my-web-app/assets" \
	--init \
	basic_backend
echo ""


echo "Starting the nginx container '${nginx_name}'"
docker run \
	--rm \
	--detach \
	--name "${nginx_name}" \
	--network "${network_name}" \
	--volume "$nginx_config:/etc/nginx/conf.d/default.conf" \
	--volume "${data}:/opt/assets/" \
	-p 80:80 \
	nginx


echo ""
echo "Run 'docker logs --follow ${app_name}' in another terminal to watch the Django process"
echo ""
echo "Press Ctrl+C to quit..."


# Do nothing for a bit
trap 'echo ""' INT
sleep infinity


echo "Cleaning up..."
rm -rf "${data}"
docker stop "${app_name}" "${nginx_name}" "${database_name}"
docker network rm "${network_name}"
