#!/bin/sh

LOCKFILE=/var/lock/auto-hibernate.lock
TIMESTAMP=/tmp/auto-hibernate.time
TIMEOUT=30MINUTES

function cleanup {
	rm -f $TIMESTAMP
	rmdir $LOCKFILE
	set -e
}

# be exclusive
mkdir $LOCKFILE || exit 1
set +e

# keine screen session
sessions=$(ps a | grep screen | grep -v "grep" | wc -l)
if [ ! $sessions = 0 ]; then
	logger -t "auto-hibernate" "Screen sessions sind vorhanden"
	cleanup
        exit 1
fi

# keine SMB-Nutzung
smbstatus -S | grep machine -A 2 | tail -n1 | egrep -q ".{1,}"
if [ $? = 0 ]; then
        logger -t "auto-hibernate" "Samba ist in Nutzung"
        cleanup
        exit 1
fi

# kein angemeldeter Benutzer
who -q | tail -n 1 | grep -qv "=0$"
if [ $? = 0 ]; then
	logger -t "auto-hibernate" "Benutzer sind angemeldet"
	cleanup
	exit 1
fi

# obige Bedingungen sind mind. 10 Minuten alt
if [ ! -e $TIMESTAMP ]; then
	touch -d "$TIMEOUT" $TIMESTAMP
fi
if [ $TIMESTAMP -nt $LOCKFILE ]; then
	logger -t "auto-hibernate" "Ruhedauer noch nicht erreicht"
	rmdir $LOCKFILE
        set -e
	exit 1
fi

# Zeit zum Schlafen gehen
logger -t "auto-hibernate" "automatisches Schlafen"
/usr/sbin/hibernate-ram
cleanup
