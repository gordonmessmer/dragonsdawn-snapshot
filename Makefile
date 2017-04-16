# Makefile for snapshot

VERSION		= 0.1

DESTDIR		=

sbindir		= /usr/sbin
mandir		= /usr/share/man
libdir		= /usr/lib/snapshot

all: snapshot.spec

snapshot.spec: snapshot.spec.in Makefile
	sed -e s/@VERSION@/$(VERSION)/ < snapshot.spec.in > snapshot.spec

install: all
	install		-d $(DESTDIR)$(sbindir)
	install		-d $(DESTDIR)$(libdir)/filesystems.d
	install	-m 755	-t $(DESTDIR)$(libdir)/filesystems.d src/filesystems/*
	install		-d $(DESTDIR)$(libdir)/writers.d
	install	-m 755	-t $(DESTDIR)$(libdir)/writers.d src/writers/*
	install	-m 755	-t $(DESTDIR)$(sbindir) src/snapshot src/start-snapshot src/stop-snapshot
	test -e $(DESTDIR)/etc/qemu/fsfreeze-hook.d || \
		ln -s	$(libdir)/writers.d $(DESTDIR)/etc/qemu/fsfreeze-hook.d

clean:
	rm -f snapshot.spec
