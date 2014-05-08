FROM phusion/baseimage

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe > /etc/apt/sources.list.d/universe.list
RUN apt-get update -qq ;\
	 apt-get install -qqy iptables ca-certificates lxc lxde xrdp && apt-get clean;\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# This will use the latest public release. To use your own, comment it out...
ADD https://get.docker.io/builds/Linux/x86_64/docker-latest /usr/local/bin/docker
# ...then uncomment the following line, and copy your docker binary to current dir.
#ADD ./docker /usr/local/bin/docker
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/docker /usr/local/bin/wrapdocker
ADD ./01_run_xrdp.sh /etc/my_init.d/01_run_xrdp.sh
RUN chmod -x /etc/my_init.d/01_run_xrdp.sh
VOLUME /var/lib/docker
EXPOSE 3389
EXPOSE 22 
CMD wrapdocker
