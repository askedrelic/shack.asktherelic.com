FROM ubuntu:14.04
MAINTAINER Matt Behrens <askedrelic@gmail.com>

# Let the conatiner know that there is no tty
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true


RUN apt-get update
RUN apt-get -y upgrade

# nice to have programs
RUN apt-get -y install curl \
    git vim software-properties-common \
    php5 php5-fpm php5-mysql php5-curl mysql-client \
    nginx

# required to run the script
RUN sed -i s/\;cgi\.fix_pathinfo\s*\=\s*1/cgi.fix_pathinfo\=0/ /etc/php5/fpm/php.ini
RUN sed -i 's/variables_order\s*=\s*"GPCS"/variables_order="EGPCS"/' /etc/php5/fpm/php.ini
RUN echo 'env[DB_USER] = $DB_USER' >> /etc/php5/fpm/pool.d/www.conf

# nginx config
ADD nginx.conf /etc/nginx/nginx.conf
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
COPY default /etc/nginx/sites-available/default


# RUN echo "<?php phpinfo(); ?>" > /usr/share/nginx/html/info.php
# add all required files in /data/
ADD ./*.php /usr/share/nginx/html/
ADD ./*.css /usr/share/nginx/html/
ADD ./css/ /usr/share/nginx/html/css/
ADD ./images/ /usr/share/nginx/html/images/

ADD ./CHECKS /app/CHECKS
ADD ./nginx.conf.template /app/
ADD ./nginx.conf.sigil /app/

EXPOSE 80
CMD service php5-fpm start && nginx
