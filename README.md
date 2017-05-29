[![Build Status](https://travis-ci.org/Dalee/build.docker.svg?branch=master)](https://travis-ci.org/Dalee/build.docker)

# Baseimage

[![](https://images.microbadger.com/badges/image/dalee/baseimage.svg)](https://microbadger.com/images/dalee/baseimage "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/baseimage.svg)](https://microbadger.com/images/dalee/baseimage "Get your own version badge on microbadger.com")

> `docker pull dalee/baseimage`

* Ubuntu 16.04 LTS (ideas and my_init/setuser scripts taken from [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker))
* Tiny size and low memory footprint (~4.5MB)
* Integrated services:
    * [nullmailer](https://github.com/bruceg/nullmailer)
    * [bcron](https://github.com/bruceg/bcron)
* Integrated software:
    * [ansible](https://www.ansible.com/)
    * a small set of useful utilities (curl, vim-tiny, htop, etc..)
    
## Enabling integrated services

## Cron

In Dockerfile:
`/sbin/enable_service cron`

Put cronjobs to `/etc/crontab`

## Sendmail

In Dockerfile:
`/sbin/enable_service sendmail`

set environment variables:
* `NULLMAIL_REMOTES` - see 
http://manpages.ubuntu.com/manpages/xenial/man8/nullmailer-send.8.html 
(section `CONTROL FILES`, `remotes`)
* `NULLMAIL_HOSTNAME` - hostname for EHLO (default is "docker")

## Node.JS 6

> Image is squashed, so actually it contains only two layers.

[![](https://images.microbadger.com/badges/image/dalee/nodejs-6.svg)](https://microbadger.com/images/dalee/nodejs-6 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/nodejs-6.svg)](https://microbadger.com/images/dalee/nodejs-6 "Get your own version badge on microbadger.com")

* Nginx mainline (disabled by default)
* Node.JS 6 LTS
* Yarn

`docker pull dalee/nodejs-6`

## PHP 5.6

> Image is squashed, so actually it contains only two layers.

[![](https://images.microbadger.com/badges/image/dalee/php-5.6.svg)](https://microbadger.com/images/dalee/php-5.6 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/php-5.6.svg)](https://microbadger.com/images/dalee/php-5.6 "Get your own version badge on microbadger.com")

* Nginx mainline (disabled by default)
* PHP 5.6
* Composer
* XDebug extension (disabled by default)

`docker pull dalee/php-5.6`
