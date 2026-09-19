Jul 30 16:31:16 dino shutdown[10447]: shutting down for system reboot
Jul 30 16:31:37 dino ntpd[22594]: ntpd exiting on signal 15
Jul 30 16:31:37 dino hcid[1894]: Got disconnected from the system message bus
Jul 30 16:31:37 dino rpc.statd[1806]: Caught signal 15, un-registering and exiting.
Jul 30 16:31:38 dino pcscd: pcscdaemon.c:529:signal_trap() Preparing for suicide
Jul 30 16:31:38 dino pcscd: hotplug_libusb.c:361:HPEstablishUSBNotifications() Hotplug stopped
Jul 30 16:31:39 dino pcscd: readerfactory.c:1350:RFCleanupReaders() entering cleaning function
Jul 30 16:31:39 dino pcscd: pcscdaemon.c:489:at_exit() cleaning /var/run
Jul 30 16:31:39 dino kernel: Kernel logging (proc) stopped.
Jul 30 16:31:39 dino kernel: Kernel log daemon terminating.
Jul 30 16:31:40 dino exiting on signal 15
Jul 30 16:33:33 dino syslogd 1.4.1: restart.
Jul 30 16:33:33 dino kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul 30 16:33:33 dino kernel: Linux version 2.6.18-8.el5 (brewbuilder@ls20-bc2-14.build.redhat.com) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-52)) #1 SMP Fri Jan 26 14:15:21 EST 2007
Jul 30 16:33:33 dino kernel: BIOS-provided physical RAM map:
Jul 30 16:33:33 dino kernel:  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
Jul 30 16:33:33 dino kernel:  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
Jul 30 16:33:33 dino kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul 30 16:33:33 dino kernel:  BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
Jul 30 16:33:33 dino kernel:  BIOS-e820: 000000003fffc000 - 0000000040000000 (ACPI data)
Jul 30 16:33:33 dino kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Jul 30 16:33:33 dino kernel:  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
Jul 30 16:33:33 dino kernel:  BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
Jul 30 16:33:33 dino kernel: 127MB HIGHMEM available.
Jul 30 16:33:33 dino kernel: 896MB LOWMEM available.
Jul 30 16:33:33 dino kernel: found SMP MP-table at 000f4fd0
Jul 30 16:33:33 dino kernel: Using x86 segment limits to approximate NX protection
Jul 30 16:33:33 dino kernel: DMI 2.3 present.
Jul 30 16:33:33 dino kernel: Using APIC driver default
Jul 30 16:33:33 dino kernel: ACPI: PM-Timer IO Port: 0x240
Jul 30 16:33:33 dino kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
Jul 30 16:33:33 dino kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
Jul 30 16:33:33 dino kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
Jul 30 16:33:33 dino kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Jul 30 16:33:33 dino kernel: Processor #3 6:11 APIC version 17
Jul 30 16:33:33 dino kernel: ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Jul 30 16:33:33 dino kernel: ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
Jul 30 16:33:33 dino kernel: IOAPIC[0]: apic_id 8, version 17, address 0xfec00000, GSI 0-15
Jul 30 16:33:33 dino kernel: ACPI: IOAPIC (id[0x02] address[0xfec01000] gsi_base[16])
Jul 30 16:33:33 dino kernel: IOAPIC[1]: apic_id 2, version 17, address 0xfec01000, GSI 16-31
Jul 30 16:33:33 dino kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Jul 30 16:33:33 dino rpc.statd[1836]: Version 1.0.9 Starting
Jul 30 16:33:33 dino kernel: Enabling APIC mode:  Flat.  Using 2 I/O APICs
Jul 30 16:33:33 dino kernel: Using ACPI (MADT) for SMP configuration information
Jul 30 16:33:34 dino kernel: Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Jul 30 16:33:34 dino kernel: Detected 1125.807 MHz processor.
Jul 30 16:33:34 dino kernel: Built 1 zonelists.  Total pages: 262140
Jul 30 16:33:34 dino rpc.statd[1836]: statd running as root. chown /var/lib/nfs/statd/sm to choose different user 
Jul 30 16:33:34 dino kernel: Kernel command line: ro root=LABEL=/ quiet
Jul 30 16:33:34 dino kernel: Enabling fast FPU save and restore... done.
Jul 30 16:33:34 dino kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 30 16:33:34 dino kernel: Initializing CPU#0
Jul 30 16:33:34 dino kernel: CPU 0 irqstacks, hard=c0737000 soft=c0717000
Jul 30 16:33:34 dino kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
Jul 30 16:33:34 dino kernel: Console: colour VGA+ 80x25
Jul 30 16:33:34 dino kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Jul 30 16:33:34 dino kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul 30 16:33:34 dino kernel: Memory: 1033392k/1048560k available (2043k kernel code, 14428k reserved, 846k data, 232k init, 131056k highmem)
Jul 30 16:33:34 dino kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jul 30 16:33:34 dino kernel: Calibrating delay using timer specific routine.. 2252.10 BogoMIPS (lpj=1126053)
Jul 30 16:33:34 dino kernel: Security Framework v1.0.0 initialized
Jul 30 16:33:34 dino kernel: SELinux:  Initializing.
Jul 30 16:33:34 dino kernel: SELinux:  Starting in permissive mode
Jul 30 16:33:34 dino kernel: selinux_register_security:  Registering secondary module capability
Jul 30 16:33:34 dino kernel: Capability LSM initialized as secondary
Jul 30 16:33:34 dino kernel: Mount-cache hash table entries: 512
Jul 30 16:33:34 dino kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 30 16:33:34 dino kernel: CPU: L2 cache: 512K
Jul 30 16:33:34 dino kernel: Intel machine check architecture supported.
Jul 30 16:33:34 dino kernel: Intel machine check reporting enabled on CPU#0.
Jul 30 16:33:34 dino kernel: Checking 'hlt' instruction... OK.
Jul 30 16:33:34 dino kernel: SMP alternatives: switching to UP code
Jul 30 16:33:34 dino kernel: Freeing SMP alternatives: 16k freed
Jul 30 16:33:34 dino kernel: ACPI: Core revision 20060707
Jul 30 16:33:34 dino kernel: CPU0: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
Jul 30 16:33:34 dino kernel: Total of 1 processors activated (2252.10 BogoMIPS).
Jul 30 16:33:34 dino kernel: ENABLING IO-APIC IRQs
Jul 30 16:33:34 dino kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Jul 30 16:33:34 dino kernel: ..MP-BIOS bug: 8254 timer not connected to IO-APIC
Jul 30 16:33:34 dino kernel: ...trying to set up timer (IRQ0) through the 8259A ...  failed.
Jul 30 16:33:34 dino kernel: ...trying to set up timer as Virtual Wire IRQ... works.
Jul 30 16:33:35 dino kernel: Brought up 1 CPUs
Jul 30 16:33:35 dino hcid[1925]: Bluetooth HCI daemon
Jul 30 16:33:35 dino kernel: checking if image is initramfs... it is
Jul 30 16:33:35 dino kernel: Freeing initrd memory: 1455k freed
Jul 30 16:33:35 dino hcid[1925]: Register path:/org/bluez fallback:1
Jul 30 16:33:35 dino kernel: NET: Registered protocol family 16
Jul 30 16:33:35 dino kernel: ACPI: bus type pci registered
Jul 30 16:33:35 dino kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0094, last bus=10
Jul 30 16:33:35 dino kernel: PCI: Using configuration type 1
Jul 30 16:33:35 dino kernel: Setting up standard PCI resources
Jul 30 16:33:35 dino kernel: ACPI: Interpreter enabled
Jul 30 16:33:35 dino kernel: ACPI: Using IOAPIC for interrupt routing
Jul 30 16:33:35 dino kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jul 30 16:33:35 dino kernel: PCI: Firmware left 0000:00:02.0 e100 interrupts enabled, disabling
Jul 30 16:33:35 dino sdpd[1929]: Bluetooth SDP daemon 
Jul 30 16:33:35 dino kernel: PCI: Firmware left 0000:00:04.0 e100 interrupts enabled, disabling
Jul 30 16:33:35 dino pcscd: pcscdaemon.c:464:main() pcsc-lite 1.3.1 daemon ready.
Jul 30 16:33:35 dino kernel: ACPI: PCI Root Bridge [PCI1] (0000:01)
Jul 30 16:33:35 dino kernel: ACPI: PCI Root Bridge [PCI2] (0000:07)
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INA0] (IRQs 15) *0, disabled.
Jul 30 16:33:36 dino hidd[2026]: Bluetooth HID daemon
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INA1] (IRQs 15) *0, disabled.
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INA2] (IRQs 15) *0, disabled.
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INA3] (IRQs 15) *0, disabled.
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INA4] (IRQs 15) *7
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INA5] (IRQs 15) *10
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INA6] (IRQs 15) *11
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INA7] (IRQs *15)
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INA8] (IRQs 15) *0, disabled.
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INA9] (IRQs 15) *0, disabled.
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INAA] (IRQs 15) *0, disabled.
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INAB] (IRQs 15) *0, disabled.
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INAC] (IRQs 15) *0, disabled.
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INAD] (IRQs *15)
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INAE] (IRQs 15) *0, disabled.
Jul 30 16:33:36 dino kernel: ACPI: PCI Interrupt Link [INAF] (IRQs 15) *0, disabled.
Jul 30 16:33:36 dino kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jul 30 16:33:36 dino kernel: pnp: PnP ACPI init
Jul 30 16:33:36 dino kernel: pnp: PnP ACPI: found 11 devices
Jul 30 16:33:36 dino kernel: usbcore: registered new driver usbfs
Jul 30 16:33:36 dino kernel: usbcore: registered new driver hub
Jul 30 16:33:36 dino kernel: PCI: Using ACPI for IRQ routing
Jul 30 16:33:36 dino kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jul 30 16:33:36 dino kernel: PCI: Device 0000:00:00.0 not found by BIOS
Jul 30 16:33:36 dino kernel: PCI: Device 0000:00:00.1 not found by BIOS
Jul 30 16:33:36 dino hpiod: 1.6.7 accepting connections at 2208... 
Jul 30 16:33:36 dino kernel: PCI: Device 0000:00:00.2 not found by BIOS
Jul 30 16:33:36 dino kernel: PCI: Device 0000:00:00.3 not found by BIOS
Jul 30 16:33:36 dino kernel: PCI: Device 0000:00:0f.0 not found by BIOS
Jul 30 16:33:36 dino kernel: NetLabel: Initializing
Jul 30 16:33:36 dino kernel: NetLabel:  domain hash size = 128
Jul 30 16:33:36 dino kernel: NetLabel:  protocols = UNLABELED CIPSOv4
Jul 30 16:33:36 dino kernel: NetLabel:  unlabeled traffic allowed by default
Jul 30 16:33:36 dino kernel: pnp: 00:01: ioport range 0xf50-0xf58 has been reserved
Jul 30 16:33:37 dino kernel: NET: Registered protocol family 2
Jul 30 16:33:37 dino kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Jul 30 16:33:37 dino kernel: TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
Jul 30 16:33:37 dino kernel: TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
Jul 30 16:33:37 dino kernel: TCP: Hash tables configured (established 131072 bind 65536)
Jul 30 16:33:37 dino kernel: TCP reno registered
Jul 30 16:33:37 dino kernel: apm: BIOS not found.
Jul 30 16:33:37 dino kernel: audit: initializing netlink socket (disabled)
Jul 30 16:33:37 dino kernel: audit(1248971577.766:1): initialized
Jul 30 16:33:37 dino kernel: highmem bounce pool size: 64 pages
Jul 30 16:33:37 dino kernel: Total HugeTLB memory allocated, 0
Jul 30 16:33:37 dino kernel: VFS: Disk quotas dquot_6.5.1
Jul 30 16:33:37 dino kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Jul 30 16:33:37 dino kernel: SELinux:  Registering netfilter hooks
Jul 30 16:33:37 dino kernel: Initializing Cryptographic API
Jul 30 16:33:37 dino kernel: ksign: Installing public key data
Jul 30 16:33:37 dino kernel: Loading keyring
Jul 30 16:33:37 dino kernel: - Added public key 86B4033B99649BB9
Jul 30 16:33:37 dino kernel: - User ID: Red Hat, Inc. (Kernel Module GPG key)
Jul 30 16:33:37 dino kernel: io scheduler noop registered
Jul 30 16:33:37 dino kernel: io scheduler anticipatory registered
Jul 30 16:33:37 dino kernel: io scheduler deadline registered
Jul 30 16:33:37 dino kernel: io scheduler cfq registered (default)
Jul 30 16:33:37 dino kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jul 30 16:33:37 dino kernel: ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
Jul 30 16:33:37 dino kernel: ACPI: Getting cpuindex for acpiid 0x1
Jul 30 16:33:37 dino kernel: ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
Jul 30 16:33:37 dino kernel: ACPI: Getting cpuindex for acpiid 0x2
Jul 30 16:33:37 dino kernel: BIOS reported wrong ACPI idfor the processor
Jul 30 16:33:37 dino kernel: ACPI Exception (evxface-0545): AE_NOT_EXIST, Removing notify handler [20060707]
Jul 30 16:33:37 dino kernel: ACPI: Thermal Zone [THM0] (8 C)
Jul 30 16:33:38 dino kernel: Real Time Clock Driver v1.12ac
Jul 30 16:33:38 dino kernel: Non-volatile memory driver v1.2
Jul 30 16:33:38 dino kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jul 30 16:33:38 dino kernel: agpgart: unable to determine aperture size.
Jul 30 16:33:38 dino kernel: agpgart: agp_backend_initialize() failed.
Jul 30 16:33:38 dino kernel: agpgart-serverworks: probe of 0000:00:00.0 failed with error -22
Jul 30 16:33:38 dino kernel: agpgart: unable to determine aperture size.
Jul 30 16:33:38 dino kernel: agpgart: agp_backend_initialize() failed.
Jul 30 16:33:38 dino kernel: agpgart-serverworks: probe of 0000:00:00.1 failed with error -22
Jul 30 16:33:38 dino kernel: agpgart: ServerWorks CNB20HE is unsupported due to lack of documentation.
Jul 30 16:33:38 dino kernel: agpgart: ServerWorks CNB20HE is unsupported due to lack of documentation.
Jul 30 16:33:38 dino kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Jul 30 16:33:38 dino kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul 30 16:33:38 dino kernel: 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul 30 16:33:38 dino kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Jul 30 16:33:38 dino kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul 30 16:33:38 dino kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul 30 16:33:38 dino kernel: SvrWks OSB4: IDE controller at PCI slot 0000:00:0f.1
Jul 30 16:33:38 dino kernel: SvrWks OSB4: chipset revision 0
Jul 30 16:33:38 dino kernel: SvrWks OSB4: not 100% native mode: will probe irqs later
Jul 30 16:33:38 dino kernel:     ide0: BM-DMA at 0x2c00-0x2c07, BIOS settings: hda:pio, hdb:pio
Jul 30 16:33:38 dino kernel:     ide1: BM-DMA at 0x2c08-0x2c0f, BIOS settings: hdc:pio, hdd:pio
Jul 30 16:33:38 dino kernel: hda: CD-224E, ATAPI CD/DVD-ROM drive
Jul 30 16:33:38 dino kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 30 16:33:38 dino kernel: ide-floppy driver 0.99.newide
Jul 30 16:33:38 dino kernel: usbcore: registered new driver hiddev
Jul 30 16:33:38 dino kernel: usbcore: registered new driver usbhid
Jul 30 16:33:38 dino kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Jul 30 16:33:39 dino kernel: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
Jul 30 16:33:39 dino kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 30 16:33:39 dino kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 30 16:33:39 dino kernel: mice: PS/2 mouse device common for all mice
Jul 30 16:33:39 dino kernel: md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jul 30 16:33:39 dino kernel: md: bitmap version 4.39
Jul 30 16:33:39 dino kernel: TCP bic registered
Jul 30 16:33:39 dino kernel: Initializing IPsec netlink socket
Jul 30 16:33:39 dino kernel: NET: Registered protocol family 1
Jul 30 16:33:39 dino kernel: NET: Registered protocol family 17
Jul 30 16:33:39 dino kernel: Using IPI No-Shortcut mode
Jul 30 16:33:39 dino kernel: ACPI: (supports S0 S4 S5)
Jul 30 16:33:39 dino kernel: Freeing unused kernel memory: 232k freed
Jul 30 16:33:39 dino kernel: Write protecting the kernel read-only data: 383k
Jul 30 16:33:39 dino kernel: Time: tsc clocksource has been installed.
Jul 30 16:33:39 dino kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Jul 30 16:33:39 dino kernel: USB Universal Host Controller Interface driver v3.0
Jul 30 16:33:39 dino kernel: ACPI: PCI Interrupt 0000:00:0f.2[A] -> GSI 22 (level, low) -> IRQ 169
Jul 30 16:33:39 dino kernel: ohci_hcd 0000:00:0f.2: OHCI Host Controller
Jul 30 16:33:39 dino kernel: ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
Jul 30 16:33:39 dino kernel: ohci_hcd 0000:00:0f.2: irq 169, io mem 0xf0fd0000
Jul 30 16:33:39 dino kernel: usb usb1: configuration #1 chosen from 1 choice
Jul 30 16:33:40 dino kernel: hub 1-0:1.0: USB hub found
Jul 30 16:33:40 dino kernel: hub 1-0:1.0: 4 ports detected
Jul 30 16:33:40 dino kernel: input: PS/2 Generic Mouse as /class/input/input1
Jul 30 16:33:40 dino kernel: SCSI subsystem initialized
Jul 30 16:33:40 dino kernel: HP CISS Driver (v 3.6.14-RH1)
Jul 30 16:33:40 dino kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 177
Jul 30 16:33:40 dino kernel: cciss0: <0xb178> at PCI 0000:00:01.0 IRQ 177 using DAC
Jul 30 16:33:40 dino kernel:       blocks= 213367680 block_size= 512
Jul 30 16:33:40 dino kernel:       heads= 255, sectors= 32, cylinders= 26148
Jul 30 16:33:40 dino kernel: 
Jul 30 16:33:40 dino kernel:       blocks= 213367680 block_size= 512
Jul 30 16:33:40 dino kernel:       heads= 255, sectors= 32, cylinders= 26148
Jul 30 16:33:40 dino kernel: 
Jul 30 16:33:40 dino kernel:  cciss/c0d0: p1 p2 p3
Jul 30 16:33:40 dino kernel: kjournald starting.  Commit interval 5 seconds
Jul 30 16:33:40 dino kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 30 16:33:40 dino kernel: SELinux:  Disabled at runtime.
Jul 30 16:33:40 dino kernel: SELinux:  Unregistering netfilter hooks
Jul 30 16:33:40 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 19: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:40 dino kernel: audit(1248971584.944:2): selinux=0 auid=4294967295
Jul 30 16:33:40 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 20: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:40 dino kernel: e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
Jul 30 16:33:40 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 21: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:40 dino kernel: e100: Copyright(c) 1999-2005 Intel Corporation
Jul 30 16:33:40 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 22: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:40 dino kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 18 (level, low) -> IRQ 185
Jul 30 16:33:40 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 23: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:41 dino kernel: e100: eth0: e100_probe: addr 0xf2eb0000, irq 185, MAC addr 00:08:02:3D:50:FB
Jul 30 16:33:41 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 25: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:41 dino kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 20 (level, low) -> IRQ 193
Jul 30 16:33:41 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 26: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:41 dino kernel: e100: eth1: e100_probe: addr 0xf2cf0000, irq 193, MAC addr 00:08:02:3D:50:FA
Jul 30 16:33:41 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 27: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:41 dino kernel: cpqphp: Compaq Hot Plug PCI Controller Driver version: 0.9.8
Jul 30 16:33:41 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 28: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:41 dino kernel: ACPI: PCI Interrupt 0000:07:07.0[A] -> GSI 23 (level, low) -> IRQ 201
Jul 30 16:33:41 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 29: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:41 dino kernel: cpqphp: Hot Plug Subsystem Device ID: a2f9
Jul 30 16:33:41 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 30: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:41 dino kernel: cpqphp: Initializing the PCI hot plug controller residing on PCI bus 7
Jul 30 16:33:41 dino snmpd[2086]: /etc/snmp/snmpd.conf: line 31: Error: WARNING: This output format is being deprecated - Please use the 'extend' directive instead 
Jul 30 16:33:41 dino kernel: PCI: Using BIOS Interrupt Routing Table
Jul 30 16:33:41 dino snmpd[2086]: dlopen failed: /usr/lib/libcmaX.so: cannot open shared object file: No such file or directory 
Jul 30 16:33:41 dino kernel: PCI: Using BIOS Interrupt Routing Table
Jul 30 16:33:41 dino snmpd[2086]: net-snmp: 12 error(s) in config file(s) 
Jul 30 16:33:41 dino kernel: hda: ATAPI 24X CD-ROM drive, 128kB Cache
Jul 30 16:33:41 dino kernel: Uniform CD-ROM driver Revision: 3.20
Jul 30 16:33:41 dino kernel: input: PC Speaker as /class/input/input2
Jul 30 16:33:41 dino kernel: piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 device
Jul 30 16:33:41 dino kernel: piix4_smbus 0000:00:0f.0: SMB base address uninitialized - upgrade BIOS or use force_addr=0xaddr
Jul 30 16:33:41 dino kernel: Floppy drive(s): fd0 is 1.44M
Jul 30 16:33:41 dino kernel: FDC 0 is a National Semiconductor PC87306
Jul 30 16:33:41 dino kernel: lp: driver loaded but no devices found
Jul 30 16:33:41 dino kernel: ACPI: Power Button (FF) [PWRF]
Jul 30 16:33:41 dino kernel: ibm_acpi: ec object not found
Jul 30 16:33:41 dino kernel: md: Autodetecting RAID arrays.
Jul 30 16:33:41 dino kernel: md: autorun ...
Jul 30 16:33:41 dino kernel: md: ... autorun DONE.
Jul 30 16:33:41 dino kernel: device-mapper: ioctl: 4.11.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
Jul 30 16:33:41 dino kernel: hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
Jul 30 16:33:41 dino kernel: hda: packet command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
Jul 30 16:33:41 dino kernel: ide: failed opcode was: unknown
Jul 30 16:33:42 dino kernel: hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
Jul 30 16:33:42 dino kernel: hda: packet command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
Jul 30 16:33:42 dino kernel: ide: failed opcode was: unknown
Jul 30 16:33:42 dino kernel: EXT3 FS on cciss/c0d0p1, internal journal
Jul 30 16:33:42 dino kernel: Adding 2096472k swap on /dev/cciss/c0d0p2.  Priority:-1 extents:1 across:2096472k
Jul 30 16:33:42 dino kernel: IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
Jul 30 16:33:42 dino kernel: NET: Registered protocol family 10
Jul 30 16:33:42 dino kernel: lo: Disabled Privacy Extensions
Jul 30 16:33:42 dino kernel: IPv6 over IPv4 tunneling driver
Jul 30 16:33:42 dino kernel: ip6_tables: (C) 2000-2006 Netfilter Core Team
Jul 30 16:33:42 dino kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Jul 30 16:33:42 dino kernel: Netfilter messages via NETLINK v0.30.
Jul 30 16:33:42 dino kernel: ip_conntrack version 2.4 (8191 buckets, 65528 max) - 228 bytes per conntrack
Jul 30 16:33:42 dino kernel: ADDRCONF(NETDEV_UP): eth0: link is not ready
Jul 30 16:33:42 dino kernel: e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Jul 30 16:33:42 dino kernel: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Jul 30 16:33:42 dino kernel: Bluetooth: Core ver 2.10
Jul 30 16:33:42 dino kernel: NET: Registered protocol family 31
Jul 30 16:33:42 dino kernel: Bluetooth: HCI device and connection manager initialized
Jul 30 16:33:42 dino kernel: Bluetooth: HCI socket layer initialized
Jul 30 16:33:42 dino kernel: Bluetooth: L2CAP ver 2.8
Jul 30 16:33:42 dino kernel: Bluetooth: L2CAP socket layer initialized
Jul 30 16:33:42 dino kernel: Bluetooth: RFCOMM socket layer initialized
Jul 30 16:33:42 dino kernel: Bluetooth: RFCOMM TTY layer initialized
Jul 30 16:33:42 dino kernel: Bluetooth: RFCOMM ver 1.8
Jul 30 16:33:42 dino kernel: Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Jul 30 16:33:44 dino ntpdate[2125]: step time server 208.79.157.12 offset -0.496456 sec
Jul 30 16:33:44 dino ntpd[2127]: ntpd 4.2.2p1@1.1570-o Wed Nov 29 15:19:23 UTC 2006 (1)
Jul 30 16:33:44 dino ntpd[2128]: precision = 1.000 usec
Jul 30 16:33:44 dino ntpd[2128]: Listening on interface wildcard, 0.0.0.0#123 Disabled
Jul 30 16:33:44 dino ntpd[2128]: Listening on interface wildcard, ::#123 Disabled
Jul 30 16:33:44 dino ntpd[2128]: Listening on interface lo, ::1#123 Enabled
Jul 30 16:33:44 dino ntpd[2128]: Listening on interface eth0, fe80::208:2ff:fe3d:50fb#123 Enabled
Jul 30 16:33:44 dino ntpd[2128]: Listening on interface lo, 127.0.0.1#123 Enabled
Jul 30 16:33:44 dino ntpd[2128]: Listening on interface eth0, 10.0.8.64#123 Enabled
Jul 30 16:33:44 dino ntpd[2128]: Listening on interface eth0:1, 10.0.8.157#123 Enabled
Jul 30 16:33:44 dino ntpd[2128]: Listening on interface eth0:2, 10.0.8.158#123 Enabled
Jul 30 16:33:44 dino ntpd[2128]: kernel time sync status 0040
Jul 30 16:33:44 dino ntpd[2128]: frequency initialized 167.723 PPM from /var/lib/ntp/drift
Jul 30 16:33:46 dino gpm[2319]: *** info [startup.c(95)]: 
Jul 30 16:33:46 dino gpm[2319]: Started gpm successfully. Entered daemon mode.
Jul 30 16:33:55 dino kernel: ADDRCONF(NETDEV_UP): eth1: link is not ready
Jul 30 16:31:18 lamont.eyemg.com kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jul 30 16:31:18 lamont.eyemg.com kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
Jul 30 16:31:18 lamont.eyemg.com kernel: ehci_hcd 0000:00:1d.7: debug port 1
Jul 30 16:31:18 lamont.eyemg.com kernel: ehci_hcd 0000:00:1d.7: irq 193, io mem 0xfbef0000
Jul 30 16:31:18 lamont.eyemg.com kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Jul 30 16:31:18 lamont.eyemg.com kernel: tg3.c:v3.65-rh (November 20, 2006)
Jul 30 16:31:18 lamont.eyemg.com kernel: hda: HL-DT-STDVD-ROM GDR-8084N, ATAPI CD/DVD-ROM drive
Jul 30 16:31:18 lamont.eyemg.com kernel: migration_cost=33,1786
Jul 30 16:31:18 lamont.eyemg.com kernel: PCI: Not using MMCONFIG.
Jul 30 16:31:18 lamont.eyemg.com kernel: PCI quirk: region 0900-097f claimed by ICH4 ACPI/GPIO/TCO
Jul 30 16:31:18 lamont.eyemg.com kernel: PCI quirk: region 0800-083f claimed by ICH4 GPIO
Jul 30 16:31:18 lamont.eyemg.com kernel:   PREFETCH window: 88100000-881fffff
Jul 30 16:31:18 lamont.eyemg.com kernel: HP CISS Driver (v 3.6.16-4)
Jul 30 16:31:51 lamont.eyemg.com kernel: Fusion MPT base driver 3.04.02
Jul 30 16:31:18 lamont.eyemg.com kernel: EDAC MC: Ver: 2.0.1 Jan 26 2007

