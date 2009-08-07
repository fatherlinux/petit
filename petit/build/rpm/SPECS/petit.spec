Name: petit
Summary: Log analysis tool for syslog, apache and raw log files
Version: 1
Release: e1
License: GPL
Group: Applications/System
URL: http://www.eyemg.com/opensource
Source0: petit.tgz
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
tar xvfz .%{SOURCE0}

%install
# Make link for perl, this is required for some of Andy's code
install bin/petit ${RPM_BUILD_ROOT}/usr/bin/petit

%post

%clean
rm -fr $RPM_BUILD_ROOT


%files
/usr/bin/lt2

%defattr(-,root,root,-)

%changelog
* Tue Jul 31 2009 Scott McCarty <smccarty@eyemg.com>
- First working version
