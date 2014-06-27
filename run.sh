#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

sed -i "s,SES_USERNAME,${SES_USERNAME},g" /etc/postfix/sasl_passwd
sed -i "s,SES_API_KEY,${SES_API_KEY},g" /etc/postfix/sasl_passwd

/usr/sbin/postmap /etc/postfix/sasl_passwd

/usr/bin/supervisord