Jul 30 11:45:31 ammon shutdown[13874]: shutting down for system reboot                                                                         
Jul 30 11:45:45 ammon ntpd[1941]: ntpd exiting on signal 15                                                                                    
Jul 30 11:45:46 ammon hcid[1728]: Got disconnected from the system message bus                                                                 
Jul 30 11:45:46 ammon rpc.statd[1625]: Caught signal 15, un-registering and exiting.                                                           
Jul 30 11:45:47 ammon auditd[1508]: The audit daemon is exiting.                                                                               
Jul 30 11:45:47 ammon kernel: audit(1248968747.473:14769): audit_pid=0 old=1508 by auid=4294967295                                             
Jul 30 11:45:47 ammon pcscd: pcscdaemon.c:529:signal_trap() Preparing for suicide                                                              
Jul 30 11:45:48 ammon pcscd: hotplug_libusb.c:361:HPEstablishUSBNotifications() Hotplug stopped                                                
Jul 30 11:45:48 ammon pcscd: readerfactory.c:1350:RFCleanupReaders() entering cleaning function                                                
Jul 30 11:45:48 ammon pcscd: pcscdaemon.c:489:at_exit() cleaning /var/run                                                                      
Jul 30 11:45:48 ammon kernel: Kernel logging (proc) stopped.                                                                                   
Jul 30 11:45:48 ammon kernel: Kernel log daemon terminating.                                                                                   
Jul 30 11:45:50 ammon exiting on signal 15                                                                                                     
Jul 30 11:47:38 ammon syslogd 1.4.1: restart.                                                                                                  
Jul 30 11:47:38 ammon kernel: klogd 1.4.1, log source = /proc/kmsg started.                                                                    
Jul 30 11:47:38 ammon kernel: Linux version 2.6.18-8.el5 (brewbuilder@ls20-bc2-14.build.redhat.com) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-52)) #1 SMP Fri Jan 26 14:15:21 EST 2007                                                                                                       
Jul 30 11:47:38 ammon kernel: BIOS-provided physical RAM map:                                                                                  
Jul 30 11:47:38 ammon kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)                                                         
Jul 30 11:47:38 ammon kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)                                                       
Jul 30 11:47:38 ammon kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)                                                       
Jul 30 11:47:38 ammon kernel:  BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)                                                         
Jul 30 11:47:38 ammon kernel:  BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI data)                                                      
Jul 30 11:47:38 ammon kernel:  BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)                                                       
Jul 30 11:47:38 ammon kernel:  BIOS-e820: 000000001ff00000 - 0000000020000000 (usable)                                                         
Jul 30 11:47:38 ammon kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)                                                       
Jul 30 11:47:38 ammon kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)                                                       
Jul 30 11:47:38 ammon kernel:  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)                                                       
Jul 30 11:47:39 ammon kernel: 0MB HIGHMEM available.                                                                                           
Jul 30 11:47:40 ammon kernel: 512MB LOWMEM available.                                                                                          
Jul 30 11:47:40 ammon kernel: found SMP MP-table at 000f6ce0                                                                                   
Jul 30 11:47:40 ammon kernel: Using x86 segment limits to approximate NX protection                                                            
Jul 30 11:47:42 ammon kernel: DMI present.                                                                                                     
Jul 30 11:47:42 ammon kernel: Using APIC driver default                                                                                        
Jul 30 11:47:42 ammon rpc.statd[1624]: Version 1.0.9 Starting                                                                                  
Jul 30 11:47:45 ammon rpc.statd[1624]: statd running as root. chown /var/lib/nfs/statd/sm to choose different user                             
Jul 30 11:47:46 ammon kernel: ACPI: PM-Timer IO Port: 0x1008                                                                                   
Jul 30 11:47:46 ammon kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)                                                               
Jul 30 11:47:48 ammon kernel: Processor #0 15:4 APIC version 17                                                                                
Jul 30 11:47:48 ammon kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])                                                              
Jul 30 11:47:48 ammon audispd: starting audispd                                                                                                
Jul 30 11:47:49 ammon kernel: ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])                                                          
Jul 30 11:47:49 ammon kernel: IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23                                                   
Jul 30 11:47:49 ammon kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)                                                       
Jul 30 11:47:49 ammon kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs                                                                    
Jul 30 11:47:49 ammon kernel: Using ACPI (MADT) for SMP configuration information                                                              
Jul 30 11:47:49 ammon kernel: Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)                                           
Jul 30 11:47:49 ammon kernel: Detected 3399.772 MHz processor.                                                                                 
Jul 30 11:47:49 ammon kernel: Built 1 zonelists.  Total pages: 131072                                                                          
Jul 30 11:47:50 ammon kernel: Kernel command line: ro root=LABEL=/ quiet clocksource=acpi_pm                                                   
Jul 30 11:47:50 ammon kernel: Enabling fast FPU save and restore... done.                                                                      
Jul 30 11:47:51 ammon kernel: Enabling unmasked SIMD FPU exception support... done.                                                            
Jul 30 11:47:51 ammon kernel: Initializing CPU#0                                                                                               
Jul 30 11:47:51 ammon kernel: CPU 0 irqstacks, hard=c0737000 soft=c0717000                                                                     
Jul 30 11:47:51 ammon kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)                                                            
Jul 30 11:47:51 ammon kernel: Console: colour VGA+ 80x25                                                                                       
Jul 30 11:47:51 ammon kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)                                                  
Jul 30 11:47:51 ammon kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)                                                   
Jul 30 11:47:51 ammon kernel: Memory: 513628k/524288k available (2043k kernel code, 9972k reserved, 846k data, 232k init, 0k highmem)          
Jul 30 11:47:51 ammon kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.                                     
Jul 30 11:47:52 ammon kernel: Calibrating delay using timer specific routine.. 7043.50 BogoMIPS (lpj=3521753)                                  
Jul 30 11:47:52 ammon kernel: Security Framework v1.0.0 initialized                                                                            
Jul 30 11:47:52 ammon kernel: SELinux:  Initializing.                                                                                          
Jul 30 11:47:52 ammon kernel: SELinux:  Starting in permissive mode                                                                            
Jul 30 11:47:52 ammon kernel: selinux_register_security:  Registering secondary module capability                                              
Jul 30 11:47:53 ammon kernel: Capability LSM initialized as secondary                                                                          
Jul 30 11:47:53 ammon kernel: Mount-cache hash table entries: 512                                                                              
Jul 30 11:47:53 ammon hcid[1727]: Bluetooth HCI daemon                                                                                         
Jul 30 11:47:54 ammon sdpd[1731]: Bluetooth SDP daemon                                                                                         
Jul 30 11:47:54 ammon hcid[1727]: Register path:/org/bluez fallback:1                                                                          
Jul 30 11:47:55 ammon kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K                                                                      
Jul 30 11:47:55 ammon kernel: CPU: L2 cache: 1024K                                                                                             
Jul 30 11:47:55 ammon kernel: Intel machine check architecture supported.                                                                      
Jul 30 11:47:55 ammon kernel: Intel machine check reporting enabled on CPU#0.                                                                  
Jul 30 11:47:56 ammon kernel: Checking 'hlt' instruction... OK.                                                                                
Jul 30 11:47:56 ammon kernel: SMP alternatives: switching to UP code                                                                           
Jul 30 11:47:56 ammon pcscd: pcscdaemon.c:464:main() pcsc-lite 1.3.1 daemon ready.                                                             
Jul 30 11:47:57 ammon kernel: Freeing SMP alternatives: 16k freed                                                                              
Jul 30 11:47:57 ammon kernel: ACPI: Core revision 20060707                                                                                     
Jul 30 11:47:57 ammon kernel: CPU0: Intel(R) Xeon(TM) CPU 3.40GHz stepping 08                                                                  
Jul 30 11:47:57 ammon kernel: Total of 1 processors activated (7043.50 BogoMIPS).                                                              
Jul 30 11:47:57 ammon kernel: ENABLING IO-APIC IRQs                                                                                            
Jul 30 11:47:58 ammon hidd[1824]: Bluetooth HID daemon                                                                                         
Jul 30 11:47:58 ammon kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1                                                             
Jul 30 11:47:58 ammon kernel: Brought up 1 CPUs                                                                                                
Jul 30 11:47:59 ammon kernel: checking if image is initramfs... it is                                                                          
Jul 30 11:47:59 ammon kernel: Freeing initrd memory: 1484k freed                                                                               
Jul 30 11:47:59 ammon kernel: NET: Registered protocol family 16                                                                               
Jul 30 11:47:59 ammon kernel: ACPI: bus type pci registered                                                                                    
Jul 30 11:47:59 ammon kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd9a0, last bus=1                                                         
Jul 30 11:47:59 ammon kernel: PCI: Using configuration type 1                                                                                  
Jul 30 11:47:59 ammon kernel: Setting up standard PCI resources                                                                                
Jul 30 11:47:59 ammon kernel: ACPI: Interpreter enabled                                                                                        
Jul 30 11:47:59 ammon kernel: ACPI: Using IOAPIC for interrupt routing                                                                         
Jul 30 11:47:59 ammon kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)                                                                           
Jul 30 11:47:59 ammon kernel: PCI quirk: region 1000-103f claimed by PIIX4 ACPI                                                                
Jul 30 11:47:59 ammon kernel: PCI quirk: region 1040-104f claimed by PIIX4 SMB                                                                 
Jul 30 11:47:59 ammon kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 14 15) *0, disabled.                                     
Jul 30 11:47:59 ammon kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 14 15)                                                  
Jul 30 11:47:59 ammon kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 14 15)                                                  
Jul 30 11:47:59 ammon kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 14 15) *0, disabled.                                     
Jul 30 11:47:59 ammon kernel: Linux Plug and Play Support v0.97 (c) Adam Belay                                                                 
Jul 30 11:47:59 ammon kernel: pnp: PnP ACPI init                                                                                               
Jul 30 11:47:59 ammon kernel: pnp: PnP ACPI: found 12 devices                                                                                  
Jul 30 11:47:59 ammon kernel: usbcore: registered new driver usbfs                                                                             
Jul 30 11:47:59 ammon kernel: usbcore: registered new driver hub                                                                               
Jul 30 11:47:59 ammon kernel: PCI: Using ACPI for IRQ routing                                                                                  
Jul 30 11:47:59 ammon kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report                                   
Jul 30 11:47:59 ammon kernel: NetLabel: Initializing                                                                                           
Jul 30 11:47:59 ammon kernel: NetLabel:  domain hash size = 128                                                                                
Jul 30 11:47:59 ammon kernel: NetLabel:  protocols = UNLABELED CIPSOv4                                                                         
Jul 30 11:47:59 ammon kernel: NetLabel:  unlabeled traffic allowed by default                                                                  
Jul 30 11:47:59 ammon kernel: PCI: Bridge: 0000:00:01.0                                                                                        
Jul 30 11:47:59 ammon kernel:   IO window: disabled.                                                                                           
Jul 30 11:47:59 ammon kernel:   MEM window: disabled.                                                                                          
Jul 30 11:47:59 ammon kernel:   PREFETCH window: disabled.                                                                                     
Jul 30 11:47:59 ammon kernel: NET: Registered protocol family 2                                                                                
Jul 30 11:47:59 ammon kernel: IP route cache hash table entries: 16384 (order: 4, 65536 bytes)                                                 
Jul 30 11:47:59 ammon kernel: TCP established hash table entries: 65536 (order: 7, 524288 bytes)                                               
Jul 30 11:47:59 ammon kernel: TCP bind hash table entries: 32768 (order: 6, 262144 bytes)                                                      
Jul 30 11:47:59 ammon kernel: TCP: Hash tables configured (established 65536 bind 32768)                                                       
Jul 30 11:47:59 ammon kernel: TCP reno registered                                                                                              
Jul 30 11:47:59 ammon kernel: Simple Boot Flag at 0x36 set to 0x80                                                                             
Jul 30 11:47:59 ammon kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)                                                         
Jul 30 11:47:59 ammon kernel: apm: overridden by ACPI.                                                                                         
Jul 30 11:47:59 ammon kernel: audit: initializing netlink socket (disabled)                                                                    
Jul 30 11:47:59 ammon kernel: audit(1248954383.506:1): initialized                                                                             
Jul 30 11:47:59 ammon kernel: Total HugeTLB memory allocated, 0                                                                                
Jul 30 11:47:59 ammon kernel: VFS: Disk quotas dquot_6.5.1                                                                                     
Jul 30 11:47:59 ammon kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)                                                       
Jul 30 11:47:59 ammon kernel: SELinux:  Registering netfilter hooks                                                                            
Jul 30 11:47:59 ammon kernel: Initializing Cryptographic API                                                                                   
Jul 30 11:47:59 ammon kernel: ksign: Installing public key data                                                                                
Jul 30 11:47:59 ammon kernel: Loading keyring                                                                                                  
Jul 30 11:47:59 ammon kernel: - Added public key 86B4033B99649BB9                                                                              
Jul 30 11:47:59 ammon kernel: - User ID: Red Hat, Inc. (Kernel Module GPG key)                                                                 
Jul 30 11:47:59 ammon kernel: io scheduler noop registered                                                                                     
Jul 30 11:47:59 ammon kernel: io scheduler anticipatory registered                                                                             
Jul 30 11:47:59 ammon kernel: io scheduler deadline registered                                                                                 
Jul 30 11:47:59 ammon kernel: io scheduler cfq registered (default)                                                                            
Jul 30 11:47:59 ammon kernel: Limiting direct PCI/PCI transfers.                                                                               
Jul 30 11:47:59 ammon kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5                                                                  
Jul 30 11:47:59 ammon kernel: ACPI: Processor [CPU0] (supports 8 throttling states)                                                            
Jul 30 11:47:59 ammon kernel: ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]                   
Jul 30 11:47:59 ammon kernel: ACPI: Getting cpuindex for acpiid 0x1                                                                            
Jul 30 11:47:59 ammon kernel: ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]                   
Jul 30 11:47:59 ammon kernel: ACPI: Getting cpuindex for acpiid 0x2                                                                            
Jul 30 11:47:59 ammon kernel: ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]                   
Jul 30 11:47:59 ammon kernel: ACPI: Getting cpuindex for acpiid 0x3                                                                            
Jul 30 11:47:59 ammon kernel: Real Time Clock Driver v1.12ac                                                                                   
Jul 30 11:47:59 ammon kernel: Non-volatile memory driver v1.2                                                                                  
Jul 30 11:47:59 ammon kernel: Linux agpgart interface v0.101 (c) Dave Jones                                                                    
Jul 30 11:47:59 ammon kernel: agpgart: Detected an Intel 440BX Chipset.                                                                        
Jul 30 11:47:59 ammon kernel: agpgart: AGP aperture is 64M @ 0xec000000                                                                        
Jul 30 11:47:59 ammon kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled                                         
Jul 30 11:47:59 ammon kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A                                                             
Jul 30 11:47:59 ammon kernel: serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A                                                             
Jul 30 11:47:59 ammon kernel: 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A                                                                  
Jul 30 11:48:00 ammon kernel: 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A                                                                  
Jul 30 11:48:00 ammon kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize                                           
Jul 30 11:48:00 ammon kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2                                                         
Jul 30 11:48:00 ammon kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx                                      
Jul 30 11:48:00 ammon kernel: PIIX4: IDE controller at PCI slot 0000:00:07.1                                                                   
Jul 30 11:48:00 ammon kernel: PIIX4: chipset revision 1                                                                                        
Jul 30 11:48:00 ammon kernel: PIIX4: not 100% native mode: will probe irqs later                                                               
Jul 30 11:48:00 ammon kernel:     ide0: BM-DMA at 0x1050-0x1057, BIOS settings: hda:DMA, hdb:pio                                               
Jul 30 11:48:00 ammon kernel:     ide1: BM-DMA at 0x1058-0x105f, BIOS settings: hdc:DMA, hdd:pio                                               
Jul 30 11:48:00 ammon kernel: hda: VMware Virtual IDE Hard Drive, ATA DISK drive                                                               
Jul 30 11:48:00 ammon kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14                                                                              
Jul 30 11:48:00 ammon kernel: hdc: VMware Virtual IDE CDROM Drive, ATAPI CD/DVD-ROM drive                                                      
Jul 30 11:48:00 ammon kernel: ide1 at 0x170-0x177,0x376 on irq 15                                                                              
Jul 30 11:48:00 ammon kernel: hda: max request size: 128KiB                                                                                    
Jul 30 11:48:00 ammon kernel: hda: 41943040 sectors (21474 MB) w/32KiB Cache, CHS=44384/15/63, UDMA(33)                                        
Jul 30 11:48:00 ammon kernel:  hda: hda1 hda2                                                                                                  
Jul 30 11:48:00 ammon kernel: ide-floppy driver 0.99.newide                                                                                    
Jul 30 11:48:00 ammon kernel: usbcore: registered new driver hiddev                                                                            
Jul 30 11:48:00 ammon kernel: usbcore: registered new driver usbhid                                                                            
Jul 30 11:48:00 ammon kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver                                                           
Jul 30 11:48:00 ammon kernel: PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUS] at 0x60,0x64 irq 1,12                                            
Jul 30 11:48:00 ammon kernel: serio: i8042 AUX port at 0x60,0x64 irq 12                                                                        
Jul 30 11:48:00 ammon kernel: serio: i8042 KBD port at 0x60,0x64 irq 1                                                                         
Jul 30 11:48:00 ammon kernel: mice: PS/2 mouse device common for all mice                                                                      
Jul 30 11:48:00 ammon kernel: md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27                                                             
Jul 30 11:48:00 ammon kernel: md: bitmap version 4.39                                                                                          
Jul 30 11:48:00 ammon kernel: TCP bic registered                                                                                               
Jul 30 11:48:00 ammon kernel: Initializing IPsec netlink socket                                                                                
Jul 30 11:48:00 ammon kernel: NET: Registered protocol family 1                                                                                
Jul 30 11:48:00 ammon kernel: NET: Registered protocol family 17                                                                               
Jul 30 11:48:00 ammon kernel: Using IPI No-Shortcut mode                                                                                       
Jul 30 11:48:00 ammon kernel: Time: acpi_pm clocksource has been installed.                                                                    
Jul 30 11:48:00 ammon kernel: ACPI: (supports S0 S1 S5)                                                                                        
Jul 30 11:48:00 ammon kernel: Freeing unused kernel memory: 232k freed                                                                         
Jul 30 11:48:00 ammon kernel: Write protecting the kernel read-only data: 383k                                                                 
Jul 30 11:48:00 ammon kernel: input: AT Translated Set 2 keyboard as /class/input/input0                                                       
Jul 30 11:48:00 ammon kernel: USB Universal Host Controller Interface driver v3.0                                                              
Jul 30 11:48:00 ammon kernel: input: ImPS/2 Generic Wheel Mouse as /class/input/input1                                                         
Jul 30 11:48:00 ammon kernel: Fusion MPT base driver 3.04.02                                                                                   
Jul 30 11:48:00 ammon kernel: Copyright (c) 1999-2005 LSI Logic Corporation                                                                    
Jul 30 11:48:00 ammon kernel: SCSI subsystem initialized                                                                                       
Jul 30 11:48:00 ammon kernel: Fusion MPT SPI Host driver 3.04.02                                                                               
Jul 30 11:48:00 ammon kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 17 (level, low) -> IRQ 169                                            
Jul 30 11:48:00 ammon kernel: mptbase: Initiating ioc0 bringup                                                                                 
Jul 30 11:48:00 ammon kernel: ioc0: 53C1030: Capabilities={Initiator}                                                                          
Jul 30 11:48:00 ammon kernel: scsi0 : ioc0: LSI53C1030, FwRev=00000000h, Ports=1, MaxQ=128, IRQ=169                                            
Jul 30 11:48:00 ammon kernel: input: ImPS/2 Generic Wheel Mouse as /class/input/input2                                                         
Jul 30 11:48:00 ammon kernel: kjournald starting.  Commit interval 5 seconds                                                                   
Jul 30 11:48:00 ammon kernel: EXT3-fs: mounted filesystem with ordered data mode.                                                              
Jul 30 11:48:00 ammon kernel: SELinux:  Disabled at runtime.                                                                                   
Jul 30 11:48:00 ammon kernel: SELinux:  Unregistering netfilter hooks                                                                          
Jul 30 11:48:00 ammon kernel: audit(1248954391.017:2): selinux=0 auid=4294967295                                                               
Jul 30 11:48:00 ammon kernel: parport: PnPBIOS parport detected.                                                                               
Jul 30 11:48:00 ammon kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]                                                              
Jul 30 11:48:00 ammon kernel: hdc: ATAPI 1X CD-ROM drive, 32kB Cache, UDMA(33)                                                                 
Jul 30 11:48:00 ammon kernel: Uniform CD-ROM driver Revision: 3.20                                                                             
Jul 30 11:48:00 ammon kernel: pcnet32.c:v1.32 18.Mar.2006 tsbogend@alpha.franken.de                                                            
Jul 30 11:48:00 ammon kernel: ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 18 (level, low) -> IRQ 177                                            
Jul 30 11:48:00 ammon kernel: pcnet32: PCnet/PCI II 79C970A at 0x1400, 00 0c 29 c4 d6 7d assigned IRQ 177.                                     
Jul 30 11:48:00 ammon kernel: eth0: registered as PCnet/PCI II 79C970A                                                                         
Jul 30 11:48:00 ammon kernel: pcnet32: 1 cards_found.                                                                                          
Jul 30 11:48:00 ammon kernel: input: PC Speaker as /class/input/input3                                                                         
Jul 30 11:48:00 ammon kernel: piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device                                                              
Jul 30 11:48:00 ammon kernel: piix4_smbus 0000:00:07.3: Host SMBus controller not enabled!                                                     
Jul 30 11:48:00 ammon kernel: Floppy drive(s): fd0 is 1.44M                                                                                    
Jul 30 11:48:00 ammon kernel: FDC 0 is a post-1991 82077                                                                                       
Jul 30 11:48:00 ammon kernel: lp0: using parport0 (interrupt-driven).                                                                          
Jul 30 11:48:00 ammon kernel: lp0: console ready                                                                                               
Jul 30 11:48:00 ammon kernel: ACPI: AC Adapter [ACAD] (on-line)                                                                                
Jul 30 11:48:00 ammon kernel: ACPI: Power Button (FF) [PWRF]                                                                                   
Jul 30 11:48:00 ammon kernel: ibm_acpi: ec object not found                                                                                    
Jul 30 11:48:00 ammon kernel: md: Autodetecting RAID arrays.                                                                                   
Jul 30 11:48:00 ammon kernel: md: autorun ...                                                                                                  
Jul 30 11:48:00 ammon kernel: md: ... autorun DONE.                                                                                            
Jul 30 11:48:00 ammon kernel: device-mapper: ioctl: 4.11.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com                                 
Jul 30 11:48:00 ammon kernel: EXT3 FS on hda1, internal journal                                                                                
Jul 30 11:48:00 ammon kernel: Adding 3148732k swap on /dev/hda2.  Priority:-1 extents:1 across:3148732k                                        
Jul 30 11:48:00 ammon kernel: IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>                                                       
Jul 30 11:48:00 ammon kernel: NET: Registered protocol family 10                                                                               
Jul 30 11:48:00 ammon kernel: lo: Disabled Privacy Extensions                                                                                  
Jul 30 11:48:00 ammon kernel: IPv6 over IPv4 tunneling driver                                                                                  
Jul 30 11:48:00 ammon kernel: ip6_tables: (C) 2000-2006 Netfilter Core Team                                                                    
Jul 30 11:48:00 ammon kernel: ip_tables: (C) 2000-2006 Netfilter Core Team                                                                     
Jul 30 11:48:00 ammon kernel: Netfilter messages via NETLINK v0.30.                                                                            
Jul 30 11:48:00 ammon kernel: ip_conntrack version 2.4 (4096 buckets, 32768 max) - 228 bytes per conntrack                                     
Jul 30 11:48:00 ammon kernel: eth0: link up                                                                                                    
Jul 30 11:48:00 ammon kernel: audit(1248968857.482:3): audit_pid=1508 old=0 by auid=4294967295                                                 
Jul 30 11:48:00 ammon kernel: Bluetooth: Core ver 2.10                                                                                         
Jul 30 11:48:00 ammon kernel: NET: Registered protocol family 31                                                                               
Jul 30 11:48:00 ammon kernel: Bluetooth: HCI device and connection manager initialized
Jul 30 11:48:00 ammon kernel: Bluetooth: HCI socket layer initialized
Jul 30 11:48:00 ammon kernel: Bluetooth: L2CAP ver 2.8
Jul 30 11:48:00 ammon kernel: Bluetooth: L2CAP socket layer initialized
Jul 30 11:48:00 ammon kernel: Bluetooth: RFCOMM socket layer initialized
Jul 30 11:48:00 ammon kernel: Bluetooth: RFCOMM TTY layer initialized
Jul 30 11:48:00 ammon kernel: Bluetooth: RFCOMM ver 1.8
Jul 30 11:48:00 ammon kernel: Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Jul 30 11:48:03 ammon snmpd[1882]: dlopen failed: /usr/lib/libcmaX.so: cannot open shared object file: No such file or directory
Jul 30 11:47:56 ammon ntpdate[1937]: step time server 208.79.157.12 offset -11.932713 sec
Jul 30 11:47:56 ammon ntpd[1939]: ntpd 4.2.2p1@1.1570-o Wed Nov 29 15:19:23 UTC 2006 (1)
Jul 30 11:47:56 ammon ntpd[1940]: precision = 4.000 usec
Jul 30 11:47:56 ammon ntpd[1940]: Listening on interface wildcard, 0.0.0.0#123 Disabled
Jul 30 11:47:56 ammon ntpd[1940]: Listening on interface wildcard, ::#123 Disabled
Jul 30 11:47:56 ammon ntpd[1940]: Listening on interface lo, ::1#123 Enabled
Jul 30 11:47:56 ammon ntpd[1940]: Listening on interface eth0, fe80::20c:29ff:fec4:d67d#123 Enabled
Jul 30 11:47:56 ammon ntpd[1940]: Listening on interface lo, 127.0.0.1#123 Enabled
Jul 30 11:47:56 ammon ntpd[1940]: Listening on interface eth0, 10.0.8.58#123 Enabled
Jul 30 11:47:56 ammon ntpd[1940]: kernel time sync status 0040
Jul 30 11:47:57 ammon ntpd[1940]: frequency initialized 141.277 PPM from /var/lib/ntp/drift
Jul 30 11:48:00 ammon gpm[2127]: *** info [startup.c(95)]:
Jul 30 11:48:00 ammon gpm[2127]: Started gpm successfully. Entered daemon mode