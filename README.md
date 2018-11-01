[![Build Status](https://travis-ci.org/Dalee/build.docker.svg?branch=master)](https://travis-ci.org/Dalee/build.docker)

# Tiny Docker images for painless microservices deployment

## Baseimage

[![](https://images.microbadger.com/badges/image/dalee/baseimage.svg)](https://microbadger.com/images/dalee/baseimage "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/baseimage.svg)](https://microbadger.com/images/dalee/baseimage "Get your own version badge on microbadger.com")

> `baseimage` is inspired by [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker).
It uses same directory layout for defining services, patched versions of `my_init` and `setuser`
(but compatible with original one), but, build from scratch.

* Ubuntu 16.04 LTS
* Tiny size and low memory footprint
* Painless deploy
* Prebuilt images:
    * <a href="#php56">PHP 5.6</a>
    * <a href="#php71">PHP 7.1</a>
    * <a href="#php72">PHP 7.2</a>
    * <a href="#nodejs6">Node.js 6</a>
    * <a href="#nodejs8">Node.js 8</a>

### Integrated services

* [my_init](sbin/my_init) - boot manager
* [my_wait](sbin/my_wait) - dependency manager, a-la [wait-for-it](https://github.com/vishnubob/wait-for-it)
* [runit](http://smarden.org/runit/) - process supervisor
* [nginx](https://nginx.org/) - reverse proxy service, disabled by default
* [msmtp](http://msmtp.sourceforge.net/doc/msmtp.html) - smtp relay/sendmail service, disabled by default
* [bcron](https://github.com/bruceg/bcron) - cron service, disabled by default

### Container control

* <a href="#container-lifecycle">Lifecycle</a>
* <a href="#enabling-services">Enabling integrated services</a>
* <a href="#sudo-su">Running as another user</a>

### Integrated software

* [ansible](https://www.ansible.com/)
* [htop](https://packages.ubuntu.com/xenial/htop), replaces `top`
* [psmisc](https://packages.ubuntu.com/xenial/psmisc), replaces `ps`
* [vim.tiny](https://packages.ubuntu.com/xenial/vim-tiny)
* [net-tools](https://packages.ubuntu.com/xenial/net-tools)
* [make](https://packages.ubuntu.com/xenial/make)
* [curl](https://packages.ubuntu.com/xenial/curl)
* [less](https://packages.ubuntu.com/xenial/less)
* [tzdata](https://packages.ubuntu.com/xenial/tzdata)
* [ca-certificates](https://packages.ubuntu.com/xenial/ca-certificates)

> Beware, `baseimage` doesn't contain `top` and `ps` commands due Ubuntu's dependencies.
Commands `htop` and `pstree` provided as replacements.

### Defaults

* Preconfigured locales: `en_US.UTF-8`, `ru_RU.UTF-8`
* Default LANG/LC_ALL: `en_US.UTF-8`
* Default timezone: `Europe/Moscow`

<a name="container-lifecycle"></a>
### Container lifecycle

#### Boot sequence

1. wait: `/etc/my_wait.d/*`
2. run: `/etc/my_init.d/*`
3. run: `/etc/rc.local`
4. run: `/sbin/runit`
5. wait: `/etc/service/*/check`

Every wait script should exit with code:
* `0` — ready, no further call required
* `1` — wait, subsequent call required

Global wait timeout covering all scripts in phase.
Do not put `sleep` or `loop` inside of wait script, script should
check condition and return asap.

Global timeout for each `wait` phase can be configured independently:
(`--wait-resources-timeout` for `/etc/my_wait.d/` and `--wait-services-timeout`
for `/etc/service/*/check`). Default value for each timeout is 30 seconds.

If `/etc/my_wait.d/*` or `/etc/service/*/check` exceed global timeout,
container will refuse to start.

> Beware, due nature of script running, all checks will be executed
at least once, even if one check is already violated timeout.

If any of `/etc/my_init.d/*`, `/etc/rc.local` exits with non-zero exit code,
container will refuse to start.

Once all `wait` and `run` phases of boot sequence are finished,
container considered alive. No further checks will run.

#### Shutdown sequence

For alive container, on terminate/kill signal, shutdown sequence will
run:

1. run: `/etc/my_init.pre_shutdown.d/*`
2. kill: runit
3. run: `/etc/my_init.post_shutdown.d/*`

Each phase will run only if previous finished gracefully.

<a name="sudo-su"></a>
### Running as nobody / other user

`/sbin/setuser username command [arguments]`

Command environment will be explicitly filled with container defined
environment variables. Variables filled without overwriting, so,
call `NODE_ENV=staging /sbin/setuser env | grep NODE_ENV` will print
`staging` no matter what is defined in `/etc/container_environment/NODE_ENV`.

<a name="enabling-services"></a>
### Enabling integrated services

#### Cron

* Repository: [official](https://packages.ubuntu.com/xenial/bcron)
* Dockerfile: `RUN /sbin/enable_service cron`
* Configure: `/etc/crontab`

> Beware, `cron` will run tasks with reduced set of environment variables,
if your script need access to all container environment variables,
run task via `/sbin/setuser` command.

Sample `/etc/crontab` file:
```
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# script WITH container environment variables
* * * * * root /sbin/setuser nobody /app/app_cron.sh

# script WITHOUT container environment variables
* * * * * root /app/system_cleanup.sh
```

#### Sendmail / msmtp

* Repository: [official](https://packages.ubuntu.com/xenial/msmtp)
* Dockerfile: `RUN /sbin/enable_service sendmail`
* Configure: provide environment variables on container start:
    * `SENDMAIL_HOST` - ip address or domain name of SMTP server
    * `SENDMAIL_PORT` - override smtp port, default is `25`
    * `SENDMAIL_DOMAIN` - force outbound `from:`

Sample `docker run` command:
```
docker run --rm \
	-e SENDMAIL_HOST="mail.example.com" \
	...
```

#### Nginx

* Repository: [nginx/stable](http://nginx.org/en/linux_packages.html#stable)
* Dockerfile: `RUN /sbin/enable_service nginx`
* Configure:
    * create project config (with `.conf` extension) in `/etc/nginx/virtuals` directory
    * if [default config](system/service.available/nginx/nginx.conf) is not suitable,
    just create desired `/etc/nginx/nginx.conf`, baseimage will not override it.

> Do not use `daemon off`, [run script](system/service.available/nginx/nginx/run) will provide
this option by default.

<a name="nodejs6"></a>
## Node.JS 6

[![](https://images.microbadger.com/badges/image/dalee/nodejs-6.svg)](https://microbadger.com/images/dalee/nodejs-6 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/nodejs-6.svg)](https://microbadger.com/images/dalee/nodejs-6 "Get your own version badge on microbadger.com")

> Image is squashed, so actually it contains only two layers.

* Node.js 6 Maintenance LTS
* Yarn

`docker pull dalee/nodejs-6`

<a name="nodejs8"></a>
## Node.JS 8

[![](https://images.microbadger.com/badges/image/dalee/nodejs-8.svg)](https://microbadger.com/images/dalee/nodejs-8 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/nodejs-8.svg)](https://microbadger.com/images/dalee/nodejs-8 "Get your own version badge on microbadger.com")

> Image is squashed, so actually it contains only two layers.

* Node.js 8 Active LTS
* Yarn

`docker pull dalee/nodejs-8`

<a name="php56"></a>
## PHP 5.6

[![](https://images.microbadger.com/badges/image/dalee/php-5.6.svg)](https://microbadger.com/images/dalee/php-5.6 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/php-5.6.svg)](https://microbadger.com/images/dalee/php-5.6 "Get your own version badge on microbadger.com")

> Image is squashed, so actually it contains only two layers.

* PHP 5.6
* Composer
* XDebug extension (disabled by default)

`docker pull dalee/php-5.6`

<a name="php71"></a>
## PHP 7.1

[![](https://images.microbadger.com/badges/image/dalee/php-7.1.svg)](https://microbadger.com/images/dalee/php-7.1 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/php-7.1.svg)](https://microbadger.com/images/dalee/php-7.1 "Get your own version badge on microbadger.com")

> Image is squashed, so actually it contains only two layers.

* PHP 7.1
* Composer
* XDebug extension (disabled by default)

`docker pull dalee/php-7.1`

<a name="php72"></a>
## PHP 7.2

[![](https://images.microbadger.com/badges/image/dalee/php-7.2.svg)](https://microbadger.com/images/dalee/php-7.2 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/dalee/php-7.2.svg)](https://microbadger.com/images/dalee/php-7.2 "Get your own version badge on microbadger.com")

> Image is squashed, so actually it contains only two layers.

* PHP 7.2
* Composer
* XDebug extension (disabled by default)

`docker pull dalee/php-7.2`

## Releases

* `latest` — latest `master` branch
* `vX.Y.Z` — tagged release
