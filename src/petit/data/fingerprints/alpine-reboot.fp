Sep 25 02:33:53 host01 daemon.info init: starting pid 2589, tty '': '/sbin/openrc shutdown'
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2627]: Will stop /usr/sbin/sshd
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2627]: Will stop PID 2550
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2627]: Sending signal 15 to PID 2550
Sep 25 02:33:53 host01 auth.info sshd[2550]: Received signal 15; terminating.
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2711]: Will stop /usr/sbin/cloud-init-hotplugd
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2711]: Will stop PID 2428
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2711]: Sending signal 15 to PID 2428
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2734]: Will stop /usr/sbin/chronyd
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2734]: Will stop PID 2406
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2734]: Sending signal 15 to PID 2406
Sep 25 02:33:53 host01 daemon.info chronyd[2406]: chronyd exiting
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2793]: Will stop /sbin/syslogd
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2793]: Will stop PID 2247
Sep 25 02:33:53 host01 daemon.debug start-stop-daemon[2793]: Sending signal 15 to PID 2247
Sep 25 02:33:53 host01 syslog.info syslogd exiting
Sep 25 02:34:09 host01 syslog.info syslogd started: BusyBox v1.37.0
Sep 25 02:34:09 host01 daemon.info init: starting pid 2252, tty '': '/sbin/openrc default'
Sep 25 02:34:09 host01 daemon.info dhcpcd[2322]: dhcpcd-10.5.2 starting
Sep 25 02:34:09 host01 daemon.info dhcpcd[2325]: DUID 00:01:00:01:32:48:99:bd:52:54:00:00:00:01
Sep 25 02:34:09 host01 daemon.info dhcpcd[2325]: eth0: IAID 00:00:00:01
Sep 25 02:34:10 host01 daemon.info dhcpcd[2325]: eth0: rebinding lease of 192.0.2.1
Sep 25 02:34:10 host01 daemon.info dhcpcd[2325]: eth0: probing address 192.0.2.1/24
Sep 25 02:34:10 host01 daemon.info dhcpcd[2325]: eth0: soliciting an IPv6 router
Sep 25 02:34:10 host01 daemon.info dhcpcd[2325]: eth0: Router Advertisement from 2001:db8::2
Sep 25 02:34:10 host01 daemon.info dhcpcd[2325]: eth0: adding address 2001:db8::3/64
Sep 25 02:34:10 host01 daemon.info dhcpcd[2325]: eth0: adding route to 2001:db8::4/64
Sep 25 02:34:10 host01 daemon.info dhcpcd[2325]: eth0: adding default route via 2001:db8::2
Sep 25 02:34:16 host01 daemon.info dhcpcd[2325]: eth0: leased 192.0.2.1 for 86400 seconds
Sep 25 02:34:16 host01 daemon.info dhcpcd[2325]: eth0: adding route to 192.0.2.5/24
Sep 25 02:34:16 host01 daemon.info dhcpcd[2325]: eth0: adding default route via 192.0.2.6
Sep 25 02:34:16 host01 daemon.info chronyd[2404]: chronyd version 4.8 starting (+CMDMON +REFCLOCK +RTC +PRIVDROP +SCFILTER +SIGND -NTS -SECHASH +IPV6 -DEBUG)
Sep 25 02:34:16 host01 daemon.info chronyd[2404]: Frequency 0.000 +/- 1000000.000 ppm read from /var/lib/chrony/chrony.drift
Sep 25 02:34:16 host01 daemon.info chronyd[2404]: Loaded seccomp filter (level 1)
Sep 25 02:34:17 host01 auth.info sshd[2548]: Server listening on 0.0.0.0 port 22.
Sep 25 02:34:17 host01 auth.info sshd[2548]: Server listening on 2001:db8::7 port 22.
Sep 25 02:34:17 host01 daemon.info init: starting pid 2581, tty '/dev/tty1': '/sbin/getty 38400 tty1'
Sep 25 02:34:17 host01 daemon.info init: starting pid 2582, tty '': '/usr/libexec/alpine-cloud-images/cloud-serial-getty'
Sep 25 02:34:22 host01 daemon.info chronyd[2404]: Selected source 192.0.2.8 (pool.ntp.org)
Sep 25 02:34:22 host01 daemon.warn chronyd[2404]: System clock wrong by 1.514375 seconds
Sep 25 02:34:22 host01 daemon.warn chronyd[2404]: System clock was stepped by 1.514375 seconds
