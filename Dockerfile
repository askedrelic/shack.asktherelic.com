FROM ubuntu:14.04
MAINTAINER Matt Behrens <askedrelic@gmail.com>

# Install useful programs, the right way
RUN     apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
            curl \
            git \
            vim \
            software-properties-common \
            php5 \
            php5-fpm \
            php5-mysql \
            php5-curl \
            mysql-client \
            nginx \
        && apt-get clean

# Force UTF8
RUN     /usr/sbin/locale-gen en_US.UTF-8
ENV     LANG en_US.UTF-8

# Fix default PHP config
RUN     sed -i s/\;cgi\.fix_pathinfo\s*\=\s*1/cgi.fix_pathinfo\=0/ /etc/php5/fpm/php.ini
# Fix PHP to allow env variables
RUN     sed -i 's/variables_order\s*=\s*"GPCS"/variables_order="EGPCS"/' /etc/php5/fpm/php.ini
# Use DB_USER from dokku env
RUN     echo 'env[DB_USER] = $DB_USER' >> /etc/php5/fpm/pool.d/www.conf

# Add my nginx conf
ADD     nginx.conf /etc/nginx/nginx.conf
RUN     mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
COPY    default /etc/nginx/sites-available/default

# RUN echo "<?php phpinfo(); ?>" > /usr/share/nginx/html/info.php
# add all required files in /data/
ADD     ./*.php /usr/share/nginx/html/
ADD     ./*.css /usr/share/nginx/html/
ADD     ./css/ /usr/share/nginx/html/css/
ADD     ./images/ /usr/share/nginx/html/images/

# Add checks for dokku
ADD     ./CHECKS /app/CHECKS

CMD     ["service", "php5-fpm", "start", "&&", "nginx"]
EXPOSE  80
