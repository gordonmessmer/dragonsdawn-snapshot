# Makefile for snapshot

VERSION		= 0.1

DESTDIR		=

sbindir		= /usr/sbin
mandir		= /usr/share/man
libdir		= /usr/lib/snapshot

all: snapshot.spec doc/snapshot.1 doc/start-snapshot.1

snapshot.spec: snapshot.spec.in Makefile
	sed -e s/@VERSION@/$(VERSION)/ < snapshot.spec.in > snapshot.spec

doc/snapshot.1: doc/snapshot.sgml
	cd doc && docbook2man snapshot.sgml

doc/start-snapshot.1: doc/start-snapshot.1
	cd doc && docbook2man start-snapshot.sgml

install: all
	install		-d $(DESTDIR)$(sbindir)
	install		-d $(DESTDIR)$(mandir)/man1
	install -m 444	-t $(DESTDIR)$(mandir)/man1 doc/*.1
	install		-d $(DESTDIR)$(libdir)/filesystems.d
	install	-m 755	-t $(DESTDIR)$(libdir)/filesystems.d src/filesystems/*
	install		-d $(DESTDIR)$(libdir)/writers.d
	install	-m 755	-t $(DESTDIR)$(libdir)/writers.d src/writers/*
	install	-m 755	-t $(DESTDIR)$(sbindir) src/snapshot src/start-snapshot src/stop-snapshot
	test -e $(DESTDIR)/etc/qemu/fsfreeze-hook.d || \
		ln -s	$(libdir)/writers.d $(DESTDIR)/etc/qemu/fsfreeze-hook.d

clean:
	rm -f snapshot.spec doc/manpage.* doc/*.1
