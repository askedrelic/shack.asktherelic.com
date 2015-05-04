FROM ubuntu:14.04
MAINTAINER Matt Behrens <askedrelic@gmail.com>

# Let the conatiner know that there is no tty
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

EXPOSE 3000

RUN apt-get update
RUN apt-get -y upgrade

# nginx?
RUN apt-get -y install nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
COPY default /etc/nginx/sites-available/default

# nice to have programs
RUN apt-get -y install curl git vim software-properties-common
# required to run the script
RUN apt-get -y install php5 php5-fpm php5-mysql php5-curl mysql-client
RUN sed -i s/\;cgi\.fix_pathinfo\s*\=\s*1/cgi.fix_pathinfo\=0/ /etc/php5/fpm/php.ini

# add all required files in /data/
ADD ./*.php /data/

RUN echo "<?php phpinfo(); ?>" > /usr/share/nginx/html/info.php
ADD ./wall.php /usr/share/nginx/html/wall.php
ADD ./index.php /usr/share/nginx/html/index.php
