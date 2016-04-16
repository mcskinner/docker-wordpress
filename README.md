## wordpress

This repository contains a **Dockerfile** to for running Wordpress against an
external database. For example, you can use Amazon RDS for a high-availability
backing store instead of trying to manage your own data.

Currently this requires a WordPress config to be mounted into /var/www/html,
but hopefully that restriction can be lifted to enable new installs easily.

### Base Docker Image

* [mcskinner/nginx-php](https://hub.docker.com/r/mcskinner/nginx-php)

### Usage

    docker run -d -p 80:80 \
      -v $(pwd)/config/wp-config.php:/var/www/html/wp-config.php \
      mcskinner/wordpress
