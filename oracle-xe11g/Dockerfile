FROM oraclelinux

MAINTAINER Pedro Melo Pereira <pmelopereira@gmail.com>

# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# (1) oracle-xe-11.2.0-1.0.x86_64.rpm.zip from http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html
# (2) https://raw.githubusercontent.com/alexei-led/docker-oracle-xe-11g/master/init.ora
# (3) https://raw.githubusercontent.com/alexei-led/docker-oracle-xe-11g/master/initXETemp.ora
# ----------------------------------
# REFERENCES
# (a) http://blog.grid-it.nl/index.php/2014/05/16/installing-oracle-xe-in-a-docker-image/
# ----------------------------------
# Apex url: http://<ip>:49161/apex
# Workspace: INTERNAL
# Username: ADMIN
# Password: oracle
# ----------------------------------
# Connection
# Username: sys
# Password: oracle
# Connection type: Basic
# Role: SYSDBA
# Hostname: <ip>
# Port: 1521
# Service name: xe

# Prepare install
RUN yum install -y unzip libaio bc netstat

# Unzip files
ADD oracle-xe-11.2.0-1.0.x86_64.rpm.zip /tmp/
RUN unzip -q /tmp/oracle-xe-11.2.0-1.0.x86_64.rpm.zip -d /tmp

# Change oracle password in response file
RUN sed -i -- 's/<value required>/oracle/g' /tmp/Disk1/response/xe.rsp

# Install the Oracle XE RPM
RUN yum localinstall -y /tmp/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm

# Move the init scripts
ADD init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts/init.ora
ADD initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts/initXETemp.ora

# Configure the database
RUN /etc/init.d/oracle-xe configure responseFile=/tmp/Disk1/response/xe.rsp

# Create entries for the database in the profile
RUN echo 'export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe' >> /etc/profile.d/oracle_profile.sh
RUN echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> /etc/profile.d/oracle_profile.sh
RUN echo 'export ORACLE_SID=XE' >> /etc/profile.d/oracle_profile.sh

# Create ssh keys and change some ssh settings
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config

# Change the root and oracle password to oracle
RUN echo root:oracle | chpasswd
RUN echo oracle:oracle | chpasswd

# Expose ports 22, 1521 and 8080
EXPOSE 22
EXPOSE 1521
EXPOSE 8080

# Cleanup
RUN yum remove -y unzip
RUN rm -rf /tmp/*

# Change the hostname in the listener.ora file, start Oracle XE and the ssh daemon
CMD sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora; \
service oracle-xe start; \
/usr/sbin/sshd -D
