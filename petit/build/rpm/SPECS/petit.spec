Name: petit
Summary: Log analysis tool for syslog, apache and raw log files
Version: 0.8.2
Release: e1
License: GPL
Group: Applications/System
URL: http://www.eyemg.com/opensource
Source0: petit.tar.gz
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
tar xvfz %{SOURCE0}

%install
# Remove ddold BUILD ROOT
rm -rf ${RPM_BUILD_ROOT}

# Main script/s
install -d ${RPM_BUILD_ROOT}/usr/bin
install src/bin/petit ${RPM_BUILD_ROOT}/usr/bin/petit

# Filters
install -d ${RPM_BUILD_ROOT}/var/lib/petit/filters
install src/lib/filters/daemon.stopwords ${RPM_BUILD_ROOT}/var/lib/petit/filters/daemon.stopwords
install src/lib/filters/host.stopwords ${RPM_BUILD_ROOT}/var/lib/petit/filters/host.stopwords
install src/lib/filters/syslog.stopwords ${RPM_BUILD_ROOT}/var/lib/petit/filters/syslog.stopwords
install src/lib/filters/words.stopwords ${RPM_BUILD_ROOT}/var/lib/petit/filters/words.stopwords

# Fingerprints
install -d ${RPM_BUILD_ROOT}/var/lib/petit/fingerprints
install src/lib/fingerprints/fedora11-reboot.fp ${RPM_BUILD_ROOT}/var/lib/petit/fingerprints/fedora11-reboot.fp
install src/lib/fingerprints/rhel4-reboot.fp ${RPM_BUILD_ROOT}/var/lib/petit/fingerprints/rhel4-reboot.fp
install src/lib/fingerprints/rhel5-reboot.fp ${RPM_BUILD_ROOT}/var/lib/petit/fingerprints/rhel5-reboot.fp

# Licensing & Docs
install -d ${RPM_BUILD_ROOT}/usr/share/doc/petit
install src/README ${RPM_BUILD_ROOT}/usr/share/doc/petit/README
install src/AUTHORS ${RPM_BUILD_ROOT}/usr/share/doc/petit/AUTHORS
install src/COPYING ${RPM_BUILD_ROOT}/usr/share/doc/petit/COPYING

%clean
rm -fr $RPM_BUILD_ROOT
rm -rf src
rm -rf %{SOURCE0}

%files
/usr/bin/petit
/var/lib/petit
/usr/share/doc/petit

%defattr(-,root,root,-)

%changelog
* Tue Jul 31 2009 Scott McCarty <smccarty@eyemg.com>
- First working version
