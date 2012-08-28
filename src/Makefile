# src/Makefile.  Generated from Makefile.in by configure.

all: auto-hibernate.sh

clean:

install:
	install -d $(sbindir)
	install -m 0755 auto-hibernate.sh $(sbindir)

uninstall:
	-rm $(sbindir)/auto-hibernate.sh
	-rm $(sysconfdir)/cron.d/auto-hibernate.cron

Makefile: Makefile.in ../config.status
	cd .. && ./config.status $@

../config.status: ../configure
	cd .. && ./config.status --recheck

.PHONY: all clean install uninstall
