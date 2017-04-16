# Makefile for snapshot

VERSION		= 0.1

DESTDIR		=

sbindir		= /usr/sbin
mandir		= /usr/share/man
libdir		= /usr/lib/snapshot

DISTFILES	= COPYING Makefile README snapshot.spec.in snapshot.spec \
		  doc/start-snapshot.sgml doc/snapshot.sgml \
		  doc/start-snapshot.1 doc/snapshot.1 \
		  src/start-snapshot src/snapshot src/stop-snapshot \
		  src/writers/mysql src/writers/postgresql \
		  src/filesystems/bind src/filesystems/btrfs \
		  src/filesystems/ext-lvm src/filesystems/glusterfs \
		  src/filesystems/zfs
distdir		= snapshot-$(VERSION)
TXZFILE		= snapshot-$(VERSION).tar.xz

all: snapshot.spec doc/snapshot.1 doc/start-snapshot.1

snapshot.spec: snapshot.spec.in Makefile
	sed -e s/@VERSION@/$(VERSION)/ < snapshot.spec.in > snapshot.spec

doc/snapshot.1: doc/snapshot.sgml
	cd doc && docbook2man snapshot.sgml

doc/start-snapshot.1: doc/start-snapshot.sgml
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

dist: all
	rm -rf $(distdir)
	mkdir $(distdir)
	mkdir $(distdir)/doc
	mkdir $(distdir)/src
	mkdir $(distdir)/src/writers $(distdir)/src/filesystems
	$(foreach var,$(DISTFILES),cp $(var) $(distdir)/$(var);)
	-chmod -R a+r $(distdir)
	tar Jcvf ../$(TXZFILE) $(distdir)
	-rm -rf $(distdir)

clean:
	rm -f snapshot.spec doc/manpage.* doc/*.1
