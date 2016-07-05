FROM phusion/baseimage:0.9.18
MAINTAINER Stian Larsen <lonixx@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV APTLIST="libmono-cil-dev python nzbdrone"

# Configure nzbdrone's apt repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC && \
echo "deb http://apt.sonarr.tv/ master main" > /etc/apt/sources.list.d/sonarr.list && \
apt-add-repository ppa:mc3man/trusty-media -y && \
apt-get update -q && \
apt-get install $APTLIST -qy && \
apt-get install python-pip -qy && \
apt-get install ffmpeg -qy && \
apt-get clean && \
curl https://bootstrap.pypa.io/ez_setup.py -O - | python && \
pip install requests && \
pip install requests[security] && \
pip install requests-cache && \
pip install babelfish && \
pip install "guessit<2" && \
pip install subliminal && \
pip install deluge-client && \
pip install qtfaststart && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
# RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

 

#Ports and Volumes
VOLUME /config /downloads /tv
EXPOSE 8989
