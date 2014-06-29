#!/bin/sh

USER=www-data

RACK_ENV=none
RAILS_ENV=production

#check for correct user
if [ `whoami` != "$USER" ]; then
  echo "This script should be run as $USER";
  exit
fi


#Normal daemon-esque script:
case "$1" in
start)
	echo "Starting..."
	bundle exec unicorn -c config/unicorn.rb -D
	;;
stop)
	echo "Stoping..."
	kill `cat /tmp/fcfm.info.pid 2>/dev/null` 2>/dev/null #throw away any output.
	;;
restart)
	$0 stop
	sleep 10
	$0 start
	;;
*)
	echo "Usage: $0 start|stop|restart";
esac
