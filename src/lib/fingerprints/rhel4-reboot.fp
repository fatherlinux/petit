Jul 28 20:02:12 tony shutdown: shutting down for system halt
Jul 28 20:02:12 tony init: Switching to runlevel: 0
Jul 28 20:02:12 tony login(pam_unix)[7025]: session closed for user root
Jul 28 20:02:13 tony cmanic: Shutting down NIC Agents (cmanic): All agents
Jul 28 20:02:13 tony cmanic:    Shutting down NIC Agent Daemon (cmanicd):
Jul 28 20:02:13 tony cmanicd: cmanicd shutdown succeeded
Jul 28 20:02:14 tony cmanic: [60G
Jul 28 20:02:14 tony cmanic: 
Jul 28 20:02:14 tony rc: Stopping cmanic:  succeeded
Jul 28 20:02:15 tony hpasm: Shutting down NIC Agents (cmanic): All agents
Jul 28 20:02:15 tony hpasm:    Already stopped NIC Agent Daemon (cmanicd).
Jul 28 20:02:15 tony hpasm: 
Jul 28 20:02:15 tony hpasm: Shutting down Storage Agents (cmastor): cmaeventd cmaidad cmafcad cmaided cmascsid cmasasd
Jul 28 20:02:15 tony hpasm:    Shutting down Storage Event Logger (cmaeventd):
Jul 28 20:02:16 tony hpasm: [60G
Jul 28 20:02:16 tony hpasm:   
Jul 28 20:02:16 tony hpasm:    Shutting down IDA agent (cmaidad):
Jul 28 20:02:17 tony hpasm: [60G
Jul 28 20:02:17 tony hpasm:   
Jul 28 20:02:17 tony hpasm:    Shutting down FCA agent (cmafcad):
Jul 28 20:02:18 tony hpasm: [60G
Jul 28 20:02:18 tony hpasm:   
Jul 28 20:02:18 tony hpasm:    Shutting down IDE agent (cmaided):
Jul 28 20:02:19 tony hpasm: [60G
Jul 28 20:02:19 tony hpasm:   
Jul 28 20:02:19 tony hpasm:    Shutting down SCSI agent (cmascsid):
Jul 28 20:02:19 tony hpasm: [60G
Jul 28 20:02:19 tony hpasm:   
Jul 28 20:02:19 tony hpasm:    Shutting down SAS agent (cmasasd):
Jul 28 20:02:19 tony hpasm: [60G
Jul 28 20:02:19 tony hpasm:   
Jul 28 20:02:19 tony hpasm: 
Jul 28 20:02:19 tony hpasm: Stopping HP Lights-Out Drivers and Agents (hprsm): cmarackd cmasm2d cpqriisd cpqci 
Jul 28 20:02:19 tony hpasm:    Shutting down Rack agent (cmarackd):
Jul 28 20:02:19 tony hpasm: [  
Jul 28 20:02:19 tony hpasm:   
Jul 28 20:02:19 tony hpasm:    Shutting down RIB agent (cmasm2d):
Jul 28 20:02:21 tony hpasm: [  
Jul 28 20:02:21 tony hpasm:   
Jul 28 20:02:21 tony hpasm:    Already stopped cpqriisd.
Jul 28 20:02:21 tony hpasm:    Stopping cpqci:
Jul 28 20:02:28 tony hprsm: cpqci shutdown succeeded
Jul 28 20:02:28 tony hpasm: [60G
Jul 28 20:02:28 tony hpasm:   
Jul 28 20:02:28 tony hpasm:   
Jul 28 20:02:28 tony hpasm: Shutting down Server Agents (cmasvr): cmastdeqd cmahealthd cmaperfd
Jul 28 20:02:28 tony hpasm:    Shutting down Standard Equipment agent (cmastdeqd):
Jul 28 20:02:29 tony sshd(pam_unix)[21617]: session opened for user root by (uid=0)
Jul 28 20:02:29 tony hpasm: [60G
Jul 28 20:02:29 tony hpasm:   
Jul 28 20:02:29 tony hpasm:    Shutting down Health agent (cmahealthd):
Jul 28 20:02:29 tony sshd(pam_unix)[21617]: session closed for user root
Jul 28 20:02:32 tony hpasm: [60G
Jul 28 20:02:32 tony hpasm:   
Jul 28 20:02:32 tony hpasm:    Shutting down Performance agent (cmaperfd):
Jul 28 20:02:33 tony hpasm: [60G
Jul 28 20:02:33 tony hpasm:   
Jul 28 20:02:33 tony hpasm: 
Jul 28 20:02:33 tony hpasm: Shutting down Foundation Agents (cmafdtn): cmathreshd cmahostd cmapeerd
Jul 28 20:02:33 tony hpasm:    Shutting down Threshold agent (cmathreshd):
Jul 28 20:02:33 tony hpasm: [60G
Jul 28 20:02:33 tony hpasm:   
Jul 28 20:02:33 tony hpasm:    Shutting down Host agent (cmahostd):
Jul 28 20:02:34 tony hpasm: [60G
Jul 28 20:02:34 tony hpasm:   
Jul 28 20:02:34 tony hpasm:    Shutting down SNMP Peer (cmapeerd):
Jul 28 20:02:34 tony hpasm: [60G
Jul 28 20:02:34 tony hpasm:   
Jul 28 20:02:34 tony hpasm: 
Jul 28 20:02:34 tony hpasm:    Shutting down Proliant System Health Monitor (hpasmd):
Jul 28 20:02:34 tony hpasmd[5590]: ProLiant System Health Monitor unloading 
Jul 28 20:02:35 tony hpasm: [60G
Jul 28 20:02:35 tony hpasm:   
Jul 28 20:02:35 tony rc: Stopping hpasm:  succeeded
Jul 28 20:02:36 tony cups-config-daemon: cups-config-daemon -TERM succeeded
Jul 28 20:02:36 tony haldaemon: haldaemon -TERM succeeded
Jul 28 20:02:36 tony messagebus: messagebus -TERM succeeded
Jul 28 20:02:36 tony atd: atd shutdown succeeded
Jul 28 20:02:36 tony cups: cupsd shutdown succeeded
Jul 28 20:02:36 tony xfs[5227]: terminating 
Jul 28 20:02:37 tony xfs: xfs shutdown succeeded
Jul 28 20:02:37 tony gpm: gpm shutdown succeeded
Jul 28 20:02:38 tony httpd: httpd shutdown succeeded
Jul 28 20:02:38 tony sshd: sshd shutdown succeeded
Jul 28 20:02:39 tony sendmail: sm-client shutdown succeeded
Jul 28 20:02:39 tony sendmail: sendmail shutdown succeeded
Jul 28 20:02:41 tony mysqld: Stopping MySQL:  succeeded
Jul 28 20:02:41 tony snmpd: snmpd shutdown succeeded
Jul 28 20:02:41 tony vsftpd: vsftpd shutdown succeeded
Jul 28 20:02:41 tony xinetd[4923]: Exiting...
Jul 28 20:02:41 tony xinetd: xinetd shutdown succeeded
Jul 28 20:02:41 tony acpid: acpid shutdown succeeded
Jul 28 20:02:41 tony crond: crond shutdown succeeded
Jul 28 20:02:42 tony ntpd[4941]: ntpd exiting on signal 15
Jul 28 20:02:42 tony ntpd: ntpd shutdown succeeded
Jul 28 20:02:42 tony rpc.statd[4693]: Caught signal 15, un-registering and exiting.
Jul 28 20:02:42 tony portmap[22459]: connect from 127.0.0.1 to unset(status): request from unprivileged port
Jul 28 20:02:42 tony nfslock: rpc.statd shutdown succeeded
Jul 28 20:02:42 tony irqbalance: irqbalance shutdown succeeded
Jul 28 20:02:42 tony portmap: portmap shutdown succeeded
Jul 28 20:02:42 tony kernel: Kernel logging (proc) stopped.
Jul 28 20:02:42 tony kernel: Kernel log daemon terminating.
Jul 28 20:02:43 tony syslog: klogd shutdown succeeded
Jul 28 20:02:43 tony exiting on signal 15
Jul 28 20:07:12 tony syslogd 1.4.1: restart.
Jul 28 20:07:12 tony syslog: syslogd startup succeeded
Jul 28 20:07:12 tony kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul 28 20:07:12 tony kernel: Linux version 2.6.9-67.ELsmp (brewbuilder@ls20-bc1-14.build.redhat.com) (gcc version 3.4.6 20060404 (Red Hat 3.4.6-8)) #1 SMP Wed Nov 7 13:58:04 EST 2007
Jul 28 20:07:12 tony kernel: BIOS-provided physical RAM map:
Jul 28 20:07:12 tony kernel:  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
Jul 28 20:07:12 tony kernel:  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
Jul 28 20:07:12 tony kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul 28 20:07:12 tony kernel:  BIOS-e820: 0000000000100000 - 00000000dfff3000 (usable)
Jul 28 20:07:12 tony kernel:  BIOS-e820: 00000000dfff3000 - 00000000dfffb000 (ACPI data)
Jul 28 20:07:12 tony kernel:  BIOS-e820: 00000000dfffb000 - 00000000e0000000 (reserved)
Jul 28 20:07:12 tony kernel:  BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
Jul 28 20:07:12 tony kernel:  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
Jul 28 20:07:12 tony kernel:  BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
Jul 28 20:07:12 tony kernel:  BIOS-e820: 0000000100000000 - 000000029bfff000 (usable)
Jul 28 20:07:12 tony kernel: 9791MB HIGHMEM available.
Jul 28 20:07:12 tony syslog: klogd startup succeeded
Jul 28 20:07:12 tony kernel: 896MB LOWMEM available.
Jul 28 20:07:12 tony kernel: found SMP MP-table at 000f4f80
Jul 28 20:07:12 tony kernel: Using x86 segment limits to approximate NX protection
Jul 28 20:07:12 tony kernel: DMI 2.3 present.
Jul 28 20:07:12 tony kernel: Using APIC driver default
Jul 28 20:07:12 tony kernel: ACPI: PM-Timer IO Port: 0x908
Jul 28 20:07:12 tony kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jul 28 20:07:12 tony kernel: Processor #0 15:4 APIC version 20
Jul 28 20:07:12 tony kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
Jul 28 20:07:12 tony kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
Jul 28 20:07:12 tony kernel: ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
Jul 28 20:07:12 tony kernel: Processor #6 15:4 APIC version 20
Jul 28 20:07:12 tony kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jul 28 20:07:12 tony kernel: Processor #1 15:4 APIC version 20
Jul 28 20:07:12 tony kernel: ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
Jul 28 20:07:12 tony kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
Jul 28 20:07:12 tony kernel: ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
Jul 28 20:07:12 tony kernel: Processor #7 15:4 APIC version 20
Jul 28 20:07:12 tony kernel: ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Jul 28 20:07:12 tony kernel: Enabling APIC mode:  Flat.  Using 0 I/O APICs
Jul 28 20:07:12 tony kernel: ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
Jul 28 20:07:12 tony kernel: IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
Jul 28 20:07:12 tony kernel: ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
Jul 28 20:07:12 tony kernel: IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
Jul 28 20:07:12 tony kernel: ACPI: IOAPIC (id[0x0a] address[0xfec80400] gsi_base[48])
Jul 28 20:07:12 tony kernel: IOAPIC[2]: apic_id 10, version 32, address 0xfec80400, GSI 48-71
Jul 28 20:07:12 tony kernel: ACPI: IOAPIC (id[0x0b] address[0xfec84000] gsi_base[72])
Jul 28 20:07:12 tony kernel: IOAPIC[3]: apic_id 11, version 32, address 0xfec84000, GSI 72-95
Jul 28 20:07:12 tony kernel: ACPI: IOAPIC (id[0x0c] address[0xfec84400] gsi_base[96])
Jul 28 20:07:12 tony kernel: IOAPIC[4]: apic_id 12, version 32, address 0xfec84400, GSI 96-119
Jul 28 20:07:12 tony kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Jul 28 20:07:12 tony kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jul 28 20:07:12 tony kernel: Using ACPI (MADT) for SMP configuration information
Jul 28 20:07:12 tony kernel: Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
Jul 28 20:07:12 tony kernel: Built 1 zonelists
Jul 28 20:07:12 tony kernel: Kernel command line: ro root=LABEL=/ quiet
Jul 28 20:07:12 tony kernel: Initializing CPU#0
Jul 28 20:07:12 tony kernel: CPU 0 irqstacks, hard=c03f6000 soft=c03d6000
Jul 28 20:07:12 tony kernel: PID hash table entries: 4096 (order: 12, 65536 bytes)
Jul 28 20:07:12 tony kernel: Detected 3402.115 MHz processor.
Jul 28 20:07:12 tony kernel: Using pmtmr for high-res timesource
Jul 28 20:07:12 tony kernel: Console: colour VGA+ 80x25
Jul 28 20:07:12 tony kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Jul 28 20:07:12 tony kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul 28 20:07:12 tony kernel: Memory: 10326828k/10944508k available (1892k kernel code, 92440k reserved, 768k data, 192k init, 9502664k highmem)
Jul 28 20:07:12 tony kernel: Calibrating delay using timer specific routine.. 6805.15 BogoMIPS (lpj=3402576)
Jul 28 20:07:12 tony kernel: Security Scaffold v1.0.0 initialized
Jul 28 20:07:12 tony kernel: SELinux:  Initializing.
Jul 28 20:07:12 tony kernel: There is already a security framework initialized, register_security failed.
Jul 28 20:07:12 tony kernel: selinux_register_security:  Registering secondary module capability
Jul 28 20:07:12 tony kernel: Capability LSM initialized as secondary
Jul 28 20:07:12 tony kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jul 28 20:07:12 tony kernel: monitor/mwait feature present.
Jul 28 20:07:12 tony kernel: using mwait in idle threads.
Jul 28 20:07:12 tony kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jul 28 20:07:12 tony kernel: CPU: L2 cache: 2048K
Jul 28 20:07:12 tony kernel: CPU0: Initial APIC ID: 0, Physical Processor ID: 0
Jul 28 20:07:12 tony kernel: Intel machine check architecture supported.
Jul 28 20:07:12 tony kernel: Intel machine check reporting enabled on CPU#0.
Jul 28 20:07:12 tony kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
Jul 28 20:07:12 tony kernel: CPU0: Thermal monitoring enabled
Jul 28 20:07:12 tony kernel: Enabling fast FPU save and restore... done.
Jul 28 20:07:12 tony kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 28 20:07:12 tony kernel: Checking 'hlt' instruction... OK.
Jul 28 20:07:12 tony kernel: CPU0: Intel(R) Xeon(TM) CPU 3.40GHz stepping 0a
Jul 28 20:07:12 tony kernel: per-CPU timeslice cutoff: 5850.11 usecs.
Jul 28 20:07:12 tony kernel: task migration cache decay timeout: 5 msecs.
Jul 28 20:07:12 tony kernel: Booting processor 1/1 eip 3000
Jul 28 20:07:12 tony kernel: CPU 1 irqstacks, hard=c03f7000 soft=c03d7000
Jul 28 20:07:12 tony kernel: Initializing CPU#1
Jul 28 20:07:12 tony kernel: Calibrating delay using timer specific routine.. 6799.37 BogoMIPS (lpj=3399688)
Jul 28 20:07:12 tony irqbalance: irqbalance startup succeeded
Jul 28 20:07:12 tony kernel: monitor/mwait feature present.
Jul 28 20:07:12 tony kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jul 28 20:07:12 tony kernel: CPU: L2 cache: 2048K
Jul 28 20:07:12 tony kernel: CPU1: Initial APIC ID: 1, Physical Processor ID: 0
Jul 28 20:07:12 tony kernel: Intel machine check architecture supported.
Jul 28 20:07:12 tony kernel: Intel machine check reporting enabled on CPU#1.
Jul 28 20:07:12 tony kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
Jul 28 20:07:12 tony kernel: CPU1: Thermal monitoring enabled
Jul 28 20:07:12 tony kernel: CPU1: Intel(R) Xeon(TM) CPU 3.40GHz stepping 0a
Jul 28 20:07:12 tony kernel: Booting processor 2/6 eip 3000
Jul 28 20:07:12 tony kernel: CPU 2 irqstacks, hard=c03f8000 soft=c03d8000
Jul 28 20:07:12 tony kernel: Initializing CPU#2
Jul 28 20:07:12 tony kernel: Calibrating delay using timer specific routine.. 6799.40 BogoMIPS (lpj=3399702)
Jul 28 20:07:12 tony kernel: monitor/mwait feature present.
Jul 28 20:07:12 tony kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jul 28 20:07:12 tony kernel: CPU: L2 cache: 2048K
Jul 28 20:07:12 tony kernel: CPU2: Initial APIC ID: 6, Physical Processor ID: 3
Jul 28 20:07:12 tony kernel: Intel machine check architecture supported.
Jul 28 20:07:12 tony kernel: Intel machine check reporting enabled on CPU#2.
Jul 28 20:07:12 tony kernel: CPU2: Intel P4/Xeon Extended MCE MSRs (24) available
Jul 28 20:07:12 tony kernel: CPU2: Thermal monitoring enabled
Jul 28 20:07:12 tony kernel: CPU2: Intel(R) Xeon(TM) CPU 3.40GHz stepping 0a
Jul 28 20:07:12 tony kernel: Booting processor 3/7 eip 3000
Jul 28 20:07:12 tony kernel: CPU 3 irqstacks, hard=c03f9000 soft=c03d9000
Jul 28 20:07:12 tony kernel: Initializing CPU#3
Jul 28 20:07:12 tony kernel: Calibrating delay using timer specific routine.. 6799.29 BogoMIPS (lpj=3399648)
Jul 28 20:07:12 tony kernel: monitor/mwait feature present.
Jul 28 20:07:12 tony kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jul 28 20:07:12 tony kernel: CPU: L2 cache: 2048K
Jul 28 20:07:12 tony kernel: CPU3: Initial APIC ID: 7, Physical Processor ID: 3
Jul 28 20:07:12 tony kernel: Intel machine check architecture supported.
Jul 28 20:07:12 tony kernel: Intel machine check reporting enabled on CPU#3.
Jul 28 20:07:12 tony kernel: CPU3: Intel P4/Xeon Extended MCE MSRs (24) available
Jul 28 20:07:12 tony kernel: CPU3: Thermal monitoring enabled
Jul 28 20:07:12 tony kernel: CPU3: Intel(R) Xeon(TM) CPU 3.40GHz stepping 0a
Jul 28 20:07:12 tony kernel: Total of 4 processors activated (27203.22 BogoMIPS).
Jul 28 20:07:12 tony kernel: ENABLING IO-APIC IRQs
Jul 28 20:07:12 tony kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jul 28 20:07:12 tony kernel: checking TSC synchronization across 4 CPUs: passed.
Jul 28 20:07:12 tony kernel: Brought up 4 CPUs
Jul 28 20:07:12 tony kernel: zapping low mappings.
Jul 28 20:07:12 tony kernel: checking if image is initramfs... it is
Jul 28 20:07:12 tony kernel: Freeing initrd memory: 1008k freed
Jul 28 20:07:12 tony kernel: NET: Registered protocol family 16
Jul 28 20:07:12 tony kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0096, last bus=12
Jul 28 20:07:12 tony kernel: PCI: Using MMCONFIG
Jul 28 20:07:12 tony kernel: mtrr: v2.0 (20020519)
Jul 28 20:07:12 tony kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
Jul 28 20:07:12 tony kernel: mtrr: probably your BIOS does not setup all CPUs.
Jul 28 20:07:12 tony kernel: mtrr: corrected configuration.
Jul 28 20:07:12 tony kernel: ACPI: Subsystem revision 20040816
Jul 28 20:07:12 tony kernel: ACPI: Interpreter enabled
Jul 28 20:07:12 tony kernel: ACPI: Using IOAPIC for interrupt routing
Jul 28 20:07:12 tony kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul 28 20:07:12 tony kernel: PCI: Probing PCI hardware (bus 00)
Jul 28 20:07:12 tony kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Jul 28 20:07:12 tony kernel: PCI: PXH quirk detected, disabling MSI for SHPC device
Jul 28 20:07:12 tony last message repeated 3 times
Jul 28 20:07:12 tony kernel: PCI: Transparent bridge - 0000:00:1e.0
Jul 28 20:07:12 tony portmap: portmap startup succeeded
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *5 7 10 11)
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *5 7 10 11)
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *5 7 10 11)
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *5 7 10 11)
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 5 7 10 11) *0, disabled.
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs *5 7 10 11)
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs *5 7 10 11)
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7 10 11)
Jul 28 20:07:12 tony kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jul 28 20:07:12 tony kernel: usbcore: registered new driver usbfs
Jul 28 20:07:12 tony kernel: usbcore: registered new driver hub
Jul 28 20:07:12 tony kernel: PCI: Using ACPI for IRQ routing
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 177
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 169
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 193
Jul 28 20:07:12 tony kernel: ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 25 (level, low) -> IRQ 201
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:03:01.1[B] -> GSI 26 (level, low) -> IRQ 209
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 51 (level, low) -> IRQ 217
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:06:01.0[A] -> GSI 74 (level, low) -> IRQ 225
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 78 (level, low) -> IRQ 233
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 21 (level, low) -> IRQ 50
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:01:04.2[B] -> GSI 22 (level, low) -> IRQ 58
Jul 28 20:07:12 tony kernel: PCI: Device 00:00 not found by BIOS
Jul 28 20:07:12 tony kernel: apm: BIOS not found.
Jul 28 20:07:12 tony kernel: audit: initializing netlink socket (disabled)
Jul 28 20:07:12 tony kernel: audit(1248811553.431:1): initialized
Jul 28 20:07:12 tony kernel: highmem bounce pool size: 64 pages
Jul 28 20:07:12 tony kernel: Total HugeTLB memory allocated, 0
Jul 28 20:07:12 tony kernel: VFS: Disk quotas dquot_6.5.1
Jul 28 20:07:12 tony kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Jul 28 20:07:12 tony kernel: Initializing Cryptographic API
Jul 28 20:07:12 tony kernel: ksign: Installing public key data
Jul 28 20:07:12 tony kernel: Loading keyring
Jul 28 20:07:12 tony kernel: - Added public key CA81342F869DADAA
Jul 28 20:07:12 tony kernel: - User ID: Red Hat, Inc. (Kernel Module GPG key)
Jul 28 20:07:12 tony kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jul 28 20:07:12 tony kernel: ACPI: Processor [CPU0] (supports C1)
Jul 28 20:07:12 tony kernel: ACPI: Processor [CPU1] (supports C1)
Jul 28 20:07:12 tony kernel: ACPI: Processor [CPU6] (supports C1)
Jul 28 20:07:12 tony kernel: ACPI: Processor [CPU7] (supports C1)
Jul 28 20:07:12 tony kernel: ACPI: Thermal Zone [THM0] (8 C)
Jul 28 20:07:12 tony kernel: Real Time Clock Driver v1.12
Jul 28 20:07:12 tony kernel: Linux agpgart interface v0.100 (c) Dave Jones
Jul 28 20:07:12 tony kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 28 20:07:12 tony kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 28 20:07:12 tony kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 68 ports, IRQ sharing enabled
Jul 28 20:07:12 tony kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul 28 20:07:12 tony kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jul 28 20:07:12 tony kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Jul 28 20:07:12 tony kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul 28 20:07:12 tony kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul 28 20:07:12 tony kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Jul 28 20:07:12 tony kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Jul 28 20:07:12 tony kernel: ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
Jul 28 20:07:12 tony kernel: ICH5: chipset revision 2
Jul 28 20:07:12 tony kernel: ICH5: not 100% native mode: will probe irqs later
Jul 28 20:07:12 tony kernel:     ide0: BM-DMA at 0x0500-0x0507, BIOS settings: hda:DMA, hdb:pio
Jul 28 20:07:12 tony kernel:     ide1: BM-DMA at 0x0508-0x050f, BIOS settings: hdc:pio, hdd:pio
Jul 28 20:07:12 tony kernel: hda: DV-28E-N, ATAPI CD/DVD-ROM drive
Jul 28 20:07:12 tony kernel: Using cfq io scheduler
Jul 28 20:07:12 tony kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 28 20:07:12 tony rpc.statd[4901]: Version 1.0.6 Starting
Jul 28 20:07:12 tony kernel: hda: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Jul 28 20:07:12 tony kernel: Uniform CD-ROM driver Revision: 3.20
Jul 28 20:07:12 tony kernel: ide-floppy driver 0.99.newide
Jul 28 20:07:12 tony kernel: usbcore: registered new driver hiddev
Jul 28 20:07:12 tony kernel: usbcore: registered new driver usbhid
Jul 28 20:07:12 tony kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Jul 28 20:07:12 tony kernel: mice: PS/2 mouse device common for all mice
Jul 28 20:07:12 tony kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul 28 20:07:12 tony kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Jul 28 20:07:12 tony kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jul 28 20:07:12 tony kernel: NET: Registered protocol family 2
Jul 28 20:07:12 tony kernel: IP route cache hash table entries: 524288 (order: 9, 2097152 bytes)
Jul 28 20:07:12 tony kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jul 28 20:07:12 tony kernel: TCP bind hash table entries: 262144 (order: 9, 3145728 bytes)
Jul 28 20:07:12 tony kernel: TCP: Hash tables configured (established 262144 bind 262144)
Jul 28 20:07:12 tony kernel: Initializing IPsec netlink socket
Jul 28 20:07:12 tony kernel: NET: Registered protocol family 1
Jul 28 20:07:12 tony kernel: NET: Registered protocol family 17
Jul 28 20:07:12 tony kernel: ACPI wakeup devices: 
Jul 28 20:07:12 tony kernel: 
Jul 28 20:07:12 tony kernel: ACPI: (supports S0 S4 S5)
Jul 28 20:07:12 tony kernel: Freeing unused kernel memory: 192k freed
Jul 28 20:07:12 tony kernel: SCSI subsystem initialized
Jul 28 20:07:12 tony kernel: HP CISS Driver (v 2.6.16.RH1)
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 51 (level, low) -> IRQ 217
Jul 28 20:07:12 tony kernel: cciss: using DAC cycles
Jul 28 20:07:12 tony kernel:       blocks= 426759839 block_size= 512
Jul 28 20:07:12 tony kernel:       heads= 255, sectors= 32, cylinders= 52299
Jul 28 20:07:12 tony kernel: 
Jul 28 20:07:12 tony kernel:       blocks= 426759839 block_size= 512
Jul 28 20:07:12 tony kernel:       heads= 255, sectors= 32, cylinders= 52299
Jul 28 20:07:12 tony kernel: 
Jul 28 20:07:12 tony kernel:  cciss/c0d0: p1 p2 p3 < p5 p6 p7 >
Jul 28 20:07:12 tony kernel: QLogic Fibre Channel HBA Driver
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:06:01.0[A] -> GSI 74 (level, low) -> IRQ 225
Jul 28 20:07:12 tony kernel: qla2300 0000:06:01.0: Found an ISP2312, irq 225, iobase 0xf8826000
Jul 28 20:07:12 tony kernel: qla2300 0000:06:01.0: Configuring PCI space...
Jul 28 20:07:12 tony kernel: qla2300 0000:06:01.0: Configure NVRAM parameters...
Jul 28 20:07:12 tony kernel: qla2300 0000:06:01.0: Verifying loaded RISC code...
Jul 28 20:07:12 tony kernel: qla2300 0000:06:01.0: Allocated (412 KB) for firmware dump...
Jul 28 20:07:12 tony nfslock: rpc.statd startup succeeded
Jul 28 20:07:12 tony kernel: qla2300 0000:06:01.0: Waiting for LIP to complete...
Jul 28 20:07:12 tony kernel: qla2300 0000:06:01.0: Cable is unplugged...
Jul 28 20:07:12 tony kernel: scsi0 : qla2xxx
Jul 28 20:07:12 tony kernel: qla2300 0000:06:01.0: 
Jul 28 20:07:12 tony kernel:  QLogic Fibre Channel HBA Driver: 8.01.06.01
Jul 28 20:07:12 tony kernel:   QLogic QLA2340 - 
Jul 28 20:07:12 tony kernel:   ISP2312: PCI-X (100 MHz) @ 0000:06:01.0 hdma+, host#=0, fw=3.03.19 IPX
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 78 (level, low) -> IRQ 233
Jul 28 20:07:12 tony kernel: qla2300 0000:06:02.0: Found an ISP2312, irq 233, iobase 0xf8830000
Jul 28 20:07:12 tony kernel: qla2300 0000:06:02.0: Configuring PCI space...
Jul 28 20:07:12 tony kernel: qla2300 0000:06:02.0: Configure NVRAM parameters...
Jul 28 20:07:12 tony kernel: qla2300 0000:06:02.0: Verifying loaded RISC code...
Jul 28 20:07:12 tony kernel: qla2300 0000:06:02.0: Allocated (412 KB) for firmware dump...
Jul 28 20:07:12 tony kernel: qla2300 0000:06:02.0: Waiting for LIP to complete...
Jul 28 20:07:12 tony kernel: qla2300 0000:06:02.0: Cable is unplugged...
Jul 28 20:07:12 tony kernel: scsi1 : qla2xxx
Jul 28 20:07:12 tony kernel: qla2300 0000:06:02.0: 
Jul 28 20:07:12 tony kernel:  QLogic Fibre Channel HBA Driver: 8.01.06.01
Jul 28 20:07:12 tony kernel:   QLogic QLA2340 - 
Jul 28 20:07:12 tony kernel:   ISP2312: PCI-X (100 MHz) @ 0000:06:02.0 hdma+, host#=1, fw=3.03.19 IPX
Jul 28 20:07:12 tony kernel: kjournald starting.  Commit interval 5 seconds
Jul 28 20:07:12 tony kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 28 20:07:12 tony kernel: SELinux:  Disabled at runtime.
Jul 28 20:07:12 tony kernel: inserting floppy driver for 2.6.9-67.ELsmp
Jul 28 20:07:12 tony kernel: Floppy drive(s): fd0 is 1.44M
Jul 28 20:07:12 tony kernel: FDC 0 is a National Semiconductor PC87306
Jul 28 20:07:12 tony kernel: tg3.c:v3.66f (September 1, 2006)
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 25 (level, low) -> IRQ 201
Jul 28 20:07:12 tony kernel: eth0: Tigon3 [partno(N/A) rev 2100 PHY(5704)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:17:a4:48:2c:09
Jul 28 20:07:12 tony kernel: eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0] 
Jul 28 20:07:12 tony kernel: eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:03:01.1[B] -> GSI 26 (level, low) -> IRQ 209
Jul 28 20:07:12 tony kernel: eth1: Tigon3 [partno(N/A) rev 2100 PHY(5704)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:17:a4:48:2c:08
Jul 28 20:07:12 tony kernel: eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
Jul 28 20:07:12 tony kernel: eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
Jul 28 20:07:12 tony kernel: hw_random hardware driver 1.0.0 loaded
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 193
Jul 28 20:07:12 tony kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jul 28 20:07:12 tony kernel: ehci_hcd 0000:00:1d.7: irq 193, pci mem f8834000
Jul 28 20:07:12 tony kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Jul 28 20:07:12 tony kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Jul 28 20:07:12 tony kernel: hub 1-0:1.0: USB hub found
Jul 28 20:07:12 tony kernel: hub 1-0:1.0: 8 ports detected
Jul 28 20:07:12 tony kernel: USB Universal Host Controller Interface driver v2.2
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.0: irq 169, io base 00003000
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Jul 28 20:07:12 tony kernel: hub 2-0:1.0: USB hub found
Jul 28 20:07:12 tony kernel: hub 2-0:1.0: 2 ports detected
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 177
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.1: irq 177, io base 00003020
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Jul 28 20:07:12 tony kernel: hub 3-0:1.0: USB hub found
Jul 28 20:07:12 tony kernel: hub 3-0:1.0: 2 ports detected
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.2: irq 185, io base 00003040
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Jul 28 20:07:12 tony kernel: hub 4-0:1.0: USB hub found
Jul 28 20:07:12 tony kernel: hub 4-0:1.0: 2 ports detected
Jul 28 20:07:12 tony kernel: ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 169
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.3: irq 169, io base 00003060
Jul 28 20:07:12 tony kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Jul 28 20:07:12 tony kernel: hub 5-0:1.0: USB hub found
Jul 28 20:07:12 tony kernel: hub 5-0:1.0: 2 ports detected
Jul 28 20:07:12 tony kernel: md: Autodetecting RAID arrays.
Jul 28 20:07:12 tony kernel: md: autorun ...
Jul 28 20:07:12 tony kernel: md: ... autorun DONE.
Jul 28 20:07:12 tony kernel: ACPI: Power Button (FF) [PWRF]
Jul 28 20:07:12 tony kernel: EXT3 FS on cciss/c0d0p1, internal journal
Jul 28 20:07:12 tony kernel: device-mapper: 4.5.5-ioctl (2006-12-01) initialised: dm-devel@redhat.com
Jul 28 20:07:12 tony kernel: kjournald starting.  Commit interval 5 seconds
Jul 28 20:07:12 tony kernel: EXT3 FS on cciss/c0d0p5, internal journal
Jul 28 20:07:12 tony kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 28 20:07:12 tony kernel: kjournald starting.  Commit interval 5 seconds
Jul 28 20:07:12 tony kernel: EXT3 FS on cciss/c0d0p6, internal journal
Jul 28 20:07:12 tony kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 28 20:07:12 tony kernel: kjournald starting.  Commit interval 5 seconds
Jul 28 20:07:12 tony kernel: EXT3 FS on cciss/c0d0p7, internal journal
Jul 28 20:07:12 tony kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 28 20:07:12 tony kernel: Adding 2096472k swap on /dev/cciss/c0d0p2.  Priority:-1 extents:1
Jul 28 20:07:12 tony kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Jul 28 20:07:12 tony kernel: microcode: CPU0 already at revision 0x2 (current=0x2)
Jul 28 20:07:12 tony kernel: microcode: CPU1 already at revision 0x2 (current=0x2)
Jul 28 20:07:12 tony kernel: microcode: CPU2 already at revision 0x2 (current=0x2)
Jul 28 20:07:12 tony kernel: microcode: CPU3 already at revision 0x2 (current=0x2)
Jul 28 20:07:12 tony kernel: microcode: No new microdata for cpu 3
Jul 28 20:07:12 tony kernel: microcode: No new microdata for cpu 1
Jul 28 20:07:12 tony kernel: microcode: No new microdata for cpu 0
Jul 28 20:07:12 tony kernel: microcode: No new microdata for cpu 2
Jul 28 20:07:12 tony kernel: IA-32 Microcode Update Driver v1.14 unregistered
Jul 28 20:07:12 tony kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul 28 20:07:12 tony kernel: ip_conntrack version 2.1 (8192 buckets, 65536 max) - 340 bytes per conntrack
Jul 28 20:07:12 tony kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Jul 28 20:07:12 tony kernel: tg3: eth0: Flow control is off for TX and off for RX.
Jul 28 20:07:12 tony kernel: 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
Jul 28 20:07:12 tony kernel: All bugs added by David S. Miller <davem@redhat.com>
Jul 28 20:07:12 tony rpcidmapd: rpc.idmapd startup succeeded
Jul 28 20:07:12 tony netfs: Mounting other filesystems:  succeeded
Jul 28 20:07:13 tony kernel: i2c /dev entries driver
Jul 28 20:07:13 tony rc: Starting lm_sensors:  succeeded
Jul 28 20:07:13 tony acpid: acpid startup succeeded
Jul 28 20:07:13 tony hp-vtd: Product ID 18 is not licensed on this system.
Jul 28 20:07:13 tony hp-vtd: 
Jul 28 20:07:13 tony hp-vtd: Copyright (c) 2005 Hewlett-Packard Development Company, L.P.
Jul 28 20:07:13 tony hp-vtd: hp-vtd failed to start
Jul 28 20:07:13 tony lsb_start_daemon: hp-vtd startup failed
Jul 28 20:07:13 tony lsb_log_message:   failed
Jul 28 20:07:13 tony snmpd: snmpd startup succeeded
Jul 28 20:07:14 tony kernel: lp: driver loaded but no devices found
Jul 28 20:07:14 tony cups: cupsd startup succeeded
Jul 28 20:07:14 tony kernel: NET: Registered protocol family 10
Jul 28 20:07:14 tony kernel: Disabled Privacy Extensions on device c0349440(lo)
Jul 28 20:07:14 tony kernel: IPv6 over IPv4 tunneling driver
Jul 28 16:06:41 tony rc.sysinit: -e 
Jul 28 20:06:41 tony date: Tue Jul 28 20:06:41 EDT 2009 
Jul 28 20:06:41 tony rc.sysinit: Setting clock  (localtime): Tue Jul 28 20:06:41 EDT 2009 succeeded 
Jul 28 20:06:43 tony start_udev: Starting udev:  succeeded 
Jul 28 20:06:44 tony udevsend[3308]: starting udevd daemon 
Jul 28 20:06:44 tony udevsend[3310]: starting udevd daemon 
Jul 28 20:06:46 tony rc.sysinit: -e 
Jul 28 20:06:46 tony sysctl: net.ipv4.ip_forward = 0 
Jul 28 20:06:46 tony sysctl: net.ipv4.conf.default.rp_filter = 1 
Jul 28 20:06:46 tony sysctl: net.ipv4.conf.default.accept_source_route = 0 
Jul 28 20:06:46 tony sysctl: kernel.sysrq = 0 
Jul 28 20:07:14 tony sshd:  succeeded
Jul 28 20:06:46 tony sysctl: kernel.core_uses_pid = 1 
Jul 28 20:06:46 tony rc.sysinit: Configuring kernel parameters:  succeeded 
Jul 28 20:06:46 tony rc.sysinit: Loading default keymap succeeded 
Jul 28 20:06:46 tony rc.sysinit: Setting hostname tony.eyemg.com:  succeeded 
Jul 28 20:06:46 tony fsck: /: clean, 158435/4718592 files, 1280395/9436171 blocks 
Jul 28 20:06:46 tony rc.sysinit: Checking root filesystem succeeded 
Jul 28 20:06:46 tony rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
Jul 28 20:06:46 tony lvm.static:   No volume groups found 
Jul 28 20:06:46 tony rc.sysinit: Setting up Logical Volume Management: succeeded 
Jul 28 20:06:46 tony fsck: /dev/cciss/c0d0p5: clean, 1947/2686976 files, 930407/5373734 blocks 
Jul 28 20:06:46 tony fsck: /dev/cciss/c0d0p6: clean, 1041/2686976 files, 260439/5373734 blocks 
Jul 28 20:06:46 tony fsck: /dev/cciss/c0d0p7: clean, 159/16318464 files, 8714850/32636039 blocks 
Jul 28 20:06:46 tony rc.sysinit: Checking filesystems succeeded 
Jul 28 20:06:46 tony rc.sysinit: Mounting local filesystems:  succeeded 
Jul 28 20:06:46 tony rc.sysinit: Enabling local filesystem quotas:  succeeded 
Jul 28 20:06:47 tony rc.sysinit: Enabling swap space:  succeeded 
Jul 28 20:06:47 tony init: Entering runlevel: 3 
Jul 28 20:06:47 tony microcode_ctl: microcode_ctl startup succeeded 
Jul 28 20:06:47 tony sysstat: Calling the system activity data collector (sadc):  
Jul 28 20:06:47 tony sysstat:  
Jul 28 20:06:47 tony rc: Starting sysstat:  succeeded 
Jul 28 20:06:56 tony kudzu:  succeeded 
Jul 28 20:06:56 tony rc: Starting openibd:  succeeded 
Jul 28 20:06:57 tony iptables:  succeeded 
Jul 28 20:06:57 tony rc: Starting pcmcia:  succeeded 
Jul 28 20:06:57 tony sysctl: net.ipv4.ip_forward = 0 
Jul 28 20:06:57 tony sysctl: net.ipv4.conf.default.rp_filter = 1 
Jul 28 20:06:57 tony sysctl: net.ipv4.conf.default.accept_source_route = 0 
Jul 28 20:06:57 tony sysctl: kernel.sysrq = 0 
Jul 28 20:06:57 tony sysctl: kernel.core_uses_pid = 1 
Jul 28 20:06:57 tony network: Setting network parameters:  succeeded 
Jul 28 20:06:57 tony network: Bringing up loopback interface:  succeeded 
Jul 28 20:07:01 tony network: Bringing up interface eth0:  succeeded 
Jul 28 20:07:03 tony network: Bringing up interface eth0-1:  succeeded 
Jul 28 20:07:07 tony network: Bringing up interface eth0-2:  succeeded 
Jul 28 20:07:11 tony network: Bringing up interface eth0-3:  succeeded 
Jul 28 20:07:12 tony vlan: WARNING:  Could not open /proc/net/vlan/config.  Maybe you need to load the 8021q module, or maybe you are not using PROCFS?? 
Jul 28 20:07:12 tony vlan: Set name-type for VLAN subsystem. Should be visible in /proc/net/vlan/config 
Jul 28 20:07:12 tony rc: Starting vlan:  succeeded 
Jul 28 20:07:14 tony xinetd: xinetd startup succeeded
Jul 28 20:07:14 tony xinetd[5138]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
Jul 28 20:07:14 tony xinetd[5138]: Started working: 0 available services
Jul 28 20:07:18 tony ntpdate[5164]: step time server 208.79.157.11 offset -0.486135 sec
Jul 28 20:07:18 tony ntpd:  succeeded
Jul 28 20:07:18 tony ntpd[5168]: ntpd 4.2.0a@1.1190-r Thu Oct  5 04:11:32 EDT 2006 (1)
Jul 28 20:07:18 tony ntpd: ntpd startup succeeded
Jul 28 20:07:18 tony ntpd[5168]: precision = 3.000 usec
Jul 28 20:07:18 tony ntpd[5168]: Listening on interface wildcard, 0.0.0.0#123
Jul 28 20:07:18 tony ntpd[5168]: Listening on interface wildcard, ::#123
Jul 28 20:07:18 tony ntpd[5168]: Listening on interface lo, 127.0.0.1#123
Jul 28 20:07:18 tony ntpd[5168]: Listening on interface eth0, 10.0.8.82#123
Jul 28 20:07:18 tony ntpd[5168]: Listening on interface eth0:1, 10.0.8.166#123
Jul 28 20:07:18 tony ntpd[5168]: Listening on interface eth0:2, 10.0.8.174#123
Jul 28 20:07:18 tony ntpd[5168]: Listening on interface eth0:3, 10.0.8.54#123
Jul 28 20:07:18 tony ntpd[5168]: kernel time sync status 0040
Jul 28 20:07:18 tony ntpd[5168]: frequency initialized 37.611 PPM from /var/lib/ntp/drift
Jul 28 20:07:19 tony vsftpd: vsftpd vsftpd succeeded
Jul 28 20:07:20 tony mysqld: Starting MySQL:  succeeded
Jul 28 20:07:20 tony sendmail: sendmail startup succeeded
Jul 28 20:07:20 tony sendmail: sm-client startup succeeded
Jul 28 20:07:20 tony gpm[5328]: *** info [startup.c(95)]: 
Jul 28 20:07:20 tony gpm[5328]: Started gpm successfully. Entered daemon mode.
Jul 28 20:07:20 tony gpm[5328]: *** info [mice.c(1766)]: 
Jul 28 20:07:20 tony gpm[5328]: imps2: Auto-detected intellimouse PS/2
Jul 28 20:07:21 tony gpm: gpm startup succeeded
Jul 28 20:07:24 tony hpsmhd: smhstart startup succeeded
Jul 28 20:07:26 tony httpd: httpd startup succeeded
Jul 28 20:07:26 tony crond: crond startup succeeded
Jul 28 20:07:27 tony xfs: xfs startup succeeded
Jul 28 20:07:28 tony hpasm:    Starting Proliant System Health Monitor (hpasmd):
Jul 28 20:07:28 tony hpasm: [60G
Jul 28 20:07:28 tony hpasm:   
Jul 28 20:07:28 tony hpasmd[5928]: ProLiant System Health Monitor loading 
Jul 28 20:07:28 tony hpasm: Starting Foundation Agents (cmafdtn): cmathreshd cmahostd cmapeerd
Jul 28 20:07:28 tony hpasm:    Starting Threshold agent (cmathreshd):
Jul 28 20:07:28 tony hpasm: [60G
Jul 28 20:07:28 tony hpasm:   
Jul 28 20:07:28 tony hpasm:    Starting Host agent (cmahostd):
Jul 28 20:07:28 tony hpasm: [60G
Jul 28 20:07:28 tony hpasm:   
Jul 28 20:07:28 tony hpasm:    Starting SNMP Peer (cmapeerd):
Jul 28 20:07:28 tony hpasm: [60G
Jul 28 20:07:28 tony hpasm:   
Jul 28 20:07:28 tony hpasm: 
Jul 28 20:07:28 tony hpasm: Starting Server Agents (cmasvr): cmastdeqd cmahealthd cmaperfd
Jul 28 20:07:28 tony hpasm:    Starting Standard Equipment agent (cmastdeqd):
Jul 28 20:07:28 tony hpasm: [60G
Jul 28 20:07:28 tony hpasm:   
Jul 28 20:07:28 tony hpasm:    Starting Health agent (cmahealthd):
Jul 28 20:07:28 tony hpasm: [60G
Jul 28 20:07:28 tony hpasm:   
Jul 28 20:07:28 tony hpasm:    Starting Performance agent (cmaperfd):
Jul 28 20:07:28 tony hpasm: [60G
Jul 28 20:07:28 tony hpasm:   
Jul 28 20:07:28 tony hpasm: 
Jul 28 20:07:29 tony hpasm: Starting HP Lights-Out Drivers and Agents (hprsm):  cpqci cpqriisd cmasm2d cmarackd
Jul 28 20:07:29 tony hpasm:    Starting cpqci:
Jul 28 20:07:29 tony kernel: cpqci: module license 'Proprietary' taints kernel.
Jul 28 20:07:29 tony kernel: ACPI: PCI Interrupt 0000:01:04.2[B] -> GSI 22 (level, low) -> IRQ 58
Jul 28 20:07:29 tony hprsm: cpqci startup succeeded
Jul 28 20:07:29 tony hpasm: [60G
Jul 28 20:07:29 tony hpasm:   
Jul 28 20:07:29 tony hpasm:    Starting cpqriisd:
Jul 28 20:07:29 tony cpqriisd: Failed to detect rack, cpqriisd exiting....
Jul 28 20:07:29 tony hprsm: cpqriisd startup succeeded
Jul 28 20:07:29 tony hpasm: [60G
Jul 28 20:07:35 tony hpasm:   
Jul 28 20:07:35 tony hpasm:    Starting RIB agent (cmasm2d):
Jul 28 20:07:35 tony hpasm: [  
Jul 28 20:07:35 tony hpasm:   
Jul 28 20:07:35 tony hpasm:    Starting Rack agent (cmarackd):
Jul 28 20:07:35 tony hpasm: [  
Jul 28 20:07:35 tony hpasm:   
Jul 28 20:07:35 tony hpasm:   
Jul 28 20:07:35 tony hpasm: Starting Storage Agents (cmastor): cmaeventd cmaidad cmafcad cmaided cmascsid cmasasd
Jul 28 20:07:35 tony hpasm:    Starting Storage Event Logger (cmaeventd):
Jul 28 20:07:35 tony hpasm: [60G
Jul 28 20:07:35 tony hpasm:   
Jul 28 20:07:35 tony hpasm:    Starting IDA agent (cmaidad):
Jul 28 20:07:35 tony hpasm: [60G
Jul 28 20:07:35 tony hpasm:   
Jul 28 20:07:35 tony hpasm:    Starting FCA agent (cmafcad):
Jul 28 20:07:35 tony hpasm: [60G
Jul 28 20:07:35 tony hpasm:   
Jul 28 20:07:35 tony hpasm:    Starting IDE agent (cmaided):
Jul 28 20:07:35 tony hpasm: [60G
Jul 28 20:07:35 tony hpasm:   
Jul 28 20:07:35 tony hpasm:    Starting SCSI agent (cmascsid):
Jul 28 20:07:35 tony hpasm: [60G
Jul 28 20:07:35 tony hpasm:   
Jul 28 20:07:36 tony hpasm:    Starting SAS agent (cmasasd):
Jul 28 20:07:36 tony hpasm: [60G
Jul 28 20:07:36 tony hpasm:   
Jul 28 20:07:36 tony hpasm: 
Jul 28 20:07:36 tony hpasm: Starting NIC Agents (cmanic): All agents
Jul 28 20:07:36 tony hpasm:    Starting NIC Agent Daemon (cmanicd):
Jul 28 20:07:38 tony hpasm: [60G
Jul 28 20:07:38 tony hpasm: 
Jul 28 20:07:38 tony hpasm: hpasm:  Server Management is enabled
Jul 28 20:07:38 tony rc: Starting hpasm:  succeeded
Jul 28 20:07:39 tony cpqriisd: Failed to detect rack, cpqriisd exiting....
Jul 28 20:07:39 tony hprsm: cpqriisd startup succeeded
Jul 28 20:07:45 tony anacron: anacron startup succeeded
Jul 28 20:07:45 tony atd: atd startup succeeded
Jul 28 20:07:45 tony messagebus: messagebus startup succeeded
Jul 28 20:07:45 tony cups-config-daemon: cups-config-daemon startup succeeded
Jul 28 20:07:45 tony haldaemon: haldaemon startup succeeded
Jul 28 20:07:45 tony fstab-sync[7077]: removed all generated mount points
Jul 28 20:07:45 tony fstab-sync[7118]: added mount point /media/cdrom for /dev/hda
Jul 28 20:07:45 tony vcagentd: Type: 4 - Event ID: 1073741884 
Jul 28 20:07:46 tony hpvca: vcagentd startup succeeded
Jul 28 20:07:46 tony fstab-sync[7817]: added mount point /media/floppy for /dev/fd0
Jul 28 20:07:51 tony kernel: Fusion MPT base driver 3.02.99.00rh
Jul 28 20:07:51 tony kernel: Copyright (c) 1999-2007 LSI Logic Corporation
Jul 28 20:07:51 tony kernel: Fusion MPT misc device (ioctl) driver 3.02.99.00rh
Jul 28 20:07:51 tony kernel: mptctl: Registered with Fusion MPT base driver
Jul 28 20:07:51 tony kernel: mptctl: /dev/mptctl @ (major,minor=10,220)
Jul 28 20:08:05 tony cmafcad[6294]: Host controller 1 status change.Status is now Loop Degraded. 
Jul 28 20:08:05 tony cmafcad[6294]: Host controller 2 status change.Status is now Loop Degraded. 
Jul 28 20:10:29 tony sshd(pam_unix)[10166]: session closed for user root
Jul 28 20:10:30 tony ntpd[5168]: synchronized to 208.79.157.11, stratum 2
Jul 28 20:10:30 tony ntpd[5168]: kernel time sync disabled 0041
Jul 28 20:12:29 tony sshd(pam_unix)[11529]: session opened for user root by (uid=0)
Jul 28 20:12:38 tony ntpd[5168]: kernel time sync enabled 0001RHEL4 Reboot
Jul 28 13:28:12 seth logger: FINGERPRING_BEGIN
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
Jul 28 13:30:21 seth login(pam_unix)[2224]: session opened for user root by LOGIN(uid=0)
Jul 28 13:30:21 seth  -- root[2224]: ROOT LOGIN ON tty1