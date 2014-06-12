FROM ubuntu:latest
MAINTAINER Kevin Van Wilder <kevin@van-wilder.be>

# Installing Dependencies

RUN echo 'deb http://us.archive.ubuntu.com/ubuntu/ precise universe' >> /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y install git libcairo2-dev python python-dev python-pip python-cairo-dev supervisor

ADD ./requirements.txt /opt/graphite/requirements.txt
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Environment

ENV GRAPHITE_STORAGE_DIR /opt/graphite/storage

# Installing Dependencies

RUN pip install whisper carbon
RUN pip install -r /opt/graphite/requirements.txt

# Configuring Carbon

RUN cp /opt/graphite/conf/carbon.conf.example /opt/graphite/conf/carbon.conf
RUN cp /opt/graphite/conf/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf

# Configuring Graphite

RUN mkdir -p /opt/graphite/storage/log/webapp

# Persistent Storage 

VOLUME ["/opt/graphite", "/var/log/supervisor"]

EXPOSE 8080 2003 2004 7002 25826/udp

CMD	["/usr/bin/supervisord", "-n"]