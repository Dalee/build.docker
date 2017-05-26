[![Build Status](https://travis-ci.org/Dalee/build.docker.svg?branch=master)](https://travis-ci.org/Dalee/build.docker)

# Docker base images

* Baseimage (ideas and my_init/setuser scripts borrowed from [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker))
* NodeJS
* PHP 5.6

## Baseimage

[![](https://images.microbadger.com/badges/image/dalee/baseimage.svg)](https://microbadger.com/images/dalee/baseimage "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/baseimage.svg)](https://microbadger.com/images/dalee/baseimage "Get your own version badge on microbadger.com")

* [bcron](https://github.com/bruceg/bcron)
* [ansible](https://www.ansible.com/)
* a small set of useful utilities (curl, vim-tiny, htop, etc..)

## Node.JS 6

> Image is squashed, so actually it contains only two layers.

[![](https://images.microbadger.com/badges/image/dalee/nodejs-6.svg)](https://microbadger.com/images/dalee/nodejs-6 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/nodejs-6.svg)](https://microbadger.com/images/dalee/nodejs-6 "Get your own version badge on microbadger.com")

* Nginx mainline (disabled by default)
* Node.JS 6 LTS
* Yarn

## PHP 5.6

> Image is squashed, so actually it contains only two layers.

[![](https://images.microbadger.com/badges/image/dalee/php-5.6.svg)](https://microbadger.com/images/dalee/php-5.6 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/php-5.6.svg)](https://microbadger.com/images/dalee/php-5.6 "Get your own version badge on microbadger.com")

* Nginx mainline (disabled by default)
* PHP 5.6
* Composer
* XDebug extension (disabled by default)
