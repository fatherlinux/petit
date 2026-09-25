Sep 25 02:28:47 host01.example.net systemd-logind[915]: The system will reboot now!
Sep 25 02:28:47 host01.example.net systemd-logind[915]: System is rebooting.
Sep 25 02:28:47 host01.example.net systemd[1]: Removed slice system-modprobe.slice - Slice /system/modprobe.
Sep 25 02:28:47 host01.example.net systemd[1]: Removed slice system-sshd\x2dkeygen.slice - Slice /system/sshd-keygen.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target cloud-init.target - Cloud-init target.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target nss-lookup.target - Host and Network Name Lookups.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target remote-cryptsetup.target - Remote Encrypted Volumes.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target remote-veritysetup.target - Remote Verity Protected Volumes.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target ssh-access.target - SSH Access Available.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target timers.target - Timer Units.
Sep 25 02:28:47 host01.example.net systemd[1]: dnf-makecache.timer: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped dnf-makecache.timer - dnf5 makecache.
Sep 25 02:28:47 host01.example.net systemd[1]: fstrim.timer: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped fstrim.timer - Discard unused filesystem blocks once a week.
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-tmpfiles-clean.timer: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-tmpfiles-clean.timer - Daily Cleanup of Temporary Directories.
Sep 25 02:28:47 host01.example.net systemd[1]: unbound-anchor.timer: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped unbound-anchor.timer - daily update of the root trust anchor for DNSSEC.
Sep 25 02:28:47 host01.example.net systemd[1]: lvm2-lvmpolld.socket: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Closed lvm2-lvmpolld.socket - LVM2 poll daemon socket.
Sep 25 02:28:47 host01.example.net systemd[1]: cloud-final.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped cloud-final.service - Cloud-init: Final Stage.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=cloud-final comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target multi-user.target - Multi-User System.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target getty.target - Login Prompts.
Sep 25 02:28:47 host01.example.net chronyd[898]: chronyd exiting
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping chronyd.service - NTP client/server...
Sep 25 02:28:47 host01.example.net systemd[1]: cloud-config.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped cloud-config.service - Cloud-init: Config Stage.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=cloud-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target cloud-config.target - Cloud-config availability.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target network-online.target - Network is Online.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping dracut-shutdown.service - Restore /run/initramfs on shutdown...
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping getty@tty1.service - Getty on tty1...
Sep 25 02:28:47 host01.example.net systemd[1]: grub2-systemd-integration.service - Grub2 systemctl reboot --boot-loader-menu=... support skipped, unmet condition check ConditionPathExists=/run/systemd/reboot-to-boot-loader-menu
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping serial-getty@ttyS0.service - Serial Getty on ttyS0...
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping sshd.service - OpenSSH server daemon...
Sep 25 02:28:47 host01.example.net sshd[1038]: Received signal 15; terminating.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping systemd-logind.service - User Login Management...
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping systemd-oomd.service - Userspace Out-Of-Memory (OOM) Killer...
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping systemd-random-seed.service - Load/Save OS Random Seed...
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-udev-load-credentials.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-udev-load-credentials.service - Load udev Rules from Credentials.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-udev-load-credentials comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-oomd.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-oomd.service - Userspace Out-Of-Memory (OOM) Killer.
Sep 25 02:28:47 host01.example.net systemd[1]: chronyd.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-oomd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped chronyd.service - NTP client/server.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=chronyd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-logind.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-logind.service - User Login Management.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-logind comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: sshd.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped sshd.service - OpenSSH server daemon.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=sshd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: getty@tty1.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped getty@tty1.service - Getty on tty1.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=getty@tty1 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: serial-getty@ttyS0.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped serial-getty@ttyS0.service - Serial Getty on ttyS0.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=serial-getty@ttyS0 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: dracut-shutdown.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped dracut-shutdown.service - Restore /run/initramfs on shutdown.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-random-seed.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-random-seed.service - Load/Save OS Random Seed.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-random-seed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net audit: BPF prog-id=58 op=UNLOAD
Sep 25 02:28:47 host01.example.net audit: BPF prog-id=60 op=UNLOAD
Sep 25 02:28:47 host01.example.net audit: BPF prog-id=54 op=UNLOAD
Sep 25 02:28:47 host01.example.net systemd[1]: Removed slice system-getty.slice - Slice /system/getty.
Sep 25 02:28:47 host01.example.net systemd[1]: Removed slice system-serial\x2dgetty.slice - Slice /system/serial-getty.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target sshd-keygen.target.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping systemd-user-sessions.service - Permit User Sessions...
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-user-sessions.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-user-sessions.service - Permit User Sessions.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-user-sessions comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target network.target - Network.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target nss-user-lookup.target - User and Group Name Lookups.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target remote-fs.target - Remote File Systems.
Sep 25 02:28:47 host01.example.net systemd[1]: authselect-apply-changes.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped authselect-apply-changes.service - Apply authselect changes.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=authselect-apply-changes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: cloud-init-network.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped cloud-init-network.service - Cloud-init: Network Stage.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=cloud-init-network comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: NetworkManager-wait-online.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped NetworkManager-wait-online.service - Network Manager Wait Online.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=NetworkManager-wait-online comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping NetworkManager.service - Network Manager...
Sep 25 02:28:47 host01.example.net NetworkManager[912]: <info>  [1790303327.9065] caught SIGTERM, shutting down normally.
Sep 25 02:28:47 host01.example.net NetworkManager[912]: <info>  [1790303327.9086] dhcp4 (enp0s4): canceled DHCP transaction
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping systemd-homed-activate.service - Home Area Activation...
Sep 25 02:28:47 host01.example.net NetworkManager[912]: <info>  [1790303327.9102] dhcp4 (enp0s4): activation: beginning transaction (timeout in 45 seconds)
Sep 25 02:28:47 host01.example.net NetworkManager[912]: <info>  [1790303327.9103] dhcp4 (enp0s4): state changed no lease
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-userdb-load-credentials.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net NetworkManager[912]: <info>  [1790303327.9105] manager: NetworkManager state is now CONNECTED_SITE
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-userdb-load-credentials.service - Load JSON user/group Records from Credentials.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-userdb-load-credentials comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net dbus-broker-launch[889]: Activation request for 'org.freedesktop.nm_dispatcher' failed.
Sep 25 02:28:47 host01.example.net NetworkManager[912]: <info>  [1790303327.9197] exiting (success)
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-homed-activate.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-homed-activate.service - Home Area Activation.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-homed-activate comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping systemd-homed.service - Home Area Manager...
Sep 25 02:28:47 host01.example.net audit: BPF prog-id=67 op=UNLOAD
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=NetworkManager comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: NetworkManager.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped NetworkManager.service - Network Manager.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target network-pre.target - Preparation for Network.
Sep 25 02:28:47 host01.example.net systemd[1]: cloud-init-local.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped cloud-init-local.service - Cloud-init: Local Stage (pre-network).
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-network-generator.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=cloud-init-local comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-network-generator.service - Generate Network Units from Kernel Command Line.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-network-generator comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-homed.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-homed.service - Home Area Manager.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-homed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target basic.target - Basic System.
Sep 25 02:28:47 host01.example.net audit: BPF prog-id=59 op=UNLOAD
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target paths.target - Path Units.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target slices.target - Slice Units.
Sep 25 02:28:47 host01.example.net systemd[1]: Removed slice user.slice - User and Session Slice.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target sockets.target - Socket Units.
Sep 25 02:28:47 host01.example.net systemd[1]: sshd-unix-local.socket: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Closed sshd-unix-local.socket - OpenSSH Server Socket (systemd-ssh-generator, AF_UNIX Local).
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping sshd-vsock.socket - OpenSSH Server Socket (systemd-ssh-generator, AF_VSOCK)...
Sep 25 02:28:47 host01.example.net systemd[1]: sssd-kcm.socket: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Closed sssd-kcm.socket - SSSD Kerberos Cache Manager responder socket.
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-hostnamed.socket: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Closed systemd-hostnamed.socket - Hostname Service Socket.
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-logind-varlink.socket: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Closed systemd-logind-varlink.socket - User Login Management Varlink Socket.
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-mute-console.socket: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Closed systemd-mute-console.socket - Console Output Muting Service Socket.
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-oomd.socket: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Closed systemd-oomd.socket - Userspace Out-Of-Memory (OOM) Killer Socket.
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-repart.socket: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Closed systemd-repart.socket - Disk Repartitioning Service Socket.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping dbus-broker.service - D-Bus System Message Bus...
Sep 25 02:28:47 host01.example.net dbus-broker[894]: Dispatched 1418 messages @ 3(±10)μs / message.
Sep 25 02:28:47 host01.example.net systemd[1]: sshd-vsock.socket: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Closed sshd-vsock.socket - OpenSSH Server Socket (systemd-ssh-generator, AF_VSOCK).
Sep 25 02:28:47 host01.example.net systemd[1]: dbus-broker.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped dbus-broker.service - D-Bus System Message Bus.
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dbus-broker comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: dbus.socket: Deactivated successfully.
Sep 25 02:28:47 host01.example.net audit: BPF prog-id=57 op=UNLOAD
Sep 25 02:28:47 host01.example.net systemd[1]: Closed dbus.socket - D-Bus System Message Bus Socket.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target sysinit.target - System Initialization.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target cryptsetup.target - Local Encrypted Volumes.
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-ask-password-console.path: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-ask-password-wall.path: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target imports.target - Image Downloads.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target integritysetup.target - Local Integrity Protected Volumes.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped target veritysetup.target - Local Verity Protected Volumes.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping systemd-binfmt.service - Set Up Additional Binary Formats...
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping systemd-resolved.service - Network Name Resolution...
Sep 25 02:28:47 host01.example.net systemd[1]: Stopping systemd-update-utmp.service - Record System Boot/Shutdown in UTMP...
Sep 25 02:28:47 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-resolved comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-resolved.service: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Stopped systemd-resolved.service - Network Name Resolution.
Sep 25 02:28:47 host01.example.net systemd[1]: systemd-resolved-monitor.socket: Deactivated successfully.
Sep 25 02:28:47 host01.example.net systemd[1]: Closed systemd-resolved-monitor.socket - Resolve Monitor Varlink Socket.
Sep 25 02:28:47 host01.example.net audit[1094]: AUDIT1128 pid=1094 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg=' comm="systemd-update-utmp" exe="/usr/lib/systemd/systemd-update-utmp" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:48 host01.example.net systemd[1]: systemd-resolved-varlink.socket: Deactivated successfully.
Sep 25 02:28:48 host01.example.net systemd[1]: Closed systemd-resolved-varlink.socket - Resolve Service Varlink Socket.
Sep 25 02:28:48 host01.example.net systemd[1]: systemd-sysctl.service: Deactivated successfully.
Sep 25 02:28:48 host01.example.net audit: BPF prog-id=51 op=UNLOAD
Sep 25 02:28:48 host01.example.net systemd[1]: Stopped systemd-sysctl.service - Apply Kernel Variables.
Sep 25 02:28:48 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:48 host01.example.net systemd[1]: systemd-coredump.socket: Deactivated successfully.
Sep 25 02:28:48 host01.example.net systemd[1]: Closed systemd-coredump.socket - Process Core Dump Socket.
Sep 25 02:28:48 host01.example.net systemd[1]: systemd-modules-load.service: Deactivated successfully.
Sep 25 02:28:48 host01.example.net systemd[1]: Stopped systemd-modules-load.service - Load Kernel Modules.
Sep 25 02:28:48 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:48 host01.example.net systemd[1]: systemd-binfmt.service: Deactivated successfully.
Sep 25 02:28:48 host01.example.net systemd[1]: Stopped systemd-binfmt.service - Set Up Additional Binary Formats.
Sep 25 02:28:48 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-binfmt comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:48 host01.example.net systemd[1]: systemd-update-utmp.service: Deactivated successfully.
Sep 25 02:28:48 host01.example.net systemd[1]: Stopped systemd-update-utmp.service - Record System Boot/Shutdown in UTMP.
Sep 25 02:28:48 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-update-utmp comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:48 host01.example.net systemd[1]: proc-sys-fs-binfmt_misc.automount: Deactivated successfully.
Sep 25 02:28:48 host01.example.net systemd[1]: Unset automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
Sep 25 02:28:48 host01.example.net systemd[1]: Stopping auditd.service - Security Audit Logging Service...
Sep 25 02:28:48 host01.example.net systemd[1]: proc-sys-fs-binfmt_misc.mount: Deactivated successfully.
Sep 25 02:28:48 host01.example.net auditd[844]: The audit daemon is exiting.
Sep 25 02:28:48 host01.example.net audit: CONFIG_CHANGE op=set audit_pid=0 old=844 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
Sep 25 02:28:48 host01.example.net systemd[1]: auditd.service: Deactivated successfully.
Sep 25 02:28:48 host01.example.net systemd[1]: Stopped auditd.service - Security Audit Logging Service.
Sep 25 02:28:48 host01.example.net kernel: kauditd_printk_skb: 27 callbacks suppressed
Sep 25 02:28:48 host01.example.net kernel: audit: type=1305 audit(1790303328.046:120): op=set audit_pid=0 old=844 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
Sep 25 02:28:48 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=auditd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:48 host01.example.net systemd[1]: systemd-tmpfiles-setup.service: Deactivated successfully.
Sep 25 02:28:48 host01.example.net kernel: audit: type=1131 audit(1790303328.051:121): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=auditd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:48 host01.example.net systemd[1]: Stopped systemd-tmpfiles-setup.service - Create System Files and Directories.
Sep 25 02:28:48 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:48 host01.example.net systemd[1]: Stopped target local-fs.target - Local File Systems.
Sep 25 02:28:48 host01.example.net kernel: audit: type=1131 audit(1790303328.056:122): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:48 host01.example.net systemd[1]: Unmounting boot-efi.mount - /boot/efi...
Sep 25 02:28:48 host01.example.net systemd[1]: Unmounting home.mount - /home...
Sep 25 02:28:48 host01.example.net systemd[1]: Unmounting tmp.mount - Temporary Directory /tmp...
Sep 25 02:28:48 host01.example.net systemd[1]: Stopping systemd-journal-flush.service - Flush Journal to Persistent Storage...
Sep 25 02:28:48 host01.example.net systemd[1]: home.mount: Deactivated successfully.
Sep 25 02:28:48 host01.example.net systemd[1]: Unmounted home.mount - /home.
Sep 25 02:28:53 localhost kernel: Linux version 6.19.10-300.fc44.x86_64 (mockbuild@00000000000000000000000000000000) (gcc (GCC) 16.0.1 20260321 (Red Hat 16.0.1-0), GNU ld version 2.46-1.fc44) #1 SMP PREEMPT_DYNAMIC Wed Mar 25 18:23:49 UTC 2026
Sep 25 02:28:53 localhost kernel: Command line: BOOT_IMAGE=(hd0,gpt3)/boot/vmlinuz-6.19.10-300.fc44.x86_64 no_timer_check console=tty1 console=ttyS0,115200n8 systemd.firstboot=off root=UUID=00000000-0000-0000-0000-000000000000 rootflags=subvol=root
Sep 25 02:28:53 localhost kernel: BIOS-provided physical RAM map:
Sep 25 02:28:53 localhost kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
Sep 25 02:28:53 localhost kernel: BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
Sep 25 02:28:53 localhost kernel: BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
Sep 25 02:28:53 localhost kernel: BIOS-e820: [mem 0x0000000000100000-0x000000007ffd5fff] usable
Sep 25 02:28:53 localhost kernel: BIOS-e820: [mem 0x000000007ffd6000-0x000000007fffffff] reserved
Sep 25 02:28:53 localhost kernel: BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
Sep 25 02:28:53 localhost kernel: BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
Sep 25 02:28:53 localhost kernel: BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
Sep 25 02:28:53 localhost kernel: BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
Sep 25 02:28:53 localhost kernel: NX (Execute Disable) protection: active
Sep 25 02:28:53 localhost kernel: APIC: Static calls initialized
Sep 25 02:28:53 localhost kernel: SMBIOS 3.0.0 present.
Sep 25 02:28:53 localhost kernel: DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Sep 25 02:28:53 localhost kernel: DMI: Memory slots populated: 1/1
Sep 25 02:28:53 localhost kernel: Hypervisor detected: KVM
Sep 25 02:28:53 localhost kernel: last_pfn = 0x7ffd6 max_arch_pfn = 0x10000000000
Sep 25 02:28:53 localhost kernel: kvm-clock: Using msrs 4b564d01 and 4b564d00
Sep 25 02:28:53 localhost kernel: kvm-clock: using sched offset of 79622457171 cycles
Sep 25 02:28:53 localhost kernel: clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
Sep 25 02:28:53 localhost kernel: tsc: Detected 2299.998 MHz processor
Sep 25 02:28:53 localhost kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Sep 25 02:28:53 localhost kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Sep 25 02:28:53 localhost kernel: last_pfn = 0x7ffd6 max_arch_pfn = 0x10000000000
Sep 25 02:28:53 localhost kernel: MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
Sep 25 02:28:53 localhost kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
Sep 25 02:28:53 localhost kernel: found SMP MP-table at [mem 0x000f5460-0x000f546f]
Sep 25 02:28:53 localhost kernel: Using GB pages for direct mapping
Sep 25 02:28:53 localhost kernel: RAMDISK: [mem 0x321da000-0x350e4fff]
Sep 25 02:28:53 localhost kernel: ACPI: Early table checksum verification disabled
Sep 25 02:28:53 localhost kernel: ACPI: RSDP 0x00000000000F52A0 000014 (v00 BOCHS )
Sep 25 02:28:53 localhost kernel: ACPI: RSDT 0x000000007FFE239C 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
Sep 25 02:28:53 localhost kernel: ACPI: FACP 0x000000007FFE218C 0000F4 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
Sep 25 02:28:53 localhost kernel: ACPI: DSDT 0x000000007FFE0040 00214C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
Sep 25 02:28:53 localhost kernel: ACPI: FACS 0x000000007FFE0000 000040
Sep 25 02:28:53 localhost kernel: ACPI: APIC 0x000000007FFE2280 000080 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
Sep 25 02:28:53 localhost kernel: ACPI: HPET 0x000000007FFE2300 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
Sep 25 02:28:53 localhost kernel: ACPI: MCFG 0x000000007FFE2338 00003C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
Sep 25 02:28:53 localhost kernel: ACPI: WAET 0x000000007FFE2374 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
Sep 25 02:28:53 localhost kernel: ACPI: Reserving FACP table memory at [mem 0x7ffe218c-0x7ffe227f]
Sep 25 02:28:53 localhost kernel: ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe218b]
Sep 25 02:28:53 localhost kernel: ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe003f]
Sep 25 02:28:53 localhost kernel: ACPI: Reserving APIC table memory at [mem 0x7ffe2280-0x7ffe22ff]
Sep 25 02:28:53 localhost kernel: ACPI: Reserving HPET table memory at [mem 0x7ffe2300-0x7ffe2337]
Sep 25 02:28:53 localhost kernel: ACPI: Reserving MCFG table memory at [mem 0x7ffe2338-0x7ffe2373]
Sep 25 02:28:53 localhost kernel: ACPI: Reserving WAET table memory at [mem 0x7ffe2374-0x7ffe239b]
Sep 25 02:28:53 localhost kernel: No NUMA configuration found
Sep 25 02:28:53 localhost kernel: Faking a node at [mem 0x0000000000000000-0x000000007ffd5fff]
Sep 25 02:28:53 localhost kernel: NODE_DATA(0) allocated [mem 0x7ffab280-0x7ffd5fff]
Sep 25 02:28:53 localhost kernel: Zone ranges:
Sep 25 02:28:53 localhost kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Sep 25 02:28:53 localhost kernel:   DMA32    [mem 0x0000000001000000-0x000000007ffd5fff]
Sep 25 02:28:53 localhost kernel:   Normal   empty
Sep 25 02:28:53 localhost kernel:   Device   empty
Sep 25 02:28:53 localhost kernel: Movable zone start for each node
Sep 25 02:28:53 localhost kernel: Early memory node ranges
Sep 25 02:28:53 localhost kernel:   node   0: [mem 0x0000000000001000-0x000000000009efff]
Sep 25 02:28:53 localhost kernel:   node   0: [mem 0x0000000000100000-0x000000007ffd5fff]
Sep 25 02:28:53 localhost kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffd5fff]
Sep 25 02:28:53 localhost kernel: On node 0, zone DMA: 1 pages in unavailable ranges
Sep 25 02:28:53 localhost kernel: On node 0, zone DMA: 97 pages in unavailable ranges
Sep 25 02:28:53 localhost kernel: On node 0, zone DMA32: 42 pages in unavailable ranges
Sep 25 02:28:53 localhost kernel: ACPI: PM-Timer IO Port: 0x608
Sep 25 02:28:53 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Sep 25 02:28:53 localhost kernel: IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
Sep 25 02:28:53 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Sep 25 02:28:53 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
Sep 25 02:28:53 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Sep 25 02:28:53 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
Sep 25 02:28:53 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
Sep 25 02:28:53 localhost kernel: ACPI: Using ACPI (MADT) for SMP configuration information
Sep 25 02:28:53 localhost kernel: ACPI: HPET id: 0x8086a201 base: 0xfed00000
Sep 25 02:28:53 localhost kernel: TSC deadline timer available
Sep 25 02:28:53 localhost kernel: CPU topo: Max. logical packages:   1
Sep 25 02:28:53 localhost kernel: CPU topo: Max. logical nodes:      1
Sep 25 02:28:53 localhost kernel: CPU topo: Num. nodes per package:  1
Sep 25 02:28:53 localhost kernel: CPU topo: Max. logical dies:       1
Sep 25 02:28:53 localhost kernel: CPU topo: Max. dies per package:   1
Sep 25 02:28:53 localhost kernel: CPU topo: Max. threads per core:   1
Sep 25 02:28:53 localhost kernel: CPU topo: Num. cores per package:     2
Sep 25 02:28:53 localhost kernel: CPU topo: Num. threads per package:   2
Sep 25 02:28:53 localhost kernel: CPU topo: Allowing 2 present CPUs plus 0 hotplug CPUs
Sep 25 02:28:53 localhost kernel: kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
Sep 25 02:28:53 localhost kernel: kvm-guest: KVM setup pv remote TLB flush
Sep 25 02:28:53 localhost kernel: kvm-guest: setup PV sched yield
Sep 25 02:28:53 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
Sep 25 02:28:53 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
Sep 25 02:28:53 localhost kernel: [mem 0xc0000000-0xfed1bfff] available for PCI devices
Sep 25 02:28:53 localhost kernel: Booting paravirtualized kernel on KVM
Sep 25 02:28:53 localhost kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
Sep 25 02:28:53 localhost kernel: setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
Sep 25 02:28:53 localhost kernel: percpu: Embedded 84 pages/cpu s221184 r8192 d114688 u1048576
Sep 25 02:28:53 localhost kernel: pcpu-alloc: s221184 r8192 d114688 u1048576 alloc=1*2097152
Sep 25 02:28:53 localhost kernel: pcpu-alloc: [0] 0 1 
Sep 25 02:28:53 localhost kernel: kvm-guest: PV spinlocks enabled
Sep 25 02:28:53 localhost kernel: PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
Sep 25 02:28:53 localhost kernel: Kernel command line: BOOT_IMAGE=(hd0,gpt3)/boot/vmlinuz-6.19.10-300.fc44.x86_64 no_timer_check console=tty1 console=ttyS0,115200n8 systemd.firstboot=off root=UUID=00000000-0000-0000-0000-000000000000 rootflags=subvol=root
Sep 25 02:28:53 localhost kernel: random: crng init done
Sep 25 02:28:53 localhost kernel: printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes
Sep 25 02:28:53 localhost kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
Sep 25 02:28:53 localhost kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
Sep 25 02:28:53 localhost kernel: Fallback order for Node 0: 0 
Sep 25 02:28:53 localhost kernel: Built 1 zonelists, mobility grouping on.  Total pages: 524148
Sep 25 02:28:53 localhost kernel: Policy zone: DMA32
Sep 25 02:28:53 localhost kernel: mem auto-init: stack:all(zero), heap alloc:on, heap free:off
Sep 25 02:28:53 localhost kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Sep 25 02:28:53 localhost kernel: ftrace: allocating 63430 entries in 248 pages
Sep 25 02:28:53 localhost kernel: ftrace: allocated 248 pages with 5 groups
Sep 25 02:28:53 localhost kernel: Dynamic Preempt: lazy
Sep 25 02:28:53 localhost kernel: rcu: Preemptible hierarchical RCU implementation.
Sep 25 02:28:53 localhost kernel: rcu:         RCU event tracing is enabled.
Sep 25 02:28:53 localhost kernel: rcu:         RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
Sep 25 02:28:53 localhost kernel:         Trampoline variant of Tasks RCU enabled.
Sep 25 02:28:53 localhost kernel:         Rude variant of Tasks RCU enabled.
Sep 25 02:28:53 localhost kernel:         Tracing variant of Tasks RCU enabled.
Sep 25 02:28:53 localhost kernel: rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
Sep 25 02:28:53 localhost kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
Sep 25 02:28:53 localhost kernel: RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
Sep 25 02:28:53 localhost kernel: RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
Sep 25 02:28:53 localhost kernel: RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
Sep 25 02:28:53 localhost kernel: NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16
Sep 25 02:28:53 localhost kernel: rcu: srcu_init: Setting srcu_struct sizes based on contention.
Sep 25 02:28:53 localhost kernel: kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
Sep 25 02:28:53 localhost kernel: Console: colour VGA+ 80x25
Sep 25 02:28:53 localhost kernel: printk: legacy console [tty1] enabled
Sep 25 02:28:53 localhost kernel: printk: legacy console [ttyS0] enabled
Sep 25 02:28:53 localhost kernel: ACPI: Core revision 20250807
Sep 25 02:28:53 localhost kernel: clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
Sep 25 02:28:53 localhost kernel: APIC: Switch to symmetric I/O mode setup
Sep 25 02:28:53 localhost kernel: x2apic enabled
Sep 25 02:28:53 localhost kernel: APIC: Switched APIC routing to: physical x2apic
Sep 25 02:28:53 localhost kernel: kvm-guest: APIC: send_IPI_mask() replaced with kvm_send_ipi_mask()
Sep 25 02:28:53 localhost kernel: kvm-guest: APIC: send_IPI_mask_allbutself() replaced with kvm_send_ipi_mask_allbutself()
Sep 25 02:28:53 localhost kernel: kvm-guest: setup PV IPIs
Sep 25 02:28:53 localhost kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Sep 25 02:28:53 localhost kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x212733415c7, max_idle_ns: 440795236380 ns
Sep 25 02:28:53 localhost kernel: Calibrating delay loop (skipped) preset value.. 4599.99 BogoMIPS (lpj=2299998)
Sep 25 02:28:53 localhost kernel: x86/cpu: User Mode Instruction Prevention (UMIP) activated
Sep 25 02:28:53 localhost kernel: Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Sep 25 02:28:53 localhost kernel: Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Sep 25 02:28:53 localhost kernel: mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
Sep 25 02:28:53 localhost kernel: Speculative Store Bypass: Vulnerable
Sep 25 02:28:53 localhost kernel: Spectre V2 : Mitigation: Retpolines
Sep 25 02:28:53 localhost kernel: RETBleed: Vulnerable
Sep 25 02:28:53 localhost kernel: ITS: Mitigation: Aligned branch/return thunks
Sep 25 02:28:53 localhost kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Sep 25 02:28:53 localhost kernel: Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT
Sep 25 02:28:53 localhost kernel: active return thunk: its_return_thunk
Sep 25 02:28:53 localhost kernel: XFEATURE_XTILE_DATA: calculated size is 0 bytes, cpu state 8192 bytes
Sep 25 02:28:53 localhost kernel: CPUID[0d, 00]: eax=000600e7 ebx=00002b00 ecx=00002b00 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 01]: eax=0000001f ebx=000029c0 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 02]: eax=00000100 ebx=00000240 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 03]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 04]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 05]: eax=00000040 ebx=00000440 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 06]: eax=00000200 ebx=00000480 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 07]: eax=00000400 ebx=00000680 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 08]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 09]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 0a]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 0b]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 0c]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 0d]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 0e]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 0f]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 10]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 11]: eax=00000040 ebx=00000ac0 ecx=00000002 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 12]: eax=00002000 ebx=00000b00 ecx=00000006 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 13]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 14]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 15]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 16]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 17]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 18]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 19]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 1a]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 1b]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 1c]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: CPUID[0d, 1d]: eax=00000000 ebx=00000000 ecx=00000000 edx=00000000
Sep 25 02:28:53 localhost kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
Sep 25 02:28:53 localhost kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
Sep 25 02:28:53 localhost kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
Sep 25 02:28:53 localhost kernel: x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
Sep 25 02:28:53 localhost kernel: x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
Sep 25 02:28:53 localhost kernel: x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
Sep 25 02:28:53 localhost kernel: x86/fpu: Supporting XSAVE feature 0x20000: 'AMX Tile config'
Sep 25 02:28:53 localhost kernel: x86/fpu: Supporting XSAVE feature 0x40000: 'AMX Tile data'
Sep 25 02:28:53 localhost kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
Sep 25 02:28:53 localhost kernel: x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
Sep 25 02:28:53 localhost kernel: x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
Sep 25 02:28:53 localhost kernel: x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
Sep 25 02:28:53 localhost kernel: x86/fpu: xstate_offset[17]: 2432, xstate_sizes[17]:   64
Sep 25 02:28:53 localhost kernel: x86/fpu: xstate_offset[18]: 2496, xstate_sizes[18]: 8192
Sep 25 02:28:53 localhost kernel: x86/fpu: Enabled xstate features 0x600e7, context size is 10688 bytes, using 'compacted' format.
Sep 25 02:28:53 localhost kernel: Freeing SMP alternatives memory: 56K
Sep 25 02:28:53 localhost kernel: pid_max: default: 32768 minimum: 301
Sep 25 02:28:53 localhost kernel: Yama: becoming mindful.
Sep 25 02:28:53 localhost kernel: SELinux:  Initializing.
Sep 25 02:28:53 localhost kernel: LSM support for eBPF active
Sep 25 02:28:53 localhost kernel: landlock: Up and running.
Sep 25 02:28:53 localhost kernel: Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Sep 25 02:28:53 localhost kernel: Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Sep 25 02:28:53 localhost kernel: smpboot: CPU0: Intel INTEL(R) XEON(R) PLATINUM 8573C (family: 0x6, model: 0xcf, stepping: 0x2)
Sep 25 02:28:53 localhost kernel: Performance Events: unsupported CPU family 6 model 207 no PMU driver, software events only.
Sep 25 02:28:53 localhost kernel: signal: max sigframe size: 11952
Sep 25 02:28:53 localhost kernel: rcu: Hierarchical SRCU implementation.
Sep 25 02:28:53 localhost kernel: rcu:         Max phase no-delay instances is 400.
Sep 25 02:28:53 localhost kernel: Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
Sep 25 02:28:53 localhost kernel: NMI watchdog: Perf NMI watchdog permanently disabled
Sep 25 02:28:53 localhost kernel: smp: Bringing up secondary CPUs ...
Sep 25 02:28:53 localhost kernel: smpboot: x86: Booting SMP configuration:
Sep 25 02:28:53 localhost kernel: .... node  #0, CPUs:      #1
Sep 25 02:28:53 localhost kernel: smp: Brought up 1 node, 2 CPUs
Sep 25 02:28:53 localhost kernel: smpboot: Total of 2 processors activated (9199.99 BogoMIPS)
Sep 25 02:28:53 localhost kernel: Memory: 1936716K/2096592K available (23756K kernel code, 4589K rwdata, 17844K rodata, 5204K init, 4736K bss, 153436K reserved, 0K cma-reserved)
Sep 25 02:28:53 localhost kernel: devtmpfs: initialized
Sep 25 02:28:53 localhost kernel: x86/mm: Memory block size: 128MB
Sep 25 02:28:53 localhost kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
Sep 25 02:28:53 localhost kernel: posixtimers hash table entries: 1024 (order: 2, 16384 bytes, linear)
Sep 25 02:28:53 localhost kernel: futex hash table entries: 512 (32768 bytes on 1 NUMA nodes, total 32 KiB, linear).
Sep 25 02:28:53 localhost kernel: PM: RTC time: 02:28:51, date: 2026-09-25
Sep 25 02:28:53 localhost kernel: NET: Registered PF_NETLINK/PF_ROUTE protocol family
Sep 25 02:28:53 localhost kernel: DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
Sep 25 02:28:53 localhost kernel: DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
Sep 25 02:28:53 localhost kernel: audit: initializing netlink subsys (disabled)
Sep 25 02:28:53 localhost kernel: audit: type=2000 audit(1790303331.563:1): state=initialized audit_enabled=0 res=1
Sep 25 02:28:53 localhost kernel: thermal_sys: Registered thermal governor 'fair_share'
Sep 25 02:28:53 localhost kernel: thermal_sys: Registered thermal governor 'bang_bang'
Sep 25 02:28:53 localhost kernel: thermal_sys: Registered thermal governor 'step_wise'
Sep 25 02:28:53 localhost kernel: thermal_sys: Registered thermal governor 'user_space'
Sep 25 02:28:53 localhost kernel: cpuidle: using governor menu
Sep 25 02:28:53 localhost kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Sep 25 02:28:53 localhost kernel: PCI: ECAM [mem 0xb0000000-0xbfffffff] (base 0xb0000000) for domain 0000 [bus 00-ff]
Sep 25 02:28:53 localhost kernel: PCI: ECAM [mem 0xb0000000-0xbfffffff] reserved as E820 entry
Sep 25 02:28:53 localhost kernel: PCI: Using configuration type 1 for base access
Sep 25 02:28:53 localhost kernel: kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
Sep 25 02:28:53 localhost kernel: HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
Sep 25 02:28:53 localhost kernel: HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
Sep 25 02:28:53 localhost kernel: HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
Sep 25 02:28:53 localhost kernel: HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
Sep 25 02:28:53 localhost kernel: raid6: skipped pq benchmark and selected avx512x4
Sep 25 02:28:53 localhost kernel: raid6: using avx512x2 recovery algorithm
Sep 25 02:28:53 localhost kernel: ACPI: Added _OSI(Module Device)
Sep 25 02:28:53 localhost kernel: ACPI: Added _OSI(Processor Device)
Sep 25 02:28:53 localhost kernel: ACPI: Added _OSI(Processor Aggregator Device)
Sep 25 02:28:53 localhost kernel: ACPI: 1 ACPI AML tables successfully acquired and loaded
Sep 25 02:28:53 localhost kernel: ACPI: Interpreter enabled
Sep 25 02:28:53 localhost kernel: ACPI: PM: (supports S0 S3 S4 S5)
Sep 25 02:28:53 localhost kernel: ACPI: Using IOAPIC for interrupt routing
Sep 25 02:28:53 localhost kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Sep 25 02:28:53 localhost kernel: PCI: Using E820 reservations for host bridge windows
Sep 25 02:28:53 localhost kernel: ACPI: Enabled 2 GPEs in block 00 to 3F
Sep 25 02:28:53 localhost kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Sep 25 02:28:53 localhost kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
Sep 25 02:28:53 localhost kernel: acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug LTR DPC]
Sep 25 02:28:53 localhost kernel: acpi PNP0A08:00: _OSC: OS now controls [SHPCHotplug PME AER PCIeCapability]
Sep 25 02:28:53 localhost kernel: PCI host bridge to bus 0000:00
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x80000000-0xafffffff window]
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x100000000-0x8ffffffff window]
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
Sep 25 02:28:53 localhost kernel: pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000 conventional PCI endpoint
Sep 25 02:28:53 localhost kernel: pci 0000:00:01.0: [1234:1111] type 00 class 0x030000 conventional PCI endpoint
Sep 25 02:28:53 localhost kernel: pci 0000:00:01.0: BAR 0 [mem 0xfd000000-0xfdffffff pref]
Sep 25 02:28:53 localhost kernel: pci 0000:00:01.0: BAR 2 [mem 0xfeb90000-0xfeb90fff]
Sep 25 02:28:53 localhost kernel: pci 0000:00:01.0: ROM [mem 0xfeb80000-0xfeb8ffff pref]
Sep 25 02:28:53 localhost kernel: pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Sep 25 02:28:53 localhost kernel: pci 0000:00:02.0: [1af4:1001] type 00 class 0x010000 conventional PCI endpoint
Sep 25 02:28:53 localhost kernel: pci 0000:00:02.0: BAR 0 [io  0xc000-0xc07f]
Sep 25 02:28:53 localhost kernel: pci 0000:00:02.0: BAR 1 [mem 0xfeb91000-0xfeb91fff]
Sep 25 02:28:53 localhost kernel: pci 0000:00:02.0: BAR 4 [mem 0xfe000000-0xfe003fff 64bit pref]
Sep 25 02:28:53 localhost kernel: pci 0000:00:03.0: [1af4:1001] type 00 class 0x010000 conventional PCI endpoint
Sep 25 02:28:53 localhost kernel: pci 0000:00:03.0: BAR 0 [io  0xc080-0xc0ff]
Sep 25 02:28:53 localhost kernel: pci 0000:00:03.0: BAR 1 [mem 0xfeb92000-0xfeb92fff]
Sep 25 02:28:53 localhost kernel: pci 0000:00:03.0: BAR 4 [mem 0xfe004000-0xfe007fff 64bit pref]
Sep 25 02:28:53 localhost kernel: pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000 conventional PCI endpoint
Sep 25 02:28:53 localhost kernel: pci 0000:00:04.0: BAR 0 [io  0xc1c0-0xc1df]
Sep 25 02:28:53 localhost kernel: pci 0000:00:04.0: BAR 1 [mem 0xfeb93000-0xfeb93fff]
Sep 25 02:28:53 localhost kernel: pci 0000:00:04.0: BAR 4 [mem 0xfe008000-0xfe00bfff 64bit pref]
Sep 25 02:28:53 localhost kernel: pci 0000:00:04.0: ROM [mem 0xfeb00000-0xfeb7ffff pref]
Sep 25 02:28:53 localhost kernel: pci 0000:00:05.0: [1af4:1001] type 00 class 0x010000 conventional PCI endpoint
Sep 25 02:28:53 localhost kernel: pci 0000:00:05.0: BAR 0 [io  0xc100-0xc17f]
Sep 25 02:28:53 localhost kernel: pci 0000:00:05.0: BAR 1 [mem 0xfeb94000-0xfeb94fff]
Sep 25 02:28:53 localhost kernel: pci 0000:00:05.0: BAR 4 [mem 0xfe00c000-0xfe00ffff 64bit pref]
Sep 25 02:28:53 localhost kernel: pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100 conventional PCI endpoint
Sep 25 02:28:53 localhost kernel: pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6 ACPI/GPIO/TCO
Sep 25 02:28:53 localhost kernel: pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601 conventional PCI endpoint
Sep 25 02:28:53 localhost kernel: pci 0000:00:1f.2: BAR 4 [io  0xc1e0-0xc1ff]
Sep 25 02:28:53 localhost kernel: pci 0000:00:1f.2: BAR 5 [mem 0xfeb95000-0xfeb95fff]
Sep 25 02:28:53 localhost kernel: pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500 conventional PCI endpoint
Sep 25 02:28:53 localhost kernel: pci 0000:00:1f.3: BAR 4 [io  0x0700-0x073f]
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link LNKA configured for IRQ 10
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link LNKB configured for IRQ 10
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link LNKC configured for IRQ 11
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link LNKD configured for IRQ 11
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link LNKE configured for IRQ 10
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link LNKF configured for IRQ 10
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link LNKG configured for IRQ 11
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link LNKH configured for IRQ 11
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link GSIA configured for IRQ 16
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link GSIB configured for IRQ 17
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link GSIC configured for IRQ 18
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link GSID configured for IRQ 19
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link GSIE configured for IRQ 20
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link GSIF configured for IRQ 21
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link GSIG configured for IRQ 22
Sep 25 02:28:53 localhost kernel: ACPI: PCI: Interrupt link GSIH configured for IRQ 23
Sep 25 02:28:53 localhost kernel: iommu: Default domain type: Translated
Sep 25 02:28:53 localhost kernel: iommu: DMA domain TLB invalidation policy: lazy mode
Sep 25 02:28:53 localhost kernel: SCSI subsystem initialized
Sep 25 02:28:53 localhost kernel: libata version 3.00 loaded.
Sep 25 02:28:53 localhost kernel: ACPI: bus type USB registered
Sep 25 02:28:53 localhost kernel: usbcore: registered new interface driver usbfs
Sep 25 02:28:53 localhost kernel: usbcore: registered new interface driver hub
Sep 25 02:28:53 localhost kernel: usbcore: registered new device driver usb
Sep 25 02:28:53 localhost kernel: pps_core: LinuxPPS API ver. 1 registered
Sep 25 02:28:53 localhost kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
Sep 25 02:28:53 localhost kernel: PTP clock support registered
Sep 25 02:28:53 localhost kernel: EDAC MC: Ver: 3.0.0
Sep 25 02:28:53 localhost kernel: NetLabel: Initializing
Sep 25 02:28:53 localhost kernel: NetLabel:  domain hash size = 128
Sep 25 02:28:53 localhost kernel: NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
Sep 25 02:28:53 localhost kernel: NetLabel:  unlabeled traffic allowed by default
Sep 25 02:28:53 localhost kernel: mctp: management component transport protocol core
Sep 25 02:28:53 localhost kernel: NET: Registered PF_MCTP protocol family
Sep 25 02:28:53 localhost kernel: PCI: Using ACPI for IRQ routing
Sep 25 02:28:53 localhost kernel: PCI: pci_cache_line_size set to 64 bytes
Sep 25 02:28:53 localhost kernel: e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
Sep 25 02:28:53 localhost kernel: e820: reserve RAM buffer [mem 0x7ffd6000-0x7fffffff]
Sep 25 02:28:53 localhost kernel: pci 0000:00:01.0: vgaarb: setting as boot VGA device
Sep 25 02:28:53 localhost kernel: pci 0000:00:01.0: vgaarb: bridge control possible
Sep 25 02:28:53 localhost kernel: pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
Sep 25 02:28:53 localhost kernel: vgaarb: loaded
Sep 25 02:28:53 localhost kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Sep 25 02:28:53 localhost kernel: hpet0: 3 comparators, 64-bit 100.000000 MHz counter
Sep 25 02:28:53 localhost kernel: clocksource: Switched to clocksource kvm-clock
Sep 25 02:28:53 localhost kernel: VFS: Disk quotas dquot_6.6.0
Sep 25 02:28:53 localhost kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Sep 25 02:28:53 localhost kernel: pnp: PnP ACPI init
Sep 25 02:28:53 localhost kernel: system 00:05: [mem 0xb0000000-0xbfffffff window] has been reserved
Sep 25 02:28:53 localhost kernel: pnp: PnP ACPI: found 6 devices
Sep 25 02:28:53 localhost kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Sep 25 02:28:53 localhost kernel: NET: Registered PF_INET protocol family
Sep 25 02:28:53 localhost kernel: IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
Sep 25 02:28:53 localhost kernel: tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
Sep 25 02:28:53 localhost kernel: Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
Sep 25 02:28:53 localhost kernel: TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
Sep 25 02:28:53 localhost kernel: TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
Sep 25 02:28:53 localhost kernel: TCP: Hash tables configured (established 16384 bind 16384)
Sep 25 02:28:53 localhost kernel: MPTCP token hash table entries: 2048 (order: 4, 49152 bytes, linear)
Sep 25 02:28:53 localhost kernel: UDP hash table entries: 1024 (order: 4, 65536 bytes, linear)
Sep 25 02:28:53 localhost kernel: UDP-Lite hash table entries: 1024 (order: 4, 65536 bytes, linear)
Sep 25 02:28:53 localhost kernel: NET: Registered PF_UNIX/PF_LOCAL protocol family
Sep 25 02:28:53 localhost kernel: NET: Registered PF_XDP protocol family
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: resource 7 [mem 0x80000000-0xafffffff window]
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: resource 8 [mem 0xc0000000-0xfebfffff window]
Sep 25 02:28:53 localhost kernel: pci_bus 0000:00: resource 9 [mem 0x100000000-0x8ffffffff window]
Sep 25 02:28:53 localhost kernel: PCI: CLS 0 bytes, default 64
Sep 25 02:28:53 localhost kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x212733415c7, max_idle_ns: 440795236380 ns
Sep 25 02:28:53 localhost kernel: Trying to unpack rootfs image as initramfs...
Sep 25 02:28:53 localhost kernel: Initialise system trusted keyrings
Sep 25 02:28:53 localhost kernel: Key type blacklist registered
Sep 25 02:28:53 localhost kernel: workingset: timestamp_bits=36 max_order=19 bucket_order=0
Sep 25 02:28:53 localhost kernel: integrity: Platform Keyring initialized
Sep 25 02:28:53 localhost kernel: integrity: Machine keyring initialized
Sep 25 02:28:53 localhost kernel: cryptd: max_cpu_qlen set to 1000
Sep 25 02:28:53 localhost kernel: NET: Registered PF_ALG protocol family
Sep 25 02:28:53 localhost kernel: xor: automatically using best checksumming function   avx       
Sep 25 02:28:53 localhost kernel: Key type asymmetric registered
Sep 25 02:28:53 localhost kernel: Asymmetric key parser 'x509' registered
Sep 25 02:28:53 localhost kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
Sep 25 02:28:53 localhost kernel: io scheduler mq-deadline registered
Sep 25 02:28:53 localhost kernel: io scheduler kyber registered
Sep 25 02:28:53 localhost kernel: io scheduler bfq registered
Sep 25 02:28:53 localhost kernel: atomic64_test: passed for x86-64 platform with CX8 and with SSE
Sep 25 02:28:53 localhost kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
Sep 25 02:28:53 localhost kernel: ACPI: button: Power Button [PWRF]
Sep 25 02:28:53 localhost kernel: ACPI: \_SB_.GSIG: Enabled at IRQ 22
Sep 25 02:28:53 localhost kernel: ACPI: \_SB_.GSIH: Enabled at IRQ 23
Sep 25 02:28:53 localhost kernel: ACPI: \_SB_.GSIE: Enabled at IRQ 20
Sep 25 02:28:53 localhost kernel: ACPI: \_SB_.GSIF: Enabled at IRQ 21
Sep 25 02:28:53 localhost kernel: Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
Sep 25 02:28:53 localhost kernel: 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
Sep 25 02:28:53 localhost kernel: Non-volatile memory driver v1.3
Sep 25 02:28:53 localhost kernel: Linux agpgart interface v0.103
Sep 25 02:28:53 localhost kernel: ACPI: bus type drm_connector registered
Sep 25 02:28:53 localhost kernel: virtio_blk virtio0: 2/0/0 default/read/poll queues
Sep 25 02:28:53 localhost kernel: virtio_blk virtio0: [vda] 41943040 512-byte logical blocks (21.5 GB/20.0 GiB)
Sep 25 02:28:53 localhost kernel:  vda: vda1 vda2 vda3
Sep 25 02:28:53 localhost kernel: virtio_blk virtio1: 2/0/0 default/read/poll queues
Sep 25 02:28:53 localhost kernel: virtio_blk virtio1: [vdb] 131072 512-byte logical blocks (67.1 MB/64.0 MiB)
Sep 25 02:28:53 localhost kernel: virtio_blk virtio3: 2/0/0 default/read/poll queues
Sep 25 02:28:53 localhost kernel: virtio_blk virtio3: [vdc] 736 512-byte logical blocks (377 kB/368 KiB)
Sep 25 02:28:53 localhost kernel: ACPI: \_SB_.GSIA: Enabled at IRQ 16
Sep 25 02:28:53 localhost kernel: ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
Sep 25 02:28:53 localhost kernel: ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
Sep 25 02:28:53 localhost kernel: ahci 0000:00:1f.2: flags: 64bit ncq only 
Sep 25 02:28:53 localhost kernel: scsi host0: ahci
Sep 25 02:28:53 localhost kernel: scsi host1: ahci
Sep 25 02:28:53 localhost kernel: scsi host2: ahci
Sep 25 02:28:53 localhost kernel: scsi host3: ahci
Sep 25 02:28:53 localhost kernel: scsi host4: ahci
Sep 25 02:28:53 localhost kernel: Freeing initrd memory: 48172K
Sep 25 02:28:53 localhost kernel: scsi host5: ahci
Sep 25 02:28:53 localhost kernel: ata1: SATA max UDMA/133 abar m4096@0xfeb95000 port 0xfeb95100 irq 33 lpm-pol 1
Sep 25 02:28:53 localhost kernel: ata2: SATA max UDMA/133 abar m4096@0xfeb95000 port 0xfeb95180 irq 33 lpm-pol 1
Sep 25 02:28:53 localhost kernel: ata3: SATA max UDMA/133 abar m4096@0xfeb95000 port 0xfeb95200 irq 33 lpm-pol 1
Sep 25 02:28:53 localhost kernel: ata4: SATA max UDMA/133 abar m4096@0xfeb95000 port 0xfeb95280 irq 33 lpm-pol 1
Sep 25 02:28:53 localhost kernel: ata5: SATA max UDMA/133 abar m4096@0xfeb95000 port 0xfeb95300 irq 33 lpm-pol 1
Sep 25 02:28:53 localhost kernel: ata6: SATA max UDMA/133 abar m4096@0xfeb95000 port 0xfeb95380 irq 33 lpm-pol 1
Sep 25 02:28:53 localhost kernel: CAN device driver interface
Sep 25 02:28:53 localhost kernel: usbcore: registered new interface driver usbserial_generic
Sep 25 02:28:53 localhost kernel: usbserial: USB Serial support registered for generic
Sep 25 02:28:53 localhost kernel: i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Sep 25 02:28:53 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 25 02:28:53 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 25 02:28:53 localhost kernel: mousedev: PS/2 mouse device common for all mice
Sep 25 02:28:53 localhost kernel: rtc_cmos 00:04: RTC can wake from S4
Sep 25 02:28:53 localhost kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
Sep 25 02:28:53 localhost kernel: rtc_cmos 00:04: registered as rtc0
Sep 25 02:28:53 localhost kernel: rtc_cmos 00:04: setting system clock to 2026-09-25T02:28:52 UTC (1790303332)
Sep 25 02:28:53 localhost kernel: input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
Sep 25 02:28:53 localhost kernel: rtc_cmos 00:04: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
Sep 25 02:28:53 localhost kernel: device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
Sep 25 02:28:53 localhost kernel: input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
Sep 25 02:28:53 localhost kernel: device-mapper: uevent: version 1.0.3
Sep 25 02:28:53 localhost kernel: device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
Sep 25 02:28:53 localhost kernel: intel_pstate: CPU model not supported
Sep 25 02:28:53 localhost kernel: hid: raw HID events driver (C) Jiri Kosina
Sep 25 02:28:53 localhost kernel: usbcore: registered new interface driver usbhid
Sep 25 02:28:53 localhost kernel: usbhid: USB HID core driver
Sep 25 02:28:53 localhost kernel: drop_monitor: Initializing network drop monitor service
Sep 25 02:28:53 localhost kernel: Initializing XFRM netlink socket
Sep 25 02:28:53 localhost kernel: NET: Registered PF_INET6 protocol family
Sep 25 02:28:53 localhost kernel: Segment Routing with IPv6
Sep 25 02:28:53 localhost kernel: RPL Segment Routing with IPv6
Sep 25 02:28:53 localhost kernel: In-situ OAM (IOAM) with IPv6
Sep 25 02:28:53 localhost kernel: mip6: Mobile IPv6
Sep 25 02:28:53 localhost kernel: NET: Registered PF_PACKET protocol family
Sep 25 02:28:53 localhost kernel: can: controller area network core
Sep 25 02:28:53 localhost kernel: NET: Registered PF_CAN protocol family
Sep 25 02:28:53 localhost kernel: IPI shorthand broadcast: enabled
Sep 25 02:28:53 localhost kernel: sched_clock: Marking stable (955008823, 275614185)->(1332139663, -101516655)
Sep 25 02:28:53 localhost kernel: registered taskstats version 1
Sep 25 02:28:53 localhost kernel: Loading compiled-in X.509 certificates
Sep 25 02:28:53 localhost kernel: Loaded X.509 cert 'Fedora kernel signing key: 7d9678ff2b91529062efdc8a18734284816e388f'
Sep 25 02:28:53 localhost kernel: Loaded X.509 cert 'Fedora IMA CA: a8a00c31663f853f9c6ff2564872e378af026b28'
Sep 25 02:28:53 localhost kernel: Demotion targets for Node 0: null
Sep 25 02:28:53 localhost kernel: page_owner is disabled
Sep 25 02:28:53 localhost kernel: Key type .fscrypt registered
Sep 25 02:28:53 localhost kernel: Key type fscrypt-provisioning registered
Sep 25 02:28:53 localhost kernel: Btrfs loaded, zoned=yes, fsverity=yes
Sep 25 02:28:53 localhost kernel: Key type big_key registered
Sep 25 02:28:53 localhost kernel: Key type encrypted registered
Sep 25 02:28:53 localhost kernel: ima: No TPM chip found, activating TPM-bypass!
Sep 25 02:28:53 localhost kernel: Loading compiled-in module X.509 certificates
Sep 25 02:28:53 localhost kernel: Loaded X.509 cert 'Fedora kernel signing key: 7d9678ff2b91529062efdc8a18734284816e388f'
Sep 25 02:28:53 localhost kernel: ima: Allocated hash algorithm: sha256
Sep 25 02:28:53 localhost kernel: ima: No architecture policies found
Sep 25 02:28:53 localhost kernel: evm: Initialising EVM extended attributes:
Sep 25 02:28:53 localhost kernel: evm: security.selinux
Sep 25 02:28:53 localhost kernel: evm: security.SMACK64 (disabled)
Sep 25 02:28:53 localhost kernel: evm: security.SMACK64EXEC (disabled)
Sep 25 02:28:53 localhost kernel: evm: security.SMACK64TRANSMUTE (disabled)
Sep 25 02:28:53 localhost kernel: evm: security.SMACK64MMAP (disabled)
Sep 25 02:28:53 localhost kernel: evm: security.apparmor (disabled)
Sep 25 02:28:53 localhost kernel: evm: security.ima
Sep 25 02:28:53 localhost kernel: evm: security.capability
Sep 25 02:28:53 localhost kernel: evm: HMAC attrs: 0x1
Sep 25 02:28:53 localhost kernel: alg: No test for 842 (842-scomp)
Sep 25 02:28:53 localhost kernel: PM:   Magic number: 10:34:461
Sep 25 02:28:53 localhost kernel: RAS: Correctable Errors collector initialized.
Sep 25 02:28:53 localhost kernel: clk: Disabling unused clocks
Sep 25 02:28:53 localhost kernel: PM: genpd: Disabling unused power domains
Sep 25 02:28:53 localhost kernel: ata1: SATA link down (SStatus 0 SControl 300)
Sep 25 02:28:53 localhost kernel: ata5: SATA link down (SStatus 0 SControl 300)
Sep 25 02:28:53 localhost kernel: ata4: SATA link down (SStatus 0 SControl 300)
Sep 25 02:28:53 localhost kernel: ata6: SATA link down (SStatus 0 SControl 300)
Sep 25 02:28:53 localhost kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Sep 25 02:28:53 localhost kernel: ata3.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
Sep 25 02:28:53 localhost kernel: ata3.00: applying bridge limits
Sep 25 02:28:53 localhost kernel: ata2: SATA link down (SStatus 0 SControl 300)
Sep 25 02:28:53 localhost kernel: ata3.00: configured for UDMA/100
Sep 25 02:28:53 localhost kernel: scsi 2001:db8::1 CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
Sep 25 02:28:53 localhost kernel: sr 2001:db8::1 [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
Sep 25 02:28:53 localhost kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
Sep 25 02:28:53 localhost kernel: sr 2001:db8::1 Attached scsi CD-ROM sr0
Sep 25 02:28:53 localhost kernel: sr 2001:db8::1 Attached scsi generic sg0 type 5
Sep 25 02:28:53 localhost kernel: Freeing unused decrypted memory: 2028K
Sep 25 02:28:53 localhost kernel: Freeing unused kernel image (initmem) memory: 5204K
Sep 25 02:28:53 localhost kernel: Write protecting the kernel read-only data: 43008k
Sep 25 02:28:53 localhost kernel: Freeing unused kernel image (text/rodata gap) memory: 816K
Sep 25 02:28:53 localhost kernel: Freeing unused kernel image (rodata/data gap) memory: 588K
Sep 25 02:28:53 localhost kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
Sep 25 02:28:53 localhost kernel: Run /init as init process
Sep 25 02:28:53 localhost kernel:   with arguments:
Sep 25 02:28:53 localhost kernel:     /init
Sep 25 02:28:53 localhost kernel:   with environment:
Sep 25 02:28:53 localhost kernel:     HOME=/
Sep 25 02:28:53 localhost kernel:     TERM=linux
Sep 25 02:28:53 localhost kernel: fuse: init (API version 7.45)
Sep 25 02:28:53 localhost systemd[1]: Successfully made /usr/ read-only.
Sep 25 02:28:53 localhost systemd[1]: systemd 259.5-1.fc44 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +IPE +SMACK +SECCOMP -GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP +SYSVINIT +LIBARCHIVE)
Sep 25 02:28:53 localhost systemd[1]: Detected virtualization kvm.
Sep 25 02:28:53 localhost systemd[1]: Detected architecture x86-64.
Sep 25 02:28:53 localhost systemd[1]: Running in initrd.
Sep 25 02:28:53 localhost systemd[1]: Initializing machine ID from random generator.
Sep 25 02:28:53 localhost systemd[1]: No hostname configured, using default hostname.
Sep 25 02:28:53 localhost systemd[1]: Hostname set to <localhost>.
Sep 25 02:28:53 localhost systemd[1]: bpf-restrict-fs: LSM BPF program attached
Sep 25 02:28:53 localhost systemd[1]: /usr/lib/systemd/system/systemd-udevd.service:56: System call bpf cannot be resolved as libseccomp is not available, ignoring: Operation not supported
Sep 25 02:28:53 localhost systemd[1]: Queued start job for default target initrd.target.
Sep 25 02:28:53 localhost systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
Sep 25 02:28:53 localhost systemd[1]: Expecting device dev-disk-by\x2duuid-15c26993\x2dac30\x2d424a\x2d9c4b\x2dfaec4434d234.device - /dev/disk/by-uuid/00000000-0000-0000-0000-000000000000...
Sep 25 02:28:53 localhost systemd[1]: Reached target initrd-usr-fs.target - Initrd /usr File System.
Sep 25 02:28:53 localhost systemd[1]: Reached target paths.target - Path Units.
Sep 25 02:28:53 localhost systemd[1]: Reached target slices.target - Slice Units.
Sep 25 02:28:53 localhost systemd[1]: Reached target swap.target - Swaps.
Sep 25 02:28:53 localhost systemd[1]: Reached target timers.target - Timer Units.
Sep 25 02:28:53 localhost systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
Sep 25 02:28:53 localhost systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
Sep 25 02:28:53 localhost systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
Sep 25 02:28:53 localhost systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
Sep 25 02:28:53 localhost systemd[1]: Reached target sockets.target - Socket Units.
Sep 25 02:28:53 localhost systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
Sep 25 02:28:53 localhost systemd[1]: memstrack.service - Memstrack Anylazing Service skipped, no trigger condition checks were met.
Sep 25 02:28:53 localhost systemd[1]: systemd-battery-check.service - Early Battery Level Check skipped, unmet condition check ConditionDirectoryNotEmpty=/sys/class/power_supply
Sep 25 02:28:53 localhost systemd[1]: Starting systemd-journald.service - Journal Service...
Sep 25 02:28:53 localhost systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
Sep 25 02:28:53 localhost systemd[1]: systemd-pcrphase-initrd.service - TPM PCR Barrier (initrd) skipped, unmet condition check ConditionSecurity=measured-uki
Sep 25 02:28:53 localhost systemd[1]: Reached target cryptsetup.target - Local Encrypted Volumes.
Sep 25 02:28:53 localhost systemd-journald[248]: Collecting audit messages is disabled.
Sep 25 02:28:53 localhost systemd[1]: Starting systemd-vconsole-setup.service - Virtual Console Setup...
Sep 25 02:28:53 localhost systemd-journald[248]: Journal started
Sep 25 02:28:53 localhost systemd-journald[248]: Runtime Journal (/run/log/journal/00000000000000000000000000000000) is 4.8M, max 39M, 34.1M free.
Sep 25 02:28:53 localhost systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
Sep 25 02:28:53 localhost systemd[1]: Started systemd-journald.service - Journal Service.
Sep 25 02:28:53 localhost systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
Sep 25 02:28:53 localhost systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
Sep 25 02:28:53 localhost systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
Sep 25 02:28:53 localhost systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
Sep 25 02:28:53 localhost systemd[1]: Finished systemd-vconsole-setup.service - Virtual Console Setup.
Sep 25 02:28:54 localhost systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
Sep 25 02:28:54 localhost systemd[1]: Starting dracut-cmdline-ask.service - dracut ask for additional cmdline parameters...
Sep 25 02:28:54 localhost systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
Sep 25 02:28:54 localhost systemd-tmpfiles[276]: Failed to parse ACL "default:group:tss:rwx", ignoring: Invalid argument
Sep 25 02:28:54 localhost systemd-tmpfiles[276]: Failed to parse ACL "default:group:tss:rwx", ignoring: Invalid argument
Sep 25 02:28:54 localhost systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
Sep 25 02:28:54 localhost systemd[1]: Reached target local-fs-pre.target - Preparation for Local File Systems.
Sep 25 02:28:54 localhost systemd[1]: Reached target local-fs.target - Local File Systems.
Sep 25 02:28:54 localhost systemd[1]: Starting systemd-tmpfiles-setup.service - Create System Files and Directories...
Sep 25 02:28:54 localhost systemd-tmpfiles[283]: /usr/lib/tmpfiles.d/tpm2-tss-fapi.conf:2: Failed to resolve user 'tss': Unknown user
Sep 25 02:28:54 localhost systemd-tmpfiles[283]: Failed to parse ACL "default:group:tss:rwx", ignoring: Invalid argument
Sep 25 02:28:54 localhost systemd-tmpfiles[283]: /usr/lib/tmpfiles.d/tpm2-tss-fapi.conf:4: Failed to resolve user 'tss': Unknown user
Sep 25 02:28:54 localhost systemd-tmpfiles[283]: Failed to parse ACL "default:group:tss:rwx", ignoring: Invalid argument
Sep 25 02:28:54 localhost systemd-tmpfiles[283]: /usr/lib/tmpfiles.d/tpm2-tss-fapi.conf:6: Failed to resolve group 'tss': Unknown group
Sep 25 02:28:54 localhost systemd-tmpfiles[283]: /usr/lib/tmpfiles.d/tpm2-tss-fapi.conf:7: Failed to resolve group 'tss': Unknown group
Sep 25 02:28:54 localhost systemd-tmpfiles[283]: /usr/lib/tmpfiles.d/var.conf:14: Duplicate line for path "/var/log", ignoring.
Sep 25 02:28:54 localhost systemd[1]: Finished dracut-cmdline-ask.service - dracut ask for additional cmdline parameters.
Sep 25 02:28:54 localhost systemd[1]: Starting dracut-cmdline.service - dracut cmdline hook...
Sep 25 02:28:54 localhost systemd[1]: Finished systemd-tmpfiles-setup.service - Create System Files and Directories.
Sep 25 02:28:54 localhost dracut-cmdline[292]: dracut-108-6.fc44
Sep 25 02:28:54 localhost dracut-cmdline[292]: Using kernel command line parameters:  rd.driver.pre=btrfs   BOOT_IMAGE=(hd0,gpt3)/boot/vmlinuz-6.19.10-300.fc44.x86_64 no_timer_check console=tty1 console=ttyS0,115200n8 systemd.firstboot=off root=UUID=00000000-0000-0000-0000-000000000000 rootflags=subvol=root
Sep 25 02:28:54 localhost systemd[1]: Finished dracut-cmdline.service - dracut cmdline hook.
Sep 25 02:28:54 localhost systemd[1]: Starting dracut-pre-udev.service - dracut pre-udev hook...
Sep 25 02:28:54 localhost systemd[1]: Finished dracut-pre-udev.service - dracut pre-udev hook.
Sep 25 02:28:54 localhost systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
Sep 25 02:28:54 localhost systemd-udevd[401]: Using default interface naming scheme 'v259'.
Sep 25 02:28:54 localhost systemd-udevd[401]: /usr/lib/udev/rules.d/60-tpm-udev.rules:3 Failed to resolve user 'tss', ignoring: Unknown user
Sep 25 02:28:54 localhost systemd-udevd[401]: /usr/lib/udev/rules.d/60-tpm-udev.rules:4 Failed to resolve group 'tss', ignoring: Unknown group
Sep 25 02:28:54 localhost systemd[1]: Started systemd-udevd.service - Rule-based Manager for Device Events and Files.
Sep 25 02:28:54 localhost systemd[1]: dracut-pre-trigger.service - dracut pre-trigger hook skipped, no trigger condition checks were met.
Sep 25 02:28:54 localhost systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
Sep 25 02:28:54 localhost systemd[1]: Finished systemd-udev-trigger.service - Coldplug All udev Devices.
Sep 25 02:28:54 localhost systemd[1]: Reached target sysinit.target - System Initialization.
Sep 25 02:28:54 localhost systemd[1]: Reached target basic.target - Basic System.
Sep 25 02:28:54 localhost systemd[1]: Starting dracut-initqueue.service - dracut initqueue hook...
Sep 25 02:28:54 localhost systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
Sep 25 02:28:54 localhost systemd[1]: modprobe@configfs.service - Load Kernel Module configfs skipped, unmet condition check ConditionKernelModuleLoaded=!configfs
Sep 25 02:28:54 localhost systemd[1]: Found device dev-disk-by\x2duuid-15c26993\x2dac30\x2d424a\x2d9c4b\x2dfaec4434d234.device - /dev/disk/by-uuid/00000000-0000-0000-0000-000000000000.
Sep 25 02:28:54 localhost systemd[1]: Reached target initrd-root-device.target - Initrd Root Device.
Sep 25 02:28:54 localhost systemd[1]: systemd-vconsole-setup.service: Deactivated successfully.
Sep 25 02:28:54 localhost systemd[1]: Stopped systemd-vconsole-setup.service - Virtual Console Setup.
Sep 25 02:28:54 localhost systemd[1]: Stopping systemd-vconsole-setup.service - Virtual Console Setup...
Sep 25 02:28:54 localhost systemd[1]: Starting systemd-vconsole-setup.service - Virtual Console Setup...
Sep 25 02:28:54 localhost systemd[1]: Finished dracut-initqueue.service - dracut initqueue hook.
Sep 25 02:28:54 localhost systemd[1]: Reached target remote-fs-pre.target - Preparation for Remote File Systems.
Sep 25 02:28:54 localhost systemd[1]: Reached target remote-cryptsetup.target - Remote Encrypted Volumes.
Sep 25 02:28:54 localhost systemd[1]: Reached target remote-fs.target - Remote File Systems.
Sep 25 02:28:54 localhost systemd[1]: Starting dracut-pre-mount.service - dracut pre-mount hook...
Sep 25 02:28:54 localhost systemd[1]: Finished dracut-pre-mount.service - dracut pre-mount hook.
Sep 25 02:28:54 localhost systemd[1]: Starting systemd-fsck-root.service - File System Check on /dev/disk/by-uuid/00000000-0000-0000-0000-000000000000...
Sep 25 02:28:54 localhost systemd[1]: Finished systemd-vconsole-setup.service - Virtual Console Setup.
Sep 25 02:28:54 localhost systemd[1]: Finished systemd-fsck-root.service - File System Check on /dev/disk/by-uuid/00000000-0000-0000-0000-000000000000.
Sep 25 02:28:54 localhost systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
Sep 25 02:28:54 localhost systemd[1]: Mounting sysroot.mount - /sysroot...
Sep 25 02:28:54 localhost systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
Sep 25 02:28:54 localhost kernel: BTRFS: device label fedora devid 1 transid 37 /dev/vda3 (253:3) scanned by mount (474)
Sep 25 02:28:54 localhost kernel: BTRFS info (device vda3): first mount of filesystem 00000000-0000-0000-0000-000000000000
Sep 25 02:28:54 localhost kernel: BTRFS info (device vda3): using crc32c (crc32c-lib) checksum algorithm
Sep 25 02:28:54 localhost kernel: BTRFS info (device vda3): turning on async discard
Sep 25 02:28:54 localhost kernel: BTRFS info (device vda3): enabling free space tree
Sep 25 02:28:54 localhost systemd[1]: Mounted sysroot.mount - /sysroot.
Sep 25 02:28:54 localhost systemd[1]: Reached target initrd-root-fs.target - Initrd Root File System.
Sep 25 02:28:54 localhost systemd[1]: Starting initrd-parse-etc.service - Mountpoints Configured in the Real Root...
Sep 25 02:28:54 localhost systemd[1]: initrd-parse-etc.service: Deactivated successfully.
Sep 25 02:28:54 localhost systemd[1]: Finished initrd-parse-etc.service - Mountpoints Configured in the Real Root.
Sep 25 02:28:54 localhost systemd[1]: initrd-parse-etc.service: Triggering OnSuccess= dependencies.
Sep 25 02:28:54 localhost systemd[1]: Reached target initrd-fs.target - Initrd File Systems.
Sep 25 02:28:54 localhost systemd[1]: Reached target initrd.target - Initrd Default Target.
Sep 25 02:28:54 localhost systemd[1]: dracut-mount.service - dracut mount hook skipped, no trigger condition checks were met.
Sep 25 02:28:54 localhost systemd[1]: Starting dracut-pre-pivot.service - dracut pre-pivot and cleanup hook...
Sep 25 02:28:54 localhost systemd[1]: Finished dracut-pre-pivot.service - dracut pre-pivot and cleanup hook.
Sep 25 02:28:54 localhost systemd[1]: Starting initrd-cleanup.service - Cleaning Up and Shutting Down Daemons...
Sep 25 02:28:54 localhost systemd[1]: Stopped target remote-cryptsetup.target - Remote Encrypted Volumes.
Sep 25 02:28:54 localhost systemd[1]: Stopped target timers.target - Timer Units.
Sep 25 02:28:54 localhost systemd[1]: dracut-pre-pivot.service: Deactivated successfully.
Sep 25 02:28:54 localhost systemd[1]: Stopped dracut-pre-pivot.service - dracut pre-pivot and cleanup hook.
Sep 25 02:28:54 localhost systemd[1]: Stopped target initrd.target - Initrd Default Target.
Sep 25 02:28:54 localhost systemd[1]: Stopped target basic.target - Basic System.
Sep 25 02:28:54 localhost systemd[1]: Stopped target initrd-root-device.target - Initrd Root Device.
Sep 25 02:28:54 localhost systemd[1]: Stopped target initrd-usr-fs.target - Initrd /usr File System.
Sep 25 02:28:54 localhost systemd[1]: Stopped target paths.target - Path Units.
Sep 25 02:28:54 localhost systemd[1]: Stopped target remote-fs.target - Remote File Systems.
Sep 25 02:28:54 localhost systemd[1]: Stopped target remote-fs-pre.target - Preparation for Remote File Systems.
Sep 25 02:28:55 localhost systemd[1]: Stopped target slices.target - Slice Units.
Sep 25 02:28:55 localhost systemd[1]: Stopped target sockets.target - Socket Units.
Sep 25 02:28:55 localhost systemd[1]: Stopped target sysinit.target - System Initialization.
Sep 25 02:28:55 localhost systemd[1]: Stopped target swap.target - Swaps.
Sep 25 02:28:55 localhost systemd[1]: dracut-pre-mount.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped dracut-pre-mount.service - dracut pre-mount hook.
Sep 25 02:28:55 localhost systemd[1]: Stopped target cryptsetup.target - Local Encrypted Volumes.
Sep 25 02:28:55 localhost systemd[1]: systemd-ask-password-console.path: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
Sep 25 02:28:55 localhost systemd[1]: dracut-initqueue.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped dracut-initqueue.service - dracut initqueue hook.
Sep 25 02:28:55 localhost systemd[1]: systemd-sysctl.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped systemd-sysctl.service - Apply Kernel Variables.
Sep 25 02:28:55 localhost systemd[1]: systemd-modules-load.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped systemd-modules-load.service - Load Kernel Modules.
Sep 25 02:28:55 localhost systemd[1]: systemd-tmpfiles-setup.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped systemd-tmpfiles-setup.service - Create System Files and Directories.
Sep 25 02:28:55 localhost systemd[1]: Stopped target local-fs.target - Local File Systems.
Sep 25 02:28:55 localhost systemd[1]: Stopped target local-fs-pre.target - Preparation for Local File Systems.
Sep 25 02:28:55 localhost systemd[1]: systemd-udev-trigger.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped systemd-udev-trigger.service - Coldplug All udev Devices.
Sep 25 02:28:55 localhost systemd[1]: Stopping systemd-udevd.service - Rule-based Manager for Device Events and Files...
Sep 25 02:28:55 localhost systemd[1]: initrd-cleanup.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Finished initrd-cleanup.service - Cleaning Up and Shutting Down Daemons.
Sep 25 02:28:55 localhost systemd[1]: systemd-udevd.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped systemd-udevd.service - Rule-based Manager for Device Events and Files.
Sep 25 02:28:55 localhost systemd[1]: systemd-udevd-control.socket: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Closed systemd-udevd-control.socket - udev Control Socket.
Sep 25 02:28:55 localhost systemd[1]: dracut-pre-udev.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped dracut-pre-udev.service - dracut pre-udev hook.
Sep 25 02:28:55 localhost systemd[1]: dracut-cmdline.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped dracut-cmdline.service - dracut cmdline hook.
Sep 25 02:28:55 localhost systemd[1]: dracut-cmdline-ask.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped dracut-cmdline-ask.service - dracut ask for additional cmdline parameters.
Sep 25 02:28:55 localhost systemd[1]: Starting initrd-udevadm-cleanup-db.service - Cleanup udev Database...
Sep 25 02:28:55 localhost systemd[1]: systemd-tmpfiles-setup-dev.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
Sep 25 02:28:55 localhost systemd[1]: systemd-tmpfiles-setup-dev-early.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
Sep 25 02:28:55 localhost systemd[1]: kmod-static-nodes.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped kmod-static-nodes.service - Create List of Static Device Nodes.
Sep 25 02:28:55 localhost systemd[1]: systemd-vconsole-setup.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Stopped systemd-vconsole-setup.service - Virtual Console Setup.
Sep 25 02:28:55 localhost systemd[1]: initrd-udevadm-cleanup-db.service: Deactivated successfully.
Sep 25 02:28:55 localhost systemd[1]: Finished initrd-udevadm-cleanup-db.service - Cleanup udev Database.
Sep 25 02:28:55 localhost systemd[1]: Reached target initrd-switch-root.target - Switch Root.
Sep 25 02:28:55 localhost systemd[1]: Starting initrd-switch-root.service - Switch Root...
Sep 25 02:28:55 localhost systemd[1]: Switching root.
Sep 25 02:28:55 localhost systemd-journald[248]: Journal stopped
Sep 25 02:28:56 host01.example.net systemd-journald[248]: Received SIGTERM from PID 1 (systemd).
Sep 25 02:28:56 host01.example.net kernel: audit: type=1404 audit(1790303335.372:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=selinux res=1
Sep 25 02:28:56 host01.example.net kernel: SELinux:  Permission firmware_load in class system not defined in policy.
Sep 25 02:28:56 host01.example.net kernel: SELinux:  Permission kexec_image_load in class system not defined in policy.
Sep 25 02:28:56 host01.example.net kernel: SELinux:  Permission kexec_initramfs_load in class system not defined in policy.
Sep 25 02:28:56 host01.example.net kernel: SELinux:  Permission policy_load in class system not defined in policy.
Sep 25 02:28:56 host01.example.net kernel: SELinux:  Permission x509_certificate_load in class system not defined in policy.
Sep 25 02:28:56 host01.example.net kernel: SELinux:  Permission allowed in class io_uring not defined in policy.
Sep 25 02:28:56 host01.example.net kernel: SELinux:  Class memfd_file not defined in policy.
Sep 25 02:28:56 host01.example.net kernel: SELinux: the above unknown classes and permissions will be allowed
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability network_peer_controls=1
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability open_perms=1
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability extended_socket_class=1
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability always_check_network=0
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability cgroup_seclabel=1
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability nnp_nosuid_transition=1
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability genfs_seclabel_symlinks=1
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability ioctl_skip_cloexec=0
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability userspace_initial_context=0
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability netlink_xperm=0
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability netif_wildcard=0
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability genfs_seclabel_wildcard=0
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability functionfs_seclabel=0
Sep 25 02:28:56 host01.example.net kernel: SELinux:  policy capability memfd_class=0
Sep 25 02:28:56 host01.example.net kernel: audit: type=1403 audit(1790303335.469:3): auid=4294967295 ses=4294967295 lsm=selinux res=1
Sep 25 02:28:56 host01.example.net systemd[1]: Successfully loaded SELinux policy in 99.016ms.
Sep 25 02:28:56 host01.example.net kernel: NET: Registered PF_VSOCK protocol family
Sep 25 02:28:56 host01.example.net systemd[1]: Relabeled /dev/, /dev/shm/, /run/ in 6.911ms.
Sep 25 02:28:56 host01.example.net systemd[1]: systemd 259.5-1.fc44 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +IPE +SMACK +SECCOMP -GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP +SYSVINIT +LIBARCHIVE)
Sep 25 02:28:56 host01.example.net systemd[1]: Detected virtualization kvm.
Sep 25 02:28:56 host01.example.net systemd[1]: Detected architecture x86-64.
Sep 25 02:28:56 host01.example.net systemd[1]: Hostname set to <host01.example.net>.
Sep 25 02:28:56 host01.example.net systemd[1]: bpf-restrict-fs: LSM BPF program attached
Sep 25 02:28:56 host01.example.net kernel: zram: Added device: zram0
Sep 25 02:28:56 host01.example.net systemd[1]: initrd-switch-root.service: Deactivated successfully.
Sep 25 02:28:56 host01.example.net systemd[1]: Stopped initrd-switch-root.service - Switch Root.
Sep 25 02:28:56 host01.example.net systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
Sep 25 02:28:56 host01.example.net systemd[1]: Created slice system-getty.slice - Slice /system/getty.
Sep 25 02:28:56 host01.example.net systemd[1]: Created slice system-serial\x2dgetty.slice - Slice /system/serial-getty.
Sep 25 02:28:56 host01.example.net systemd[1]: Created slice system-sshd\x2dkeygen.slice - Slice /system/sshd-keygen.
Sep 25 02:28:56 host01.example.net systemd[1]: Created slice system-systemd\x2dzram\x2dsetup.slice - Slice /system/systemd-zram-setup.
Sep 25 02:28:56 host01.example.net systemd[1]: Created slice user.slice - User and Session Slice.
Sep 25 02:28:56 host01.example.net systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
Sep 25 02:28:56 host01.example.net systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
Sep 25 02:28:56 host01.example.net systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
Sep 25 02:28:56 host01.example.net systemd[1]: Expecting device dev-disk-by\x2duuid-15c26993\x2dac30\x2d424a\x2d9c4b\x2dfaec4434d234.device - /dev/disk/by-uuid/00000000-0000-0000-0000-000000000000...
Sep 25 02:28:56 host01.example.net systemd[1]: Expecting device dev-disk-by\x2duuid-5BCC\x2d12A9.device - /dev/disk/by-uuid/5BCC-12A9...
Sep 25 02:28:56 host01.example.net systemd[1]: Expecting device dev-ttyS0.device - /dev/ttyS0...
Sep 25 02:28:56 host01.example.net systemd[1]: Expecting device dev-zram0.device - /dev/zram0...
Sep 25 02:28:56 host01.example.net systemd[1]: Reached target cryptsetup.target - Local Encrypted Volumes.
Sep 25 02:28:56 host01.example.net systemd[1]: Reached target imports.target - Image Downloads.
Sep 25 02:28:56 host01.example.net systemd[1]: Stopped target initrd-switch-root.target - Switch Root.
Sep 25 02:28:56 host01.example.net systemd[1]: Stopped target initrd-fs.target - Initrd File Systems.
Sep 25 02:28:56 host01.example.net systemd[1]: Stopped target initrd-root-fs.target - Initrd Root File System.
Sep 25 02:28:56 host01.example.net systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
Sep 25 02:28:56 host01.example.net systemd[1]: Reached target paths.target - Path Units.
Sep 25 02:28:56 host01.example.net systemd[1]: Reached target remote-cryptsetup.target - Remote Encrypted Volumes.
Sep 25 02:28:56 host01.example.net systemd[1]: Reached target remote-fs.target - Remote File Systems.
Sep 25 02:28:56 host01.example.net systemd[1]: Reached target remote-veritysetup.target - Remote Verity Protected Volumes.
Sep 25 02:28:56 host01.example.net systemd[1]: Reached target slices.target - Slice Units.
Sep 25 02:28:56 host01.example.net systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-ask-password.socket - Query the User Interactively for a Password.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-coredump.socket - Process Core Dump Socket.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-factory-reset.socket - Factory Reset Management.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-journald-audit.socket - Journal Audit Socket.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-mute-console.socket - Console Output Muting Service Socket.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-oomd.socket - Userspace Out-Of-Memory (OOM) Killer Socket.
Sep 25 02:28:56 host01.example.net systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements skipped, unmet condition check ConditionSecurity=measured-uki
Sep 25 02:28:56 host01.example.net systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy skipped, unmet condition check ConditionSecurity=measured-uki
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-repart.socket - Disk Repartitioning Service Socket.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-resolved-monitor.socket - Resolve Monitor Varlink Socket.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-resolved-varlink.socket - Resolve Service Varlink Socket.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-udevd-varlink.socket - udev Varlink Socket.
Sep 25 02:28:56 host01.example.net systemd[1]: Listening on systemd-userdbd.socket - User Database Manager Socket.
Sep 25 02:28:56 host01.example.net systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
Sep 25 02:28:56 host01.example.net systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
Sep 25 02:28:56 host01.example.net systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
Sep 25 02:28:56 host01.example.net systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
Sep 25 02:28:56 host01.example.net systemd[1]: fips-crypto-policy-overlay.service - Bind-mount FIPS crypto-policy in FIPS mode skipped, unmet condition check ConditionKernelCommandLine=fips=1
Sep 25 02:28:56 host01.example.net systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
Sep 25 02:28:56 host01.example.net systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
Sep 25 02:28:56 host01.example.net systemd[1]: modprobe@configfs.service - Load Kernel Module configfs skipped, unmet condition check ConditionKernelModuleLoaded=!configfs
Sep 25 02:28:56 host01.example.net systemd[1]: modprobe@drm.service - Load Kernel Module drm skipped, unmet condition check ConditionKernelModuleLoaded=!drm
Sep 25 02:28:56 host01.example.net systemd[1]: modprobe@efi_pstore.service - Load Kernel Module efi_pstore skipped, unmet condition check ConditionKernelModuleLoaded=!efi_pstore
Sep 25 02:28:56 host01.example.net systemd[1]: modprobe@fuse.service - Load Kernel Module fuse skipped, unmet condition check ConditionKernelModuleLoaded=!fuse
Sep 25 02:28:56 host01.example.net systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
Sep 25 02:28:56 host01.example.net systemd[1]: systemd-boot-clear-sysfail.service - Clear SysFail Entry If The Boot Is Successful skipped, unmet condition check ConditionPathExists=/sys/firmware/efi/efivars/LoaderEntrySysFail-00000000-0000-0000-0000-000000000000
Sep 25 02:28:56 host01.example.net systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info skipped, unmet condition check ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-00000000-0000-0000-0000-000000000000
Sep 25 02:28:56 host01.example.net systemd[1]: Starting systemd-journald.service - Journal Service...
Sep 25 02:28:56 host01.example.net systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
Sep 25 02:28:56 host01.example.net systemd[1]: Starting systemd-network-generator.service - Generate Network Units from Kernel Command Line...
Sep 25 02:28:56 host01.example.net systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
Sep 25 02:28:56 host01.example.net systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
Sep 25 02:28:56 host01.example.net systemd-journald[736]: Collecting audit messages is enabled.
Sep 25 02:28:56 host01.example.net systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup skipped, unmet condition check ConditionSecurity=measured-uki
Sep 25 02:28:56 host01.example.net systemd-journald[736]: Journal started
Sep 25 02:28:56 host01.example.net systemd-journald[736]: Runtime Journal (/run/log/journal/00000000000000000000000000000000) is 4.8M, max 39M, 34.1M free.
Sep 25 02:28:56 host01.example.net systemd[1]: Queued start job for default target multi-user.target.
Sep 25 02:28:56 host01.example.net systemd[1]: systemd-journald.service: Deactivated successfully.
Sep 25 02:28:56 host01.example.net systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
Sep 25 02:28:56 host01.example.net systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
Sep 25 02:28:56 host01.example.net kernel: BTRFS info (device vda3 state M): use zstd compression, level 1
Sep 25 02:28:56 host01.example.net systemd[1]: Started systemd-journald.service - Journal Service.
Sep 25 02:28:56 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
Sep 25 02:28:56 host01.example.net systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
Sep 25 02:28:56 host01.example.net systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
Sep 25 02:28:56 host01.example.net systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
Sep 25 02:28:56 host01.example.net systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
Sep 25 02:28:56 host01.example.net systemd[1]: Finished lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
Sep 25 02:28:56 host01.example.net systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
Sep 25 02:28:56 host01.example.net systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
Sep 25 02:28:56 host01.example.net systemd[1]: Finished systemd-network-generator.service - Generate Network Units from Kernel Command Line.
Sep 25 02:28:56 host01.example.net systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
Sep 25 02:28:56 host01.example.net systemd[1]: Finished systemd-udev-load-credentials.service - Load udev Rules from Credentials.
Sep 25 02:28:56 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net kernel: audit: type=1130 audit(1790303336.877:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net kernel: audit: type=1130 audit(1790303336.893:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=lvm2-monitor comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net kernel: audit: type=1130 audit(1790303336.896:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=lvm2-monitor comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database skipped, unmet condition check ConditionNeedsUpdate=/etc
Sep 25 02:28:56 host01.example.net kernel: audit: type=1130 audit(1790303336.900:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-network-generator comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net kernel: audit: type=1130 audit(1790303336.902:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-network-generator comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
Sep 25 02:28:56 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-remount-fs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-udev-load-credentials comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net kernel: audit: type=1130 audit(1790303336.904:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-remount-fs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net kernel: audit: type=1130 audit(1790303336.906:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-udev-load-credentials comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
Sep 25 02:28:56 host01.example.net systemd[1]: Finished systemd-udev-trigger.service - Coldplug All udev Devices.
Sep 25 02:28:56 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net kernel: audit: type=1130 audit(1790303336.951:11): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
Sep 25 02:28:56 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net systemd[1]: Starting systemd-userdbd.service - User Database Manager...
Sep 25 02:28:56 host01.example.net audit: BPF prog-id=48 op=LOAD
Sep 25 02:28:56 host01.example.net audit: BPF prog-id=49 op=LOAD
Sep 25 02:28:56 host01.example.net audit: BPF prog-id=50 op=LOAD
Sep 25 02:28:56 host01.example.net kernel: audit: type=1130 audit(1790303336.974:12): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:56 host01.example.net kernel: audit: type=1334 audit(1790303336.975:13): prog-id=48 op=LOAD
Sep 25 02:28:57 host01.example.net systemd[1]: Started systemd-userdbd.service - User Database Manager.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-userdbd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-tmpfiles-setup-dev-early comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-sysusers.service - Create System Users skipped, no trigger condition checks were met.
Sep 25 02:28:57 host01.example.net audit: BPF prog-id=51 op=LOAD
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-resolved.service - Network Name Resolution...
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
Sep 25 02:28:57 host01.example.net systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
Sep 25 02:28:57 host01.example.net systemd[1]: Reached target local-fs-pre.target - Preparation for Local File Systems.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-repart.service - Repartition Root Disk skipped, no trigger condition checks were met.
Sep 25 02:28:57 host01.example.net audit: BPF prog-id=23 op=UNLOAD
Sep 25 02:28:57 host01.example.net audit: BPF prog-id=22 op=UNLOAD
Sep 25 02:28:57 host01.example.net audit: BPF prog-id=52 op=LOAD
Sep 25 02:28:57 host01.example.net audit: BPF prog-id=53 op=LOAD
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
Sep 25 02:28:57 host01.example.net systemd-resolved[765]: Positive Trust Anchors:
Sep 25 02:28:57 host01.example.net systemd-resolved[765]: . IN DS 20326 8 2 e06d44b80b8f1d39a95c0b0d7c65d08458e880409bbc683457104237c7f8ec8d
Sep 25 02:28:57 host01.example.net systemd-resolved[765]: . IN DS 38696 8 2 683d2d0acb8c9b712a1948b27f741219298d0a450d612c483af444a4c0fb2b16
Sep 25 02:28:57 host01.example.net systemd-resolved[765]: Negative trust anchors: home.arpa 10.in-addr.arpa 16.172.in-addr.arpa 17.172.in-addr.arpa 18.172.in-addr.arpa 19.172.in-addr.arpa 20.172.in-addr.arpa 21.172.in-addr.arpa 22.172.in-addr.arpa 23.172.in-addr.arpa 24.172.in-addr.arpa 25.172.in-addr.arpa 26.172.in-addr.arpa 27.172.in-addr.arpa 28.172.in-addr.arpa 29.172.in-addr.arpa 30.172.in-addr.arpa 31.172.in-addr.arpa 170.0.0.192.in-addr.arpa 171.0.0.192.in-addr.arpa 168.192.in-addr.arpa d.f.ip6.arpa ipv4only.arpa resolver.arpa corp home internal intranet lan local private test
Sep 25 02:28:57 host01.example.net systemd-resolved[765]: Using system hostname 'host01.example.net'.
Sep 25 02:28:57 host01.example.net systemd[1]: Started systemd-resolved.service - Network Name Resolution.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-resolved comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd-udevd[769]: Using default interface naming scheme 'v259'.
Sep 25 02:28:57 host01.example.net systemd[1]: Reached target nss-lookup.target - Host and Network Name Lookups.
Sep 25 02:28:57 host01.example.net systemd[1]: Started systemd-udevd.service - Rule-based Manager for Device Events and Files.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: Found device dev-zram0.device - /dev/zram0.
Sep 25 02:28:57 host01.example.net systemd[1]: modprobe@configfs.service - Load Kernel Module configfs skipped, unmet condition check ConditionKernelModuleLoaded=!configfs
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-zram-setup@zram0.service - Create swap on /dev/zram0...
Sep 25 02:28:57 host01.example.net systemd[1]: modprobe@fuse.service - Load Kernel Module fuse skipped, unmet condition check ConditionKernelModuleLoaded=!fuse
Sep 25 02:28:57 host01.example.net kernel: zram0: detected capacity change from 0 to 3999744
Sep 25 02:28:57 host01.example.net systemd-makefs[787]: /dev/zram0 successfully formatted as swap (label "zram0", uuid 00000000-0000-0000-0000-000000000000)
Sep 25 02:28:57 host01.example.net systemd[1]: Finished systemd-zram-setup@zram0.service - Create swap on /dev/zram0.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-zram-setup@zram0 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: Activating swap dev-zram0.swap - Compressed Swap on /dev/zram0...
Sep 25 02:28:57 host01.example.net systemd[1]: Condition check resulted in dev-ttyS0.device - /dev/ttyS0 being skipped.
Sep 25 02:28:57 host01.example.net kernel: Adding 1999868k swap on /dev/zram0.  Priority:100 extents:1 across:1999868k SSDsc
Sep 25 02:28:57 host01.example.net systemd[1]: Activated swap dev-zram0.swap - Compressed Swap on /dev/zram0.
Sep 25 02:28:57 host01.example.net systemd[1]: Reached target swap.target - Swaps.
Sep 25 02:28:57 host01.example.net audit: BPF prog-id=54 op=LOAD
Sep 25 02:28:57 host01.example.net audit: BPF prog-id=55 op=LOAD
Sep 25 02:28:57 host01.example.net audit: BPF prog-id=56 op=LOAD
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-oomd.service - Userspace Out-Of-Memory (OOM) Killer...
Sep 25 02:28:57 host01.example.net systemd[1]: Condition check resulted in dev-disk-by\x2duuid-5BCC\x2d12A9.device - /dev/disk/by-uuid/5BCC-12A9 being skipped.
Sep 25 02:28:57 host01.example.net systemd[1]: Found device dev-disk-by\x2duuid-15c26993\x2dac30\x2d424a\x2d9c4b\x2dfaec4434d234.device - /dev/disk/by-uuid/00000000-0000-0000-0000-000000000000.
Sep 25 02:28:57 host01.example.net systemd[1]: Started systemd-oomd.service - Userspace Out-Of-Memory (OOM) Killer.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-oomd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net kernel: parport_pc 00:02: reported by Plug and Play ACPI
Sep 25 02:28:57 host01.example.net kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Sep 25 02:28:57 host01.example.net kernel: bochs-drm 0000:00:01.0: vgaarb: deactivate vga console
Sep 25 02:28:57 host01.example.net kernel: Console: switching to colour dummy device 80x25
Sep 25 02:28:57 host01.example.net kernel: [drm] Found bochs VGA, ID 0xb0c5.
Sep 25 02:28:57 host01.example.net kernel: [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfeb90000.
Sep 25 02:28:57 host01.example.net kernel: bochs-drm 0000:00:01.0: [drm] Registered 1 planes with drm panic
Sep 25 02:28:57 host01.example.net kernel: [drm] Initialized bochs-drm 1.0.0 for 0000:00:01.0 on minor 0
Sep 25 02:28:57 host01.example.net kernel: virtio_net virtio2 enp0s4: renamed from eth0
Sep 25 02:28:57 host01.example.net kernel: i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
Sep 25 02:28:57 host01.example.net kernel: i2c i2c-0: Memory type 0x07 not supported yet, not instantiating SPD
Sep 25 02:28:57 host01.example.net kernel: fbcon: bochs-drmdrmfb (fb0) is primary device
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-vconsole-setup.service - Virtual Console Setup...
Sep 25 02:28:57 host01.example.net kernel: Console: switching to colour frame buffer device 160x50
Sep 25 02:28:57 host01.example.net kernel: RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 10737418240 ms ovfl timer
Sep 25 02:28:57 host01.example.net kernel: RAPL PMU: hw unit of domain psys 2^-0 Joules
Sep 25 02:28:57 host01.example.net kernel: ppdev: user-space parallel port driver
Sep 25 02:28:57 host01.example.net kernel: bochs-drm 0000:00:01.0: [drm] fb0: bochs-drmdrmfb frame buffer device
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-vconsole-setup.service: Deactivated successfully.
Sep 25 02:28:57 host01.example.net systemd[1]: Stopped systemd-vconsole-setup.service - Virtual Console Setup.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-vconsole-setup.service - Virtual Console Setup...
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-vconsole-setup.service: Deactivated successfully.
Sep 25 02:28:57 host01.example.net systemd[1]: Stopped systemd-vconsole-setup.service - Virtual Console Setup.
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-vconsole-setup.service - Virtual Console Setup...
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: boot.mount: Directory /boot to mount over is not empty, mounting anyway.
Sep 25 02:28:57 host01.example.net systemd[1]: Mounting boot.mount - /boot...
Sep 25 02:28:57 host01.example.net systemd[1]: Mounting home.mount - /home...
Sep 25 02:28:57 host01.example.net systemd[1]: Mounting tmp.mount - Temporary Directory /tmp...
Sep 25 02:28:57 host01.example.net systemd[1]: Mounting var.mount - /var...
Sep 25 02:28:57 host01.example.net systemd[1]: Mounted boot.mount - /boot.
Sep 25 02:28:57 host01.example.net systemd[1]: Mounting boot-efi.mount - /boot/efi...
Sep 25 02:28:57 host01.example.net systemd[1]: Mounted home.mount - /home.
Sep 25 02:28:57 host01.example.net systemd[1]: Mounted tmp.mount - Temporary Directory /tmp.
Sep 25 02:28:57 host01.example.net systemd[1]: Mounted var.mount - /var.
Sep 25 02:28:57 host01.example.net systemd[1]: Starting cloud-init-main.service - Cloud-init: Single Process...
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-journal-flush.service - Flush Journal to Persistent Storage...
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-pcrproduct.service - TPM NvPCR Product ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-pstore.service - Platform Persistent Storage Archival skipped, unmet condition check ConditionDirectoryNotEmpty=/sys/fs/pstore
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-tpm2-setup.service - TPM SRK Setup skipped, unmet condition check ConditionSecurity=measured-uki
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-pcrnvdone.service - TPM PCR NvPCR Initialization Separator skipped, unmet condition check ConditionSecurity=measured-uki
Sep 25 02:28:57 host01.example.net systemd-journald[736]: Time spent on flushing to /var/log/journal/00000000000000000000000000000000 is 19.443ms for 922 entries.
Sep 25 02:28:57 host01.example.net systemd-journald[736]: System Journal (/var/log/journal/00000000000000000000000000000000) is 8M, max 1.9G, 1.9G free.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-random-seed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd-journald[736]: Received client request to flush runtime journal.
Sep 25 02:28:57 host01.example.net systemd[1]: Finished systemd-random-seed.service - Load/Save OS Random Seed.
Sep 25 02:28:57 host01.example.net systemd[1]: Finished systemd-vconsole-setup.service - Virtual Console Setup.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: Finished systemd-journal-flush.service - Flush Journal to Persistent Storage.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-journal-flush comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: Mounted boot-efi.mount - /boot/efi.
Sep 25 02:28:57 host01.example.net systemd[1]: Reached target local-fs.target - Local File Systems.
Sep 25 02:28:57 host01.example.net systemd[1]: Listening on systemd-bootctl.socket - Boot Entries Service Socket.
Sep 25 02:28:57 host01.example.net systemd[1]: Listening on systemd-sysext.socket - System Extension Image Management.
Sep 25 02:28:57 host01.example.net systemd[1]: selinux-autorelabel-mark.service - Mark the need to relabel after reboot skipped, unmet condition check ConditionSecurity=!selinux
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-binfmt.service - Set Up Additional Binary Formats...
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-boot-random-seed.service - Update Boot Loader Random Seed skipped, no trigger condition checks were met.
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-confext.service - Merge System Configuration Images into /etc/ skipped, no trigger condition checks were met.
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-sysext.service - Merge System Extension Images into /usr/ and /opt/ skipped, no trigger condition checks were met.
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-tmpfiles-setup.service - Create System Files and Directories...
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-userdb-load-credentials.service - Load JSON user/group Records from Credentials...
Sep 25 02:28:57 host01.example.net systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automount request for /proc/sys/fs/binfmt_misc, triggered by 832 (systemd-binfmt)
Sep 25 02:28:57 host01.example.net systemd[1]: Finished systemd-userdb-load-credentials.service - Load JSON user/group Records from Credentials.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-userdb-load-credentials comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: Finished systemd-tmpfiles-setup.service - Create System Files and Directories.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: Starting auditd.service - Security Audit Logging Service...
Sep 25 02:28:57 host01.example.net systemd[1]: ldconfig.service - Rebuild Dynamic Linker Cache skipped, no trigger condition checks were met.
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-firstboot.service - Initial Setup skipped, unmet condition check ConditionFirstBoot=yes
Sep 25 02:28:57 host01.example.net systemd[1]: first-boot-complete.target - First Boot Complete skipped, unmet condition check ConditionFirstBoot=yes
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-journal-catalog-update.service - Rebuild Journal Catalog skipped, unmet condition check ConditionNeedsUpdate=/var
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-machine-id-commit.service - Save Transient machine-id to Disk skipped, unmet condition check ConditionPathIsMountPoint=/etc/machine-id
Sep 25 02:28:57 host01.example.net systemd[1]: systemd-update-done.service - Update is Completed skipped, no trigger condition checks were met.
Sep 25 02:28:57 host01.example.net auditd[844]: No plugins found, not dispatching events
Sep 25 02:28:57 host01.example.net audit: CONFIG_CHANGE op=set audit_enabled=1 old=1 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
Sep 25 02:28:57 host01.example.net audit[844]: SYSCALL arch=c000003e syscall=44 success=yes exit=60 a0=3 a1=7ffec71431b0 a2=3c a3=0 items=0 ppid=843 pid=844 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="auditd" exe="/usr/bin/auditd" subj=system_u:system_r:auditd_t:s0 key=(null)
Sep 25 02:28:57 host01.example.net audit: PROCTITLE proctitle="/usr/bin/auditd"
Sep 25 02:28:57 host01.example.net audit: CONFIG_CHANGE op=set audit_pid=844 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
Sep 25 02:28:57 host01.example.net audit[844]: SYSCALL arch=c000003e syscall=44 success=yes exit=60 a0=3 a1=7ffec7140e70 a2=3c a3=0 items=0 ppid=843 pid=844 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="auditd" exe="/usr/bin/auditd" subj=system_u:system_r:auditd_t:s0 key=(null)
Sep 25 02:28:57 host01.example.net audit: PROCTITLE proctitle="/usr/bin/auditd"
Sep 25 02:28:57 host01.example.net auditd[844]: Init complete, auditd 4.1.4 listening for events (startup state enable)
Sep 25 02:28:57 host01.example.net systemd[1]: Started auditd.service - Security Audit Logging Service.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=auditd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: Starting audit-rules.service - Load Audit Rules...
Sep 25 02:28:57 host01.example.net systemd[1]: Starting systemd-update-utmp.service - Record System Boot/Shutdown in UTMP...
Sep 25 02:28:57 host01.example.net audit[849]: AUDIT1127 pid=849 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg=' comm="systemd-update-utmp" exe="/usr/lib/systemd/systemd-update-utmp" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net systemd[1]: Finished systemd-update-utmp.service - Record System Boot/Shutdown in UTMP.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-update-utmp comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net augenrules[848]: /usr/bin/augenrules: No change
Sep 25 02:28:57 host01.example.net audit: CONFIG_CHANGE auid=4294967295 ses=4294967295 subj=system_u:system_r:unconfined_service_t:s0 op=add_rule key=(null) list=1 res=1
Sep 25 02:28:57 host01.example.net audit[865]: SYSCALL arch=c000003e syscall=44 success=yes exit=1056 a0=3 a1=7ffd57aba1c0 a2=420 a3=0 items=0 ppid=848 pid=865 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="auditctl" exe="/usr/bin/auditctl" subj=system_u:system_r:unconfined_service_t:s0 key=(null)
Sep 25 02:28:57 host01.example.net audit: PROCTITLE proctitle=2F7573722F62696E2F617564697463746C002D52002F6574632F61756469742F61756469742E72756C6573
Sep 25 02:28:57 host01.example.net augenrules[865]: No rules
Sep 25 02:28:57 host01.example.net systemd[1]: audit-rules.service: Deactivated successfully.
Sep 25 02:28:57 host01.example.net systemd[1]: Finished audit-rules.service - Load Audit Rules.
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=audit-rules comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:57 host01.example.net audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=audit-rules comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net systemd[1]: Started cloud-init-main.service - Cloud-init: Single Process.
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=cloud-init-main comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net systemd[1]: Starting cloud-init-local.service - Cloud-init: Local Stage (pre-network)...
Sep 25 02:28:58 host01.example.net cloud-init[878]: Cloud-init v. 25.3 running 'init-local' at Fri, 25 Sep 2026 02:28:58 +0000. Up 6.70 seconds.
Sep 25 02:28:58 host01.example.net systemd[1]: Mounting proc-sys-fs-binfmt_misc.mount - Arbitrary Executable File Formats File System...
Sep 25 02:28:58 host01.example.net kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Sep 25 02:28:58 host01.example.net kernel: ISO 9660 Extensions: RRIP_1991A
Sep 25 02:28:58 host01.example.net systemd[1]: run-cloud\x2dinit-tmp-tmpdzegcmf8.mount: Deactivated successfully.
Sep 25 02:28:58 host01.example.net systemd[1]: Mounted proc-sys-fs-binfmt_misc.mount - Arbitrary Executable File Formats File System.
Sep 25 02:28:58 host01.example.net systemd[1]: Finished systemd-binfmt.service - Set Up Additional Binary Formats.
Sep 25 02:28:58 host01.example.net systemd[1]: Reached target sysinit.target - System Initialization.
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-binfmt comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net systemd[1]: Started dnf-makecache.timer - dnf5 makecache.
Sep 25 02:28:58 host01.example.net systemd[1]: Started fstrim.timer - Discard unused filesystem blocks once a week.
Sep 25 02:28:58 host01.example.net systemd[1]: Started systemd-tmpfiles-clean.timer - Daily Cleanup of Temporary Directories.
Sep 25 02:28:58 host01.example.net systemd[1]: Started unbound-anchor.timer - daily update of the root trust anchor for DNSSEC.
Sep 25 02:28:58 host01.example.net systemd[1]: Reached target timers.target - Timer Units.
Sep 25 02:28:58 host01.example.net systemd[1]: Listening on dbus.socket - D-Bus System Message Bus Socket.
Sep 25 02:28:58 host01.example.net systemd[1]: Listening on sshd-unix-local.socket - OpenSSH Server Socket (systemd-ssh-generator, AF_UNIX Local).
Sep 25 02:28:58 host01.example.net systemd[1]: Starting sshd-vsock.socket - OpenSSH Server Socket (systemd-ssh-generator, AF_VSOCK)...
Sep 25 02:28:58 host01.example.net systemd[1]: Listening on sssd-kcm.socket - SSSD Kerberos Cache Manager responder socket.
Sep 25 02:28:58 host01.example.net systemd[1]: Listening on systemd-hostnamed.socket - Hostname Service Socket.
Sep 25 02:28:58 host01.example.net systemd[1]: Listening on systemd-logind-varlink.socket - User Login Management Varlink Socket.
Sep 25 02:28:58 host01.example.net audit: BPF prog-id=57 op=LOAD
Sep 25 02:28:58 host01.example.net systemd[1]: Starting dbus-broker.service - D-Bus System Message Bus...
Sep 25 02:28:58 host01.example.net systemd[1]: rpmdb-rebuild.service - RPM database rebuild skipped, unmet condition check ConditionPathExists=/usr/lib/sysimage/rpm/.rebuilddb
Sep 25 02:28:58 host01.example.net systemd[1]: systemd-pcrphase-sysinit.service - TPM PCR Barrier (Initialization) skipped, unmet condition check ConditionSecurity=measured-uki
Sep 25 02:28:58 host01.example.net systemd[1]: Finished cloud-init-local.service - Cloud-init: Local Stage (pre-network).
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=cloud-init-local comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net systemd[1]: Listening on sshd-vsock.socket - OpenSSH Server Socket (systemd-ssh-generator, AF_VSOCK).
Sep 25 02:28:58 host01.example.net systemd[1]: Reached target network-pre.target - Preparation for Network.
Sep 25 02:28:58 host01.example.net systemd[1]: Reached target sockets.target - Socket Units.
Sep 25 02:28:58 host01.example.net systemd[1]: Reached target ssh-access.target - SSH Access Available.
Sep 25 02:28:58 host01.example.net systemd[1]: Started dbus-broker.service - D-Bus System Message Bus.
Sep 25 02:28:58 host01.example.net dbus-broker-launch[895]: Ready
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dbus-broker comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net systemd[1]: Reached target basic.target - Basic System.
Sep 25 02:28:58 host01.example.net systemd[1]: Starting NetworkManager.service - Network Manager...
Sep 25 02:28:58 host01.example.net systemd[1]: Starting authselect-apply-changes.service - Apply authselect changes...
Sep 25 02:28:58 host01.example.net audit: BPF prog-id=58 op=LOAD
Sep 25 02:28:58 host01.example.net systemd[1]: Starting chronyd.service - NTP client/server...
Sep 25 02:28:58 host01.example.net authselect[900]: Installed profiles did not change. No action is needed.
Sep 25 02:28:58 host01.example.net systemd[1]: Starting dracut-shutdown.service - Restore /run/initramfs on shutdown...
Sep 25 02:28:58 host01.example.net systemd[1]: ssh-host-keys-migration.service - Update OpenSSH host key permissions skipped, unmet condition check ConditionPathExists=!/var/lib/.ssh-host-keys-migration
Sep 25 02:28:58 host01.example.net systemd[1]: sshd-keygen@ecdsa.service - OpenSSH ecdsa Server Key Generation skipped, unmet condition check ConditionPathExists=!/run/systemd/generator.early/multi-user.target.wants/cloud-init.target
Sep 25 02:28:58 host01.example.net systemd[1]: sshd-keygen@ed25519.service - OpenSSH ed25519 Server Key Generation skipped, unmet condition check ConditionPathExists=!/run/systemd/generator.early/multi-user.target.wants/cloud-init.target
Sep 25 02:28:58 host01.example.net systemd[1]: sshd-keygen@rsa.service - OpenSSH rsa Server Key Generation skipped, unmet condition check ConditionPathExists=!/run/systemd/generator.early/multi-user.target.wants/cloud-init.target
Sep 25 02:28:58 host01.example.net systemd[1]: Reached target sshd-keygen.target.
Sep 25 02:28:58 host01.example.net systemd[1]: sssd.service - System Security Services Daemon skipped, no trigger condition checks were met.
Sep 25 02:28:58 host01.example.net audit: BPF prog-id=59 op=LOAD
Sep 25 02:28:58 host01.example.net systemd[1]: Starting systemd-homed.service - Home Area Manager...
Sep 25 02:28:58 host01.example.net systemd[1]: systemd-pcrphase.service - TPM PCR Barrier (User) skipped, unmet condition check ConditionSecurity=measured-uki
Sep 25 02:28:58 host01.example.net systemd[1]: Finished authselect-apply-changes.service - Apply authselect changes.
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=authselect-apply-changes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net systemd[1]: Finished dracut-shutdown.service - Restore /run/initramfs on shutdown.
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
Sep 25 02:28:58 host01.example.net audit: BPF prog-id=60 op=LOAD
Sep 25 02:28:58 host01.example.net audit: BPF prog-id=61 op=LOAD
Sep 25 02:28:58 host01.example.net audit: BPF prog-id=62 op=LOAD
Sep 25 02:28:58 host01.example.net systemd[1]: Starting systemd-logind.service - User Login Management...
Sep 25 02:28:58 host01.example.net systemd-homed[904]: Watching /home.
Sep 25 02:28:58 host01.example.net systemd[1]: Started systemd-homed.service - Home Area Manager.
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-homed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net systemd[1]: Finished systemd-homed-activate.service - Home Area Activation.
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-homed-activate comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net chronyd[901]: chronyd version 4.8 starting (+CMDMON +REFCLOCK +RTC +PRIVDROP +SCFILTER +SIGND +NTS +SECHASH +IPV6 +DEBUG)
Sep 25 02:28:58 host01.example.net chronyd[901]: Using leap second list /usr/share/zoneinfo/leap-seconds.list
Sep 25 02:28:58 host01.example.net chronyd[901]: Frequency 0.000 +/- 1000000.000 ppm read from /var/lib/chrony/drift
Sep 25 02:28:58 host01.example.net systemd[1]: Started chronyd.service - NTP client/server.
Sep 25 02:28:58 host01.example.net chronyd[901]: Loaded seccomp filter (level 2)
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=chronyd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.7937] NetworkManager (version 1.56.0-1.fc44) is starting... (boot:00000000-0000-0000-0000-000000000000)
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.7939] Read config: /etc/NetworkManager/NetworkManager.conf, /usr/lib/NetworkManager/conf.d/22-wifi-mac-addr.conf, /etc/NetworkManager/conf.d/30-cloud-init-ip6-addr-gen-mode.conf
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.7974] manager[0x56211552c7b0]: monitoring kernel firmware directory '/lib/firmware'.
Sep 25 02:28:58 host01.example.net systemd-logind[913]: New seat seat0.
Sep 25 02:28:58 host01.example.net systemd-logind[913]: Watching system buttons on /dev/input/event0 (Power Button)
Sep 25 02:28:58 host01.example.net systemd-logind[913]: Watching system buttons on /dev/input/event1 (AT Translated Set 2 keyboard)
Sep 25 02:28:58 host01.example.net audit: BPF prog-id=63 op=LOAD
Sep 25 02:28:58 host01.example.net audit: BPF prog-id=64 op=LOAD
Sep 25 02:28:58 host01.example.net audit: BPF prog-id=65 op=LOAD
Sep 25 02:28:58 host01.example.net systemd[1]: Starting systemd-hostnamed.service - Hostname Service...
Sep 25 02:28:58 host01.example.net systemd[1]: Started systemd-logind.service - User Login Management.
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-logind comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net systemd[1]: Started systemd-hostnamed.service - Hostname Service.
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8513] hostname: hostname: using hostnamed
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8513] hostname: static hostname changed from (none) to "host01.example.net"
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8539] dns-mgr: init: dns=systemd-resolved rc-manager=unmanaged (auto), plugin=systemd-resolved
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8559] manager: rfkill: Wi-Fi enabled by radio killswitch; enabled by state file
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8560] manager: rfkill: WWAN enabled by radio killswitch; enabled by state file
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8560] manager: Networking is enabled by state file
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8563] settings: Loaded settings plugin: keyfile (internal)
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8574] dhcp: init: Using DHCP client 'internal'
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8576] manager: (lo): new Loopback device (/org/freedesktop/NetworkManager/Devices/1)
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8583] device (lo): state change: unmanaged -> unavailable (reason 'connection-assumed', managed-type: 'external')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8584] device (lo): state change: unavailable -> disconnected (reason 'connection-assumed', managed-type: 'external')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8587] device (lo): Activation: starting connection 'lo' (00000000-0000-0000-0000-000000000000)
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8595] manager: (enp0s4): new Ethernet device (/org/freedesktop/NetworkManager/Devices/2)
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8597] device (enp0s4): state change: unmanaged -> unavailable (reason 'managed', managed-type: 'external')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8608] bus-manager: acquired D-Bus service "org.freedesktop.NetworkManager"
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8610] device (lo): state change: disconnected -> prepare (reason 'none', managed-type: 'external')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8611] device (lo): state change: prepare -> config (reason 'none', managed-type: 'external')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8612] device (lo): state change: config -> ip-config (reason 'none', managed-type: 'external')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8613] device (enp0s4): carrier: link connected
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8613] device (lo): state change: ip-config -> ip-check (reason 'none', managed-type: 'external')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8615] device (enp0s4): state change: unavailable -> disconnected (reason 'carrier-changed', managed-type: 'full')
Sep 25 02:28:58 host01.example.net systemd[1]: Started NetworkManager.service - Network Manager.
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8624] policy: auto-activating connection 'cloud-init enp0s4' (00000000-0000-0000-0000-000000000000)
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8626] device (enp0s4): Activation: starting connection 'cloud-init enp0s4' (00000000-0000-0000-0000-000000000000)
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8626] device (enp0s4): state change: disconnected -> prepare (reason 'none', managed-type: 'full')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8628] manager: NetworkManager state is now CONNECTING
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8629] device (enp0s4): state change: prepare -> config (reason 'none', managed-type: 'full')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8633] device (enp0s4): state change: config -> ip-config (reason 'none', managed-type: 'full')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8636] dhcp4 (enp0s4): activation: beginning transaction (timeout in 45 seconds)
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=NetworkManager comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8645] dhcp4 (enp0s4): state changed new lease, address=192.0.2.2, acd pending
Sep 25 02:28:58 host01.example.net systemd[1]: Reached target network.target - Network.
Sep 25 02:28:58 host01.example.net audit: BPF prog-id=66 op=LOAD
Sep 25 02:28:58 host01.example.net systemd[1]: Starting NetworkManager-dispatcher.service - Network Manager Script Dispatcher Service...
Sep 25 02:28:58 host01.example.net systemd[1]: Starting NetworkManager-wait-online.service - Network Manager Wait Online...
Sep 25 02:28:58 host01.example.net systemd[1]: Started NetworkManager-dispatcher.service - Network Manager Script Dispatcher Service.
Sep 25 02:28:58 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=NetworkManager-dispatcher comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8938] device (lo): state change: ip-check -> secondaries (reason 'none', managed-type: 'external')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8940] device (lo): state change: secondaries -> activated (reason 'none', managed-type: 'external')
Sep 25 02:28:58 host01.example.net NetworkManager[899]: <info>  [1790303338.8944] device (lo): Activation: successful, device activated.
Sep 25 02:28:59 host01.example.net NetworkManager[899]: <info>  [1790303339.0242] dhcp4 (enp0s4): state changed new lease, address=192.0.2.2
Sep 25 02:28:59 host01.example.net audit: BPF prog-id=67 op=LOAD
Sep 25 02:28:59 host01.example.net NetworkManager[899]: <info>  [1790303339.0253] policy: set 'cloud-init enp0s4' (enp0s4) as default for IPv4 routing and DNS
Sep 25 02:28:59 host01.example.net systemd-resolved[765]: enp0s4: Bus client set default route setting: yes
Sep 25 02:28:59 host01.example.net audit: BPF prog-id=66 op=UNLOAD
Sep 25 02:28:59 host01.example.net audit[765]: SYSCALL arch=c000003e syscall=286 success=yes exit=0 a0=b a1=1 a2=7ffe53769640 a3=0 items=0 ppid=1 pid=765 auid=4294967295 uid=193 gid=193 euid=193 suid=193 fsuid=193 egid=193 sgid=193 fsgid=193 tty=(none) ses=4294967295 comm="systemd-resolve" exe="/usr/lib/systemd/systemd-resolved" subj=system_u:system_r:systemd_resolved_t:s0 key=(null)
Sep 25 02:28:59 host01.example.net audit: PROCTITLE proctitle="/usr/lib/systemd/systemd-resolved"
Sep 25 02:28:59 host01.example.net systemd-resolved[765]: enp0s4: Bus client set DNS server list to: 192.0.2.3
Sep 25 02:28:59 host01.example.net NetworkManager[899]: <info>  [1790303339.0318] device (enp0s4): state change: ip-config -> ip-check (reason 'none', managed-type: 'full')
Sep 25 02:28:59 host01.example.net NetworkManager[899]: <info>  [1790303339.0338] device (enp0s4): state change: ip-check -> secondaries (reason 'none', managed-type: 'full')
Sep 25 02:28:59 host01.example.net NetworkManager[899]: <info>  [1790303339.0340] device (enp0s4): state change: secondaries -> activated (reason 'none', managed-type: 'full')
Sep 25 02:28:59 host01.example.net NetworkManager[899]: <info>  [1790303339.0342] manager: NetworkManager state is now CONNECTED_SITE
Sep 25 02:28:59 host01.example.net NetworkManager[899]: <info>  [1790303339.0344] device (enp0s4): Activation: successful, device activated.
Sep 25 02:28:59 host01.example.net NetworkManager[899]: <info>  [1790303339.0347] manager: NetworkManager state is now CONNECTED_GLOBAL
Sep 25 02:28:59 host01.example.net NetworkManager[899]: <info>  [1790303339.0348] manager: startup complete
Sep 25 02:28:59 host01.example.net systemd[1]: Finished NetworkManager-wait-online.service - Network Manager Wait Online.
Sep 25 02:28:59 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=NetworkManager-wait-online comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:59 host01.example.net systemd[1]: Starting cloud-init-network.service - Cloud-init: Network Stage...
Sep 25 02:28:59 host01.example.net cloud-init[878]: Cloud-init v. 25.3 running 'init' at Fri, 25 Sep 2026 02:28:59 +0000. Up 7.47 seconds.
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: ++++++++++++++++++++++++++++++++++++Net device info+++++++++++++++++++++++++++++++++++++
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: +--------+------+-------------------------+---------------+--------+-------------------+
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: | Device |  Up  |         Address         |      Mask     | Scope  |     Hw-Address    |
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: +--------+------+-------------------------+---------------+--------+-------------------+
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: | enp0s4 | True |        192.0.2.2        | 255.255.255.0 | global | 00:00:5e:00:53:04 |
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: | enp0s4 | True | 2001:db8::5/64 |       .       |  link  | 00:00:5e:00:53:04 |
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: |   lo   | True |        127.0.0.1        |   255.0.0.0   |  host  |         .         |
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: |   lo   | True |         ::1/128         |       .       |  host  |         .         |
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: +--------+------+-------------------------+---------------+--------+-------------------+
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: +++++++++++++++++++++++++++Route IPv4 info++++++++++++++++++++++++++++
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: +-------+-------------+----------+---------------+-----------+-------+
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: | Route | Destination | Gateway  |    Genmask    | Interface | Flags |
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: +-------+-------------+----------+---------------+-----------+-------+
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: |   0   |   0.0.0.0   | 192.0.2.6 |    0.0.0.0    |   enp0s4  |   UG  |
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: |   1   |   192.0.2.7  | 0.0.0.0  | 255.255.255.0 |   enp0s4  |   U   |
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: +-------+-------------+----------+---------------+-----------+-------+
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: +++++++++++++++++++Route IPv6 info+++++++++++++++++++
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: +-------+-------------+---------+-----------+-------+
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: | Route | Destination | Gateway | Interface | Flags |
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: +-------+-------------+---------+-----------+-------+
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: |   0   |  2001:db8::8/64  |    2001:db8::9   |   enp0s4  |   U   |
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: |   2   |  multicast  |    2001:db8::9   |   enp0s4  |   U   |
Sep 25 02:28:59 host01.example.net cloud-init[878]: ci-info: +-------+-------------+---------+-----------+-------+
Sep 25 02:28:59 host01.example.net systemd[1]: Finished cloud-init-network.service - Cloud-init: Network Stage.
Sep 25 02:28:59 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=cloud-init-network comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:59 host01.example.net systemd[1]: Reached target cloud-config.target - Cloud-config availability.
Sep 25 02:28:59 host01.example.net systemd[1]: Reached target network-online.target - Network is Online.
Sep 25 02:28:59 host01.example.net systemd[1]: Starting cloud-config.service - Cloud-init: Config Stage...
Sep 25 02:28:59 host01.example.net systemd[1]: Starting sshd.service - OpenSSH server daemon...
Sep 25 02:28:59 host01.example.net systemd[1]: Starting systemd-user-sessions.service - Permit User Sessions...
Sep 25 02:28:59 host01.example.net systemd[1]: Finished systemd-user-sessions.service - Permit User Sessions.
Sep 25 02:28:59 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-user-sessions comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:59 host01.example.net systemd[1]: Started getty@tty1.service - Getty on tty1.
Sep 25 02:28:59 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=getty@tty1 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:59 host01.example.net systemd[1]: Started serial-getty@ttyS0.service - Serial Getty on ttyS0.
Sep 25 02:28:59 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=serial-getty@ttyS0 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:59 host01.example.net systemd[1]: Reached target getty.target - Login Prompts.
Sep 25 02:28:59 host01.example.net sshd[1039]: Server listening on 0.0.0.0 port 22.
Sep 25 02:28:59 host01.example.net sshd[1039]: Server listening on 2001:db8::9 port 22.
Sep 25 02:28:59 host01.example.net systemd[1]: Started sshd.service - OpenSSH server daemon.
Sep 25 02:28:59 host01.example.net systemd[1]: Reached target multi-user.target - Multi-User System.
Sep 25 02:28:59 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=sshd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:59 host01.example.net cloud-init[878]: Cloud-init v. 25.3 running 'modules:config' at Fri, 25 Sep 2026 02:28:59 +0000. Up 7.68 seconds.
Sep 25 02:28:59 host01.example.net sh[1043]: Completed socket interaction for boot stage config
Sep 25 02:28:59 host01.example.net systemd[1]: Finished cloud-config.service - Cloud-init: Config Stage.
Sep 25 02:28:59 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=cloud-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:59 host01.example.net systemd[1]: Starting cloud-final.service - Cloud-init: Final Stage...
Sep 25 02:28:59 host01.example.net cloud-init[878]: Cloud-init v. 25.3 running 'modules:final' at Fri, 25 Sep 2026 02:28:59 +0000. Up 7.74 seconds.
Sep 25 02:28:59 host01.example.net cloud-init[878]: Cloud-init v. 25.3 finished at Fri, 25 Sep 2026 02:28:59 +0000. Datasource DataSourceNoCloud [seed=/dev/vdc].  Up 7.77 seconds
Sep 25 02:28:59 host01.example.net audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=cloud-final comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Sep 25 02:28:59 host01.example.net sh[1051]: Completed socket interaction for boot stage final
Sep 25 02:28:59 host01.example.net systemd[1]: Finished cloud-final.service - Cloud-init: Final Stage.
Sep 25 02:28:59 host01.example.net systemd[1]: Reached target cloud-init.target - Cloud-init target.
Sep 25 02:28:59 host01.example.net systemd[1]: Startup finished in 1.289s (kernel) + 2.478s (initrd) + 4.012s (userspace) = 7.780s.
