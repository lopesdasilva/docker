FROM pmelopereira/tomcat

MAINTAINER Pedro Melo Pereira <pedro.melo.pereira@celfocus.com>

# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# (1) omii.ini
# ----------------------------------

# Required packages
RUN yum clean all
RUN yum install -y tar libXtst xhost less

# Add groups
RUN /usr/sbin/groupadd -g 501 oinstall

# Add users
RUN useradd -u 1010 -g oinstall -G ftp sites
RUN echo "sites" | passwd --stdin sites

# Install WCS
RUN mkdir -p /app/sites/auth/home
RUN mkdir -p /app/sites/auth/shared
RUN chown -R sites:oinstall	 /app/sites
ADD omii.ini /tmp/
