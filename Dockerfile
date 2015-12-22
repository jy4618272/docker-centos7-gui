FROM babim/centos7base

MAINTAINER "Duc Anh Babim" <ducanh.babim@yahoo.com>
    
RUN yum groupinstall "GNOME Desktop" "Graphical Administration Tools" -y && \
    yum install gedit file-roller firefox nano iputils tigervnc-server openssh-server -y && \
    yum clean all

RUN echo 'root:root' | chpasswd && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config

ADD runssh.sh /usr/sbin/runssh.sh
RUN chmod +x /usr/sbin/runssh.sh

ENV AUTHORIZED_KEYS **None**
ENV LC_ALL en_US.UTF-8
ENV TZ Asia/Ho_Chi_Minh
# Define working directory.
WORKDIR /data

# Define default command.
CMD ["vncserver"]

# Expose ports.
EXPOSE 5901 22

CMD ["/usr/sbin/runssh.sh"]
