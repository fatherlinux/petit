Name: petit
Summary: Log analysis tool for syslog, apache and raw log files
Version: 0.8.5
Release: 4
License: GPLv3
Group: Applications/System
URL: http://www.eyemg.com/opensource
Source0: petit.tar
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}       
BuildArch: i386                                            
Autoreq: 0                                                 
Requires: python

%description
Log analysis tool which is useful to systems administrators & systems analysts
This tool interact with syslog and apache logs to clarify what is happening in logs.

%prep
echo Building %{name}-%{version}-%{release}

#%setup -q -n %{name}-%{version}

%build
tar xvf %{SOURCE0}

%install
# Remove ddold BUILD ROOT
rm -rf ${RPM_BUILD_ROOT}

# Main scripts & libraries
install -d ${RPM_BUILD_ROOT}/usr/bin
install -d ${RPM_BUILD_ROOT}/usr/share/petit
install src/bin/petit ${RPM_BUILD_ROOT}/usr/bin/petit
install src/lib/crunchtools.py ${RPM_BUILD_ROOT}/usr/share/petit/crunchtools.py

# Filters
install -d ${RPM_BUILD_ROOT}/var/lib/petit/filters
install src/lib/filters/daemon.stopwords ${RPM_BUILD_ROOT}/var/lib/petit/filters/daemon.stopwords
install src/lib/filters/host.stopwords ${RPM_BUILD_ROOT}/var/lib/petit/filters/host.stopwords
install src/lib/filters/hash.stopwords ${RPM_BUILD_ROOT}/var/lib/petit/filters/hash.stopwords
install src/lib/filters/words.stopwords ${RPM_BUILD_ROOT}/var/lib/petit/filters/words.stopwords

# Fingerprints
install -d ${RPM_BUILD_ROOT}/var/lib/petit/fingerprints
install src/lib/fingerprints/fedora11-reboot.fp ${RPM_BUILD_ROOT}/var/lib/petit/fingerprints/fedora11-reboot.fp
install src/lib/fingerprints/rhel4-reboot.fp ${RPM_BUILD_ROOT}/var/lib/petit/fingerprints/rhel4-reboot.fp
install src/lib/fingerprints/rhel5-reboot.fp ${RPM_BUILD_ROOT}/var/lib/petit/fingerprints/rhel5-reboot.fp

# Fingerprint Library
install -d ${RPM_BUILD_ROOT}/var/lib/petit/fingerprint_library
install src/lib/fingerprint_library/rhel4-reboot-dl380.fp ${RPM_BUILD_ROOT}/var/lib/petit/fingerprint_library/rhel4-reboot-dl380.fp
install src/lib/fingerprint_library/rhel4-reboot-vmware.fp ${RPM_BUILD_ROOT}/var/lib/petit/fingerprint_library/rhel4-reboot-vmware.fp
install src/lib/fingerprint_library/rhel5-reboot-dl380.fp ${RPM_BUILD_ROOT}/var/lib/petit/fingerprint_library/rhel5-reboot-dl380.fp
install src/lib/fingerprint_library/rhel5-reboot-vmware.fp ${RPM_BUILD_ROOT}/var/lib/petit/fingerprint_library/rhel5-reboot-vmware.fp

# Licensing & Docs
install -d ${RPM_BUILD_ROOT}/usr/share/doc/petit
install README ${RPM_BUILD_ROOT}/usr/share/doc/petit/README
install AUTHORS ${RPM_BUILD_ROOT}/usr/share/doc/petit/AUTHORS
install COPYING ${RPM_BUILD_ROOT}/usr/share/doc/petit/COPYING

%clean
rm -fr $RPM_BUILD_ROOT
rm -rf src
rm -rf %{SOURCE0}

%files
/usr/bin/petit
/usr/share/petit
/var/lib/petit
/usr/share/doc/petit

%defattr(-,root,root,-)

%changelog
* Tue Jul 31 2009 Scott McCarty <smccarty@eyemg.com>
- First working version
