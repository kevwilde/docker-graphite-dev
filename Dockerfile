FROM ubuntu:latest
MAINTAINER Kevin Van Wilder <kevin@van-wilder.be>

# Installing Dependencies

RUN echo 'deb http://us.archive.ubuntu.com/ubuntu/ precise universe' >> /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y install git libcairo2-dev python python-dev python-pip python-cairo-dev

ADD ./requirements.txt /opt/graphite/requirements.txt
ADD ./run.sh /run.sh
RUN chmod 770 /run.sh
RUN touch /first_run

# Installing Dependencies

RUN pip install whisper carbon
RUN pip install -r /opt/graphite/requirements.txt

# Configuring Carbon

RUN cp /opt/graphite/conf/carbon.conf.example /opt/graphite/conf/carbon.conf
RUN cp /opt/graphite/conf/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf

# Environment

ENV GRAPHITE_STORAGE_DIR /opt/graphite/storage

# Persistent Storage 

VOLUME ["/opt/graphite"]

CMD /run.sh