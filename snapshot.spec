Name:           snapshot
Version:        0.1
Release:        1%{?dist}
Summary:        Snapshot infrastructure for backups

License:        GPL3
URL:            https://bitbucket.org/gordonmessmer/dragonsdawn-snapshot
Source0:        ${name}-%{version}.tar.xz

%description
QEMU provides a guest agent that can be used to freeze application
data on disk, to ensure consistent backups.  The agent freezes
application data, then a snapshot is made of the virtual machine's
backing store, and then the agent thaws application data.  This
process ensures that any performance impact of freezing data is as
brief as possible.

This project complements the QEMU guest agent by providing similar and
compatible infrastructure for hosts that are backed up by a backup
agent within the OS.


%prep
%autosetup


%build


%install
rm -rf $RPM_BUILD_ROOT
%make_install


%files
%license COPYING
%doc README
%defattr(-,root,root)
%dir /usr/lib/snapshot
%dir /usr/lib/snapshot/filesystems.d
%dir /usr/lib/snapshot/writers.d
/usr/lib/snapshot/filesystems.d/*
/usr/lib/snapshot/writers.d/*
/usr/sbin/snapshot
/usr/sbin/start-snapshot
/usr/sbin/stop-snapshot
/etc/qemu/fsfreeze-hook.d


%changelog
* Thu Apr 13 2017 Gordon Messmer <gordon@dragonsdawn.net>
- Initial spec
