%{!?python_sitelib: %define python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")}
%{!?pyver: %define pyver %(%{__python} -c "import sys ; print sys.version[:3]")}

Summary:       Grep-like tool for source code
Name:          grin
Version:       1.1.1
Release:       2%{?dist}
License:       BSD
Group:         Applications/Text
URL:           http://pypi.python.org/pypi/grin
Source0:       http://pypi.python.org/packages/source/g/grin/%{name}-%{version}.tar.gz
Requires:      python-setuptools python-argparse
BuildArch:     noarch

Name: petit
Summary: Log analysis tool for syslog, apache and raw log files
Version: 0.8.3
Release: 1
License: GPL
Group: Applications/System
URL: http://opensource.eyemg.com
Source0: petit.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}
#BuildRoot:     %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch: i386
Autoreq: 0
Requires: python-setuptools
BuildRequires: python-setuptools-devel python-nose python-argparse

%description
Log analysis tool which is useful to systems administrators & systems analysts
This tool interact with syslog and apache logs to clarify what is happening in logs.

%prep
%setup -q
%{__chmod} 0644 examples/*
%{__sed} -i -e '1d' grin.py

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
