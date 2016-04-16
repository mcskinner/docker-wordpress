# Start from a PHP-enabled NGINX image.
FROM mcskinner/nginx-php
MAINTAINER Michael Skinner <git@mcskinner.com>

# Install the WordPress requirements.
RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl

# And tweak the configs.
RUN find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

# Then install Wordpress itself into /var/www/html
ADD https://wordpress.org/latest.tar.gz /var/www/latest.tar.gz
RUN cd /var/www/ && tar xvf latest.tar.gz && rm latest.tar.gz && \
  rm -rf /var/www/html && mv /var/www/wordpress /var/www/html && \
  mv /usr/share/nginx/html/50x.html /var/www/html/ && \
  chown -R www-data:www-data /var/www/html

# Add in our nginx site config that knows about WordPress.
ADD ./nginx-wordpress-site.conf /etc/nginx/sites-available/default

# Boot up via the nginx-php Supervisor defaults.
