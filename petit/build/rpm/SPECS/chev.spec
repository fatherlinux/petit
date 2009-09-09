%{!?python_sitelib: %define python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")}
%{!?pyver: %define pyver %(%{__python} -c "import sys ; print sys.version[:3]")}

Name: petit
Summary: Check online vulnerabilities rss feeds for important pieces of software
Version: 0.8.0
Release: 1
License: GPL
Group: Applications/System
URL: http://opensource.eyemg.com
Source0: chev.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}
#BuildRoot:     %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch: i386
Autoreq: 0
Requires: python
BuildRequires: python-devel

%description
Simple check which can be used from cron or nagios to check
critical pieces of software for vulnerabilities using security focus, nist
and other lists as sources.

%prep
%setup -q
%{__chmod} 0644 examples/*
%{__sed} -i -e '1d' chev.py

%build
%{__python} setup.py build

%install
%{__rm} -rf %{buildroot}
%{__python} setup.py install -O1 --skip-build --root %{buildroot}

%check
nosetests

%clean
%{__rm} -rf %{buildroot}

%files
%defattr(-, root, root, -)
%doc ANNOUNCE.txt examples LICENSE.txt README.txt THANKS.txt
%{_bindir}/%{name}
%{_bindir}/grind
%{python_sitelib}/%{name}.py*
%{python_sitelib}/%{name}-%{version}-py%{pyver}.egg-info/

%changelog
* Thu Aug 20 2009 Scott McCarty <smccarty@eyemg.com> 0.8.3-1
- Updated spec file to be more in line with Fedora guidelines
- Split library out into separate file called crunchtools

* Tue Jul 31 2009 Scott McCarty <smccarty@eyemg.com> - 0.8.2-1
- First working version
