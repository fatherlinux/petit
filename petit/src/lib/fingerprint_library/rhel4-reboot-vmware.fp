Jul 28 13:28:26 seth shutdown: shutting down for system reboot
Jul 28 13:28:26 seth init: Switching to runlevel: 6
Jul 28 13:28:27 seth login(pam_unix)[2216]: session closed for user root
Jul 28 13:28:27 seth hald[2207]: Timed out waiting for hotplug event 261. Rebasing to 265
Jul 28 13:28:28 seth cups-config-daemon: cups-config-daemon -TERM succeeded
Jul 28 13:28:28 seth haldaemon: haldaemon -TERM succeeded
Jul 28 13:28:29 seth messagebus: messagebus -TERM succeeded
Jul 28 13:28:29 seth atd: atd shutdown succeeded
Jul 28 13:28:29 seth cups: cupsd shutdown succeeded
Jul 28 13:28:29 seth xfs[2148]: terminating 
Jul 28 13:28:29 seth xfs: xfs shutdown succeeded
Jul 28 13:28:30 seth gpm: gpm shutdown succeeded
Jul 28 13:28:31 seth httpd: httpd shutdown succeeded
Jul 28 13:28:31 seth sshd: sshd -TERM succeeded
Jul 28 13:28:31 seth sendmail: sendmail shutdown succeeded
Jul 28 13:28:32 seth sendmail: sm-client shutdown succeeded
Jul 28 13:28:32 seth mysqld: Stopping MySQL:  succeeded
Jul 28 13:28:33 seth snmpd: snmpd shutdown succeeded
Jul 28 13:28:33 seth xinetd[1886]: Exiting...
Jul 28 13:28:33 seth xinetd: xinetd shutdown succeeded
Jul 28 13:28:33 seth acpid: acpid shutdown succeeded
Jul 28 13:28:34 seth crond: crond shutdown succeeded
Jul 28 13:28:34 seth ntpd[1934]: ntpd exiting on signal 15
Jul 28 13:28:34 seth ntpd: ntpd shutdown succeeded
Jul 28 13:28:35 seth nfslock: lockd shutdown failed
Jul 28 13:28:35 seth rpc.statd[1677]: Caught signal 15, un-registering and exiting.
Jul 28 13:28:35 seth nfslock: rpc.statd shutdown succeeded
Jul 28 13:28:35 seth portmap: portmap shutdown succeeded
Jul 28 13:28:35 seth kernel: Kernel logging (proc) stopped.
Jul 28 13:28:35 seth kernel: Kernel log daemon terminating.
Jul 28 13:28:36 seth syslog: klogd shutdown succeeded
Jul 28 13:28:36 seth exiting on signal 15
Jul 28 13:29:46 seth syslogd 1.4.1: restart.
Jul 28 13:29:46 seth syslog: syslogd startup succeeded
Jul 28 13:29:46 seth syslog: klogd startup succeeded
Jul 28 13:29:46 seth kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul 28 13:29:46 seth kernel: Linux version 2.6.9-5.ELsmp (bhcompile@decompose.build.redhat.com) (gcc version 3.4.3 20041212 (Red Hat 3.4.3-9.EL4)) #1 SMP Wed Jan 5 19:30:39 EST 2005
Jul 28 13:29:46 seth kernel: BIOS-provided physical RAM map:
Jul 28 13:29:46 seth kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jul 28 13:29:46 seth kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jul 28 13:29:46 seth kernel:  BIOS-e820: 00000000000ca000 - 00000000000cc000 (reserved)
Jul 28 13:29:46 seth kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Jul 28 13:29:46 seth kernel:  BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
Jul 28 13:29:46 seth kernel:  BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
Jul 28 13:29:46 seth kernel:  BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
Jul 28 13:29:46 seth kernel:  BIOS-e820: 000000000ff00000 - 0000000010000000 (usable)
Jul 28 13:29:46 seth kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Jul 28 13:29:47 seth kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jul 28 13:29:47 seth kernel:  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
Jul 28 13:29:47 seth kernel: 0MB HIGHMEM available.
Jul 28 13:29:47 seth kernel: 256MB LOWMEM available.
Jul 28 13:29:47 seth kernel: found SMP MP-table at 000f6ce0
Jul 28 13:29:47 seth irqbalance: irqbalance startup succeeded
Jul 28 13:29:47 seth kernel: DMI present.
Jul 28 13:29:47 seth kernel: Using APIC driver default
Jul 28 13:29:47 seth kernel: ACPI: PM-Timer IO Port: 0x1008
Jul 28 13:29:47 seth kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jul 28 13:29:47 seth kernel: Processor #0 15:4 APIC version 17
Jul 28 13:29:47 seth kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Jul 28 13:29:47 seth kernel: ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
Jul 28 13:29:47 seth kernel: IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
Jul 28 13:29:47 seth kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Jul 28 13:29:47 seth kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jul 28 13:29:47 seth kernel: Using ACPI (MADT) for SMP configuration information
Jul 28 13:29:47 seth kernel: Built 1 zonelists
Jul 28 13:29:47 seth kernel: Kernel command line: ro root=LABEL=/ quiet clock=pmtmr
Jul 28 13:29:47 seth kernel: Initializing CPU#0
Jul 28 13:29:47 seth kernel: CPU 0 irqstacks, hard=c03d8000 soft=c03b8000
Jul 28 13:29:47 seth kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
Jul 28 13:29:47 seth kernel: Detected 3399.339 MHz processor.
Jul 28 13:29:47 seth kernel: Using pmtmr for high-res timesource
Jul 28 13:29:47 seth kernel: Console: colour VGA+ 80x25
Jul 28 13:29:47 seth kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul 28 13:29:47 seth kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Jul 28 13:29:47 seth kernel: Memory: 254000k/262144k available (1819k kernel code, 7504k reserved, 740k data, 172k init, 0k highmem)
Jul 28 13:29:47 seth kernel: Security Scaffold v1.0.0 initialized
Jul 28 13:29:47 seth kernel: SELinux:  Initializing.
Jul 28 13:29:47 seth kernel: SELinux:  Starting in permissive mode
Jul 28 13:29:47 seth kernel: There is already a security framework initialized, register_security failed.
Jul 28 13:29:47 seth kernel: selinux_register_security:  Registering secondary module capability
Jul 28 13:29:47 seth kernel: Capability LSM initialized as secondary
Jul 28 13:29:47 seth kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jul 28 13:29:47 seth kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jul 28 13:29:47 seth kernel: CPU: L2 cache: 1024K
Jul 28 13:29:47 seth kernel: Intel machine check architecture supported.
Jul 28 13:29:47 seth kernel: Intel machine check reporting enabled on CPU#0.
Jul 28 13:29:47 seth kernel: Enabling fast FPU save and restore... done.
Jul 28 13:29:47 seth kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 28 13:29:47 seth kernel: Checking 'hlt' instruction... OK.
Jul 28 13:29:47 seth kernel: CPU0: Intel(R) Xeon(TM) CPU 3.40GHz stepping 08
Jul 28 13:29:47 seth kernel: per-CPU timeslice cutoff: 2925.41 usecs.
Jul 28 13:29:47 seth kernel: task migration cache decay timeout: 3 msecs.
Jul 28 13:29:47 seth kernel: Total of 1 processors activated (6701.05 BogoMIPS).
Jul 28 13:29:47 seth kernel: ENABLING IO-APIC IRQs
Jul 28 13:29:47 seth kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jul 28 13:29:47 seth kernel: Brought up 1 CPUs
Jul 28 13:29:47 seth kernel: zapping low mappings.
Jul 28 13:29:47 seth kernel: checking if image is initramfs... it is
Jul 28 13:29:47 seth kernel: Freeing initrd memory: 483k freed
Jul 28 13:29:47 seth portmap: portmap startup succeeded
Jul 28 13:29:47 seth kernel: NET: Registered protocol family 16
Jul 28 13:29:47 seth kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd9a0, last bus=1
Jul 28 13:29:47 seth kernel: PCI: Using configuration type 1
Jul 28 13:29:47 seth kernel: mtrr: v2.0 (20020519)
Jul 28 13:29:47 seth kernel: ACPI: Subsystem revision 20040816
Jul 28 13:29:47 seth kernel: ACPI: Interpreter enabled
Jul 28 13:29:47 seth kernel: ACPI: Using IOAPIC for interrupt routing
Jul 28 13:29:47 seth kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul 28 13:29:47 seth kernel: PCI: Probing PCI hardware (bus 00)
Jul 28 13:29:47 seth kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 14 15) *0, disabled.
Jul 28 13:29:47 seth kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 14 15)
Jul 28 13:29:47 seth kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 14 15)
Jul 28 13:29:47 seth kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 14 15) *0, disabled.
Jul 28 13:29:47 seth kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jul 28 13:29:47 seth kernel: usbcore: registered new driver usbfs
Jul 28 13:29:47 seth kernel: usbcore: registered new driver hub
Jul 28 13:29:47 seth kernel: PCI: Using ACPI for IRQ routing
Jul 28 13:29:47 seth kernel: ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 17 (level, low) -> IRQ 169
Jul 28 13:29:47 seth kernel: ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 18 (level, low) -> IRQ 177
Jul 28 13:29:47 seth kernel: PCI: Cannot allocate resource region 4 of device 0000:00:07.1
Jul 28 13:29:47 seth kernel: Simple Boot Flag at 0x36 set to 0x80
Jul 28 13:29:47 seth kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Jul 28 13:29:47 seth kernel: apm: overridden by ACPI.
Jul 28 13:29:47 seth kernel: audit: initializing netlink socket (disabled)
Jul 28 13:29:47 seth kernel: audit(1248787745.443:0): initialized
Jul 28 13:29:47 seth kernel: Total HugeTLB memory allocated, 0
Jul 28 13:29:47 seth kernel: VFS: Disk quotas dquot_6.5.1
Jul 28 13:29:47 seth kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Jul 28 13:29:47 seth kernel: SELinux:  Registering netfilter hooks
Jul 28 13:29:47 seth kernel: Initializing Cryptographic API
Jul 28 13:29:47 seth kernel: ksign: Installing public key data
Jul 28 13:29:47 seth kernel: Loading keyring
Jul 28 13:29:47 seth kernel: - Added public key E07BC3E85BE30CFD
Jul 28 13:29:47 seth kernel: - User ID: Red Hat, Inc. (Kernel Module GPG key)
Jul 28 13:29:47 seth kernel: Limiting direct PCI/PCI transfers.
Jul 28 13:29:47 seth kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jul 28 13:29:47 seth kernel: vesafb: probe of vesafb0 failed with error -6
Jul 28 13:29:47 seth kernel: ACPI: Processor [CPU0] (supports C1, 8 throttling states)
Jul 28 13:29:47 seth kernel: Real Time Clock Driver v1.12
Jul 28 13:29:47 seth kernel: Linux agpgart interface v0.100 (c) Dave Jones
Jul 28 13:29:47 seth kernel: agpgart: Detected an Intel 440BX Chipset.
Jul 28 13:29:47 seth kernel: agpgart: Maximum main memory to use for agp memory: 204M
Jul 28 13:29:47 seth kernel: agpgart: AGP aperture is 64M @ 0xec000000
Jul 28 13:29:47 seth kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 28 13:29:47 seth kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 28 13:29:47 seth kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
Jul 28 13:29:47 seth kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul 28 13:29:47 seth kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jul 28 13:29:47 seth kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Jul 28 13:29:47 seth kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul 28 13:29:47 seth kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul 28 13:29:47 seth kernel: PIIX4: IDE controller at PCI slot 0000:00:07.1
Jul 28 13:29:47 seth kernel: PIIX4: chipset revision 1
Jul 28 13:29:47 seth kernel: PIIX4: not 100% native mode: will probe irqs later
Jul 28 13:29:47 seth kernel:     ide1: BM-DMA at 0x1078-0x107f, BIOS settings: hdc:DMA, hdd:pio
Jul 28 13:29:47 seth kernel: hdc: VMware Virtual IDE CDROM Drive, ATAPI CD/DVD-ROM drive
Jul 28 13:29:47 seth kernel: Using cfq io scheduler
Jul 28 13:29:47 seth kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 28 13:29:47 seth rpc.statd[1686]: Version 1.0.6 Starting
Jul 28 13:29:47 seth kernel: hdc: ATAPI 1X CD-ROM drive, 32kB Cache, UDMA(33)
Jul 28 13:29:47 seth kernel: Uniform CD-ROM driver Revision: 3.20
Jul 28 13:29:47 seth kernel: ide-floppy driver 0.99.newide
Jul 28 13:29:47 seth kernel: usbcore: registered new driver hiddev
Jul 28 13:29:47 seth kernel: usbcore: registered new driver usbhid
Jul 28 13:29:47 seth kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Jul 28 13:29:47 seth kernel: mice: PS/2 mouse device common for all mice
Jul 28 13:29:47 seth kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul 28 13:29:47 seth kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Jul 28 13:29:47 seth kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jul 28 13:29:47 seth kernel: NET: Registered protocol family 2
Jul 28 13:29:47 seth kernel: IP: routing cache hash table of 1024 buckets, 16Kbytes
Jul 28 13:29:47 seth kernel: TCP: Hash tables configured (established 8192 bind 10922)
Jul 28 13:29:47 seth kernel: Initializing IPsec netlink socket
Jul 28 13:29:47 seth kernel: NET: Registered protocol family 1
Jul 28 13:29:47 seth nfslock: rpc.statd startup succeeded
Jul 28 13:29:47 seth kernel: NET: Registered protocol family 17
Jul 28 13:29:47 seth kernel: ACPI: (supports S0 S1 S5)
Jul 28 13:29:47 seth kernel: ACPI wakeup devices: 
Jul 28 13:29:47 seth kernel:  USB 
Jul 28 13:29:47 seth kernel: Freeing unused kernel memory: 172k freed
Jul 28 13:29:47 seth kernel: SCSI subsystem initialized
Jul 28 13:29:47 seth kernel: Fusion MPT base driver 3.01.16
Jul 28 13:29:47 seth kernel: Copyright (c) 1999-2004 LSI Logic Corporation
Jul 28 13:29:47 seth kernel: ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 17 (level, low) -> IRQ 169
Jul 28 13:29:47 seth kernel: mptbase: Initiating ioc0 bringup
Jul 28 13:29:47 seth kernel: ioc0: 53C1030: Capabilities={Initiator}
Jul 28 13:29:47 seth kernel: Fusion MPT SCSI Host driver 3.01.16
Jul 28 13:29:47 seth kernel: scsi0 : ioc0: LSI53C1030, FwRev=00000000h, Ports=1, MaxQ=128, IRQ=169
Jul 28 13:29:47 seth kernel:   Vendor: VMware,   Model: VMware Virtual S  Rev: 1.0 
Jul 28 13:29:47 seth kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jul 28 13:29:47 seth kernel: SCSI device sda: 41943040 512-byte hdwr sectors (21475 MB)
Jul 28 13:29:47 seth kernel: sda: cache data unavailable
Jul 28 13:29:47 seth kernel: sda: assuming drive cache: write through
Jul 28 13:29:47 seth kernel:  sda: sda1 sda2
Jul 28 13:29:47 seth kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Jul 28 13:29:47 seth kernel: kjournald starting.  Commit interval 5 seconds
Jul 28 13:29:47 seth kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 28 13:29:47 seth kernel: SELinux:  Disabled at runtime.
Jul 28 13:29:47 seth kernel: SELinux:  Unregistering netfilter hooks
Jul 28 13:29:47 seth kernel: inserting floppy driver for 2.6.9-5.ELsmp
Jul 28 13:29:47 seth kernel: Floppy drive(s): fd0 is 1.44M
Jul 28 13:29:47 seth kernel: FDC 0 is a post-1991 82077
Jul 28 13:29:47 seth kernel: pcnet32.c:v1.30i 06.28.2004 tsbogend@alpha.franken.de
Jul 28 13:29:47 seth kernel: ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 18 (level, low) -> IRQ 177
Jul 28 13:29:47 seth kernel: pcnet32: PCnet/PCI II 79C970A at 0x1400, 00 0c 29 cc 45 9a assigned IRQ 177.
Jul 28 13:29:47 seth kernel: eth0: registered as PCnet/PCI II 79C970A
Jul 28 13:29:47 seth kernel: pcnet32: 1 cards_found.
Jul 28 13:29:47 seth kernel: md: Autodetecting RAID arrays.
Jul 28 13:29:47 seth kernel: md: autorun ...
Jul 28 13:29:47 seth kernel: md: ... autorun DONE.
Jul 28 13:29:47 seth kernel: ACPI: AC Adapter [ACAD] (on-line)
Jul 28 13:29:47 seth kernel: ACPI: Power Button (FF) [PWRF]
Jul 28 13:29:47 seth kernel: EXT3 FS on sda1, internal journal
Jul 28 13:29:47 seth kernel: device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Jul 28 13:29:47 seth kernel: Adding 2096472k swap on /dev/sda2.  Priority:-1 extents:1
Jul 28 13:29:47 seth kernel: parport0: PC-style at 0x378 [PCSPP,TRISTATE]
Jul 28 13:29:48 seth kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul 28 13:29:48 seth kernel: ip_conntrack version 2.1 (2048 buckets, 16384 max) - 340 bytes per conntrack
Jul 28 13:29:49 seth rpcidmapd: rpc.idmapd startup succeeded
Jul 28 09:29:13 seth rc.sysinit: -e 
Jul 28 09:29:15 seth udevsend[607]: starting udevd daemon 
Jul 28 09:29:15 seth scsi.agent[619]: disk at /devices/pci0000:00/0000:00:10.0/host0/target0:0:0/0:0:0:0 
Jul 28 09:29:17 seth udevsend[731]: starting udevd daemon 
Jul 28 09:29:21 seth start_udev: Starting udev:  succeeded 
Jul 28 09:29:25 seth rc.sysinit: -e 
Jul 28 09:29:26 seth sysctl: net.ipv4.ip_forward = 0 
Jul 28 09:29:26 seth sysctl: net.ipv4.conf.default.rp_filter = 1 
Jul 28 09:29:26 seth sysctl: net.ipv4.conf.default.accept_source_route = 0 
Jul 28 09:29:26 seth sysctl: kernel.sysrq = 0 
Jul 28 09:29:26 seth sysctl: kernel.core_uses_pid = 1 
Jul 28 09:29:26 seth rc.sysinit: Configuring kernel parameters:  succeeded 
Jul 28 13:29:27 seth date: Tue Jul 28 13:29:27 EDT 2009 
Jul 28 13:29:27 seth rc.sysinit: Setting clock  (localtime): Tue Jul 28 13:29:27 EDT 2009 succeeded 
Jul 28 13:29:27 seth rc.sysinit: Loading default keymap succeeded 
Jul 28 13:29:27 seth rc.sysinit: Setting hostname seth.eyemg.com:  succeeded 
Jul 28 13:29:28 seth fsck: /: clean, 148769/2359296 files, 960781/4717077 blocks 
Jul 28 13:29:28 seth fsck:  (check in 3 mounts) 
Jul 28 13:29:28 seth rc.sysinit: Checking root filesystem succeeded 
Jul 28 13:29:28 seth rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
Jul 28 13:29:29 seth lvm.static:    
Jul 28 13:29:29 seth lvm.static: No volume groups found 
Jul 28 13:29:29 seth rc.sysinit: Setting up Logical Volume Management: succeeded 
Jul 28 13:29:29 seth rc.sysinit: Checking filesystems succeeded 
Jul 28 13:29:29 seth rc.sysinit: Mounting local filesystems:  succeeded 
Jul 28 13:29:29 seth rc.sysinit: Enabling local filesystem quotas:  succeeded 
Jul 28 13:29:31 seth rc.sysinit: Enabling swap space:  succeeded 
Jul 28 13:29:31 seth init: Entering runlevel: 3 
Jul 28 13:29:42 seth kudzu:  succeeded 
Jul 28 13:29:43 seth iptables:  succeeded 
Jul 28 13:29:43 seth rc: Starting pcmcia:  succeeded 
Jul 28 13:29:43 seth sysctl: net.ipv4.ip_forward = 0 
Jul 28 13:29:43 seth sysctl: net.ipv4.conf.default.rp_filter = 1 
Jul 28 13:29:43 seth sysctl: net.ipv4.conf.default.accept_source_route = 0 
Jul 28 13:29:43 seth sysctl: kernel.sysrq = 0 
Jul 28 13:29:43 seth sysctl: kernel.core_uses_pid = 1 
Jul 28 13:29:43 seth network: Setting network parameters:  succeeded 
Jul 28 13:29:44 seth network: Bringing up loopback interface:  succeeded 
Jul 28 13:29:46 seth network: Bringing up interface eth0:  succeeded 
Jul 28 13:29:49 seth netfs: Mounting other filesystems:  succeeded
Jul 28 13:29:49 seth kernel: i2c /dev entries driver
Jul 28 13:29:49 seth rc: Starting lm_sensors:  succeeded
Jul 28 13:29:50 seth acpid: acpid startup succeeded
Jul 28 13:29:51 seth snmpd: snmpd startup succeeded
Jul 28 13:29:52 seth snmpd[1782]: dlopen failed: /usr/lib/libcmaX.so: cannot open shared object file: No such file or directory 
Jul 28 13:29:53 seth kernel: parport0: PC-style at 0x378 [PCSPP,TRISTATE]
Jul 28 13:29:53 seth kernel: lp0: using parport0 (polling).
Jul 28 13:29:53 seth kernel: lp0: console ready
Jul 28 13:29:54 seth cups: cupsd startup succeeded
Jul 28 13:29:55 seth kernel: NET: Registered protocol family 10
Jul 28 13:29:55 seth kernel: Disabled Privacy Extensions on device c0332e60(lo)
Jul 28 13:29:55 seth kernel: IPv6 over IPv4 tunneling driver
Jul 28 13:29:55 seth sshd:  succeeded
Jul 28 13:29:56 seth xinetd: xinetd startup succeeded
Jul 28 13:29:56 seth xinetd[1895]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
Jul 28 13:29:56 seth xinetd[1895]: Started working: 0 available services
Jul 28 13:30:02 seth ntpdate[1907]: step time server 208.79.157.12 offset -2.576906 sec
Jul 28 13:30:02 seth ntpd:  succeeded
Jul 28 13:30:02 seth ntpd[1943]: ntpd 4.2.0a@1.1190-r Mon Oct 11 09:10:20 EDT 2004 (1)
Jul 28 13:30:02 seth ntpd: ntpd startup succeeded
Jul 28 13:30:02 seth ntpd[1943]: precision = 5.000 usec
Jul 28 13:30:02 seth ntpd[1943]: Listening on interface wildcard, 0.0.0.0#123
Jul 28 13:30:02 seth ntpd[1943]: Listening on interface wildcard, ::#123
Jul 28 13:30:02 seth ntpd[1943]: Listening on interface lo, 127.0.0.1#123
Jul 28 13:30:02 seth ntpd[1943]: Listening on interface eth0, 10.0.8.65#123
Jul 28 13:30:02 seth ntpd[1943]: kernel time sync status 0040
Jul 28 13:30:02 seth ntpd[1943]: frequency initialized 137.549 PPM from /var/lib/ntp/drift
Jul 28 13:30:02 seth ntpdate: 28 Jul 13:30:02 
Jul 28 13:30:02 seth ntpdate: ntpdate[1953]: the NTP socket is in use, exiting
Jul 28 13:30:02 seth rc: Starting ntpdate:  failed
Jul 28 13:30:07 seth mysqld: Starting MySQL:  succeeded
Jul 28 13:30:08 seth sendmail: sendmail startup succeeded
Jul 28 13:30:08 seth sendmail: sm-client startup succeeded
Jul 28 13:30:08 seth gpm[2061]: *** info [startup.c(95)]: 
Jul 28 13:30:08 seth gpm[2061]: Started gpm successfully. Entered daemon mode.
Jul 28 13:30:08 seth gpm[2061]: *** info [mice.c(1766)]: 
Jul 28 13:30:08 seth gpm[2061]: imps2: Auto-detected intellimouse PS/2
Jul 28 13:30:09 seth gpm: gpm startup succeeded
Jul 28 13:30:13 seth httpd: httpd startup succeeded
Jul 28 13:30:13 seth crond: crond startup succeeded
Jul 28 13:30:15 seth xfs: xfs startup succeeded
Jul 28 13:30:15 seth anacron: anacron startup succeeded
Jul 28 13:30:15 seth xfs[2156]: ignoring font path element /usr/X11R6/lib/X11/fonts/Speedo (unreadable) 
Jul 28 13:30:15 seth atd: atd startup succeeded
Jul 28 13:30:16 seth messagebus: messagebus startup succeeded
Jul 28 13:30:16 seth cups-config-daemon: cups-config-daemon startup succeeded
Jul 28 13:30:16 seth haldaemon: haldaemon startup succeeded
Jul 28 13:30:18 seth fstab-sync[2539]: removed all generated mount points
Jul 28 13:30:19 seth fstab-sync[2613]: added mount point /media/cdrom for /dev/hdc
Jul 28 13:30:20 seth fstab-sync[2635]: added mount point /media/floppy for /dev/fd0