FROM index.docker.io/debian:8

MAINTAINER webqop <webqop@gmail.com>

RUN apt-get update && \
    apt-get install -y wget python busybox openssh-server openssh-client && \
    apt-get clean

ADD rootfs.tar.xz /

RUN echo 'root:webqop' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22
EXPOSE 443
EXPOSE 6666
EXPOSE 44494

VOLUME ["/opt/config"]

CMD ["/etc/rc.local"]
