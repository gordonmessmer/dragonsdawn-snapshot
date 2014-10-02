ROOTDIR=/usr/lib/snapshot
SBINDIR=/usr/sbin

install:
	install -d $(ROOTDIR)
	install -d $(ROOTDIR)/filesystems
	install -t $(ROOTDIR)/filesystems src/filesystems/*
	install -d $(ROOTDIR)/writers
	install -t $(ROOTDIR)/writers src/writers/*
	install -t $(SBINDIR) src/snapshot src/start-snapshot src/stop-snapshot src/mysql-lock
