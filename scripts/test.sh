#!/usr/bin/env bash
set -eo pipefail

function ok()
{
	echo "==> OK"
}

function fail()
{
	echo "==> FAIL"
	exit 1
}

echo "==> Checking services status"
services=`sv status /etc/service/*`
if [[ "$?" != 0 || "$services" = "" || "$services" =~ down ]]; then
    fail
else
    ok
fi
