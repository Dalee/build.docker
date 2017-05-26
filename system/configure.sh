#!/usr/bin/env bash
set -eo pipefail

# my_init system
# @see https://github.com/phusion/baseimage-docker/tree/master/image
cp /build/sbin/my_init /sbin/
chmod +x /sbin/my_init

cp /build/sbin/setuser /sbin/
chmod +x /sbin/setuser

# my_init environment
# @see https://github.com/phusion/baseimage-docker/tree/master/image
mkdir -p /etc/my_init.d /etc/container_environment
touch /etc/container_environment.sh /etc/container_environment.json
ln -s /etc/container_environment.sh /etc/profile.d/container_environment.sh
chmod 640 /etc/container_environment.sh \
    /etc/container_environment.json \

# replacements
ln -s /usr/bin/pstree /usr/bin/ps
ln -s /usr/bin/htop /usr/bin/top
ln -s /usr/bin/vim.tiny /usr/bin/vim

# .bashrc
cp -f /build/system/bash.rc /root/.bashrc

# cron service
# @see https://github.com/bruceg/bcron
rm -rf /etc/cron.*
mkdir -p /var/spool/cron/crontabs /var/spool/cron/tmp
mkfifo /var/spool/cron/trigger
chmod go-rwx /var/spool/cron/crontabs
chmod go-rwx /var/spool/cron/tmp
chmod go-rwx /var/spool/cron/trigger

mkdir -p /etc/service/cron-schedule /etc/service/cron-update
cp /build/system/cron-schedule.runit /etc/service/cron-schedule/run
cp /build/system/cron-update.runit /etc/service/cron-update/run
chmod +x /etc/service/cron-schedule/run /etc/service/cron-update/run

touch /etc/crontab
chmod 600 /etc/crontab
