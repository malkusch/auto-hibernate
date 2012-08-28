#!/bin/sh

LOCKFILE=/var/lock/auto-hibernate.lock
TIMESTAMP=/tmp/auto-hibernate.time
TIMEOUT=30MINUTES
HIBERNATE=/usr/sbin/hibernate-ram
LOGGER='logger -t "auto-hibernate"'

function cleanup {
	rm -f $TIMESTAMP
	rmdir $LOCKFILE
	set -e
}

# be exclusive
mkdir $LOCKFILE || exit 1
set +e

# no screen sessions
sessions=$(ps a | grep screen | grep -v "grep" | wc -l)
if [ ! $sessions = 0 ]; then
	$LOGGER "screen prevents hibernation"
	cleanup
        exit 1
fi

#no network connections
netstat=$(LC_ALL=C netstat --inet -n -v -a 2>>/dev/null | grep -v LISTEN | wc -l)
if [ ! $netstat = 2 ]; then
        $LOGGER "network connections prevents hibernation"
        cleanup
        exit 1
fi

# no users
who -q | tail -n 1 | grep -qv "=0$"
if [ $? = 0 ]; then
	$LOGGER "logged in user prevents hibernation"
	cleanup
	exit 1
fi

# preconditions must be valid for a period of time
if [ ! -e $TIMESTAMP ]; then
	touch -d "$TIMEOUT" $TIMESTAMP
fi
if [ $TIMESTAMP -nt $LOCKFILE ]; then
	$LOGGER "preconditions not old enough"
	rmdir $LOCKFILE
        set -e
	exit 1
fi

# Everything should be fine for hibernation
$LOGGER "hibernate"
$HIBERNATE
cleanup