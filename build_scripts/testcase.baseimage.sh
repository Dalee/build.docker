#!/usr/bin/env bash
set -eo pipefail

# cron
echo "==> Checking cron..."
service=$(/usr/bin/sv -w 0 check /etc/service/cron-start | grep -q '^ok:')
if [ "$?" != 0 ]; then
    echo "==> FAIL: cron-start failed"
    exit 1
fi
service=$(/usr/bin/sv -w 0 check /etc/service/cron-update | grep -q '^ok:')
if [ "$?" != 0 ]; then
    echo "==> FAIL: cron-update failed"
    exit 1
fi

# smtp
echo "==> Checking presence of msmtp configuration file..."
if [ ! -f "/etc/msmtprc" ]; then
    echo "==> FAIL: no msmtp configuration installed"
    exit 1
fi
echo "==> Checking presence of sendmail wrapper..."
if [ ! -f "/usr/sbin/sendmail" ]; then
    echo "==> FAIL: no sendmail wrapper installed"
    exit 1
fi


# nginx
echo "==> Checking nginx..."
service=$(/usr/bin/sv -w 0 check /etc/service/nginx | grep -q '^ok:')
if [ "$?" != 0 ]; then
    echo "==> FAIL: nginx failed"
    exit 1
fi
