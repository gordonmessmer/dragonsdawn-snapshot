ROOTDIR=/usr/lib/snapshot
SBINDIR=/usr/sbin

install:
	install -d $(ROOTDIR)
	install -d $(ROOTDIR)/filesystems.d
	install -t $(ROOTDIR)/filesystems.d src/filesystems/*
	install -d $(ROOTDIR)/writers.d
	install -t $(ROOTDIR)/writers.d src/writers/*
	install -t $(SBINDIR) src/snapshot src/start-snapshot src/stop-snapshot src/mysql-lock
	ln -s      $(ROOTDIR)/writers.d /etc/qemu/fsfreeze-hook.d
