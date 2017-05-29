#!/usr/bin/env bash
set -eo pipefail

#
# install sbin entries
# install /etc/service.available entries
#
# @see https://github.com/phusion/baseimage-docker/tree/master/image
#
cp /build/sbin/* /sbin/ && chmod +x /sbin/*
cp -r /build/system/service.available /etc/service.available

#
# my_init environment
# @see https://github.com/phusion/baseimage-docker/tree/master/image
#
mkdir -p /etc/my_wait.d /etc/my_init.d /etc/container_environment
touch /etc/container_environment.sh /etc/container_environment.json
ln -s /etc/container_environment.sh /etc/profile.d/container_environment.sh
chmod 640 /etc/container_environment.sh /etc/container_environment.json

#
# install replacement symlinks
#
ln -s /usr/bin/pstree /usr/bin/ps
ln -s /usr/bin/htop /usr/bin/top
ln -s /usr/bin/vim.tiny /usr/bin/vim

# .bashrc
cp -f /build/system/bash.rc /root/.bashrc
