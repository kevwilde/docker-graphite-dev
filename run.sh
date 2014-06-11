#!/bin/bash


if [ -f /first_run ]; then
	# Configuring Graphite-Web
	mkdir -p /opt/graphite/storage/log/webapp

	# Remove First Run indicator
	rm /first_run
fi


exec python /opt/graphite-web/bin/run-graphite-devel-server.py --libs=/opt/graphite-web/webapp/ /opt/graphite/