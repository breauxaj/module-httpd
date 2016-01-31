#!/bin/bash
LOGDIR=/var/log/httpd
LOGS=( access_log_ error_log_ rewrite_log_ )

if [ ! -d $LOGDIR ]
then
  echo "ERROR: $LOGDIR doesn't exist. Exiting."
  exit 1
fi

for log in ${LOGS[@]}
do
  /usr/bin/find $LOGDIR/$log* -mtime +14 -exec rm -f {} \; > /dev/null 2>&1
  /usr/bin/find $LOGDIR/$log* -mtime +1 -exec gzip -v --best {} \; > /dev/null 2>&1
done
