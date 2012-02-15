#!/bin/bash
# 0 program is running or service is OK
# 1 program is dead and /var/run pid file exists
# 2 program is dead and /var/lock lock file exists
# 3 program is not running
# 4 program or service status is unknown

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
PID_FILE=$ROOT/httpd/logs/httpd.pid

if [ -e $PID_FILE ]
then
  PID=$(cat $PID_FILE)

  kill -0 $PID >> /dev/null 2>&1
  running=$?
  echo $running
  if [[ "$running" == "0" ]]
  then
    echo "running"
  else 
    echo "pidfile exists, but not running"
  fi
  exit $running
else
  echo "not running"
  exit 3
fi
