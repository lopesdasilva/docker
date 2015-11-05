FROM oraclelinux

MAINTAINER Pedro Melo Pereira <pmelopereira@gmail.com>

RUN yum install -y wget
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm" -P /tmp
RUN yum localinstall -y /tmp/jdk-7u79-linux-x64.rpm

ENV JAVA_HOME /usr/java/jdk1.7.0_79
RUN echo 'export JAVA_HOME=/usr/java/jdk1.7.0_79' >> /etc/bashrc
ENV PATH $JAVA_HOME/bin:$PATH
RUN echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/bashrc

# Cleanup
RUN rm -rf /tmp/*
