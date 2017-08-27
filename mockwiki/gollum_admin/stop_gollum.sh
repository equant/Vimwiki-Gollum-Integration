#!/bin/bash

# stops plantuml and gollum servers relative to being started with start_gollum.sh
# This is not very robust.
# not suitable as a service script

#setup include path
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then
    DIR="$PWD"
fi

# include config
. "$DIR/config.sh"


kill -15 `cat /tmp/plantuml-$server_type-server.pid` > /dev/null 2<&1
sleep 2
proclive=`ps -ax |grep -E -e 'bin/java.*maven.*plantuml' |grep -v 'grep'`
if [ "${proclive}" ]; then
   id=`echo $proclive | awk '{print $1}'`
    echo "NOTICE: it appears that plantuml is still running with PID $id!"
fi

kill -15 `cat /tmp/gollum-$server_type-server.pid` > /dev/null 2<&1
sleep 2
proclive=`ps -ax |grep -E -e 'bin/ruby.*/bin/gollum' |grep -v 'grep'`
if [ "${proclive}" ]; then
     id=`echo $proclive | awk '{print $1}'`
     echo "NOTICE: it appears that gollum is still running with PID $id!"
fi

echo "stop_gollum.sh: done."
