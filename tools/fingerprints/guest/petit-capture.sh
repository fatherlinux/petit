#!/bin/sh
# Runs inside the guest on every boot and drives a reboot capture:
#
#   boot 1  first boot. Settle, reboot, so the journal is persistent
#           and cloud-init's first-boot work is behind us.
#   boot 2  a steady-state boot. Settle, mark, and reboot: this reboot is
#           the one fingerprinted.
#   boot 3  mark, copy the logs of boots 2 and 3 to the disk whose serial
#           is petitout, and power off.
#
# The markers are logged under the tag petit-capture; refresh.py cuts the
# event out between them and drops every line that names this script.
set -u

state=/var/lib/petit-capture
mkdir -p "$state"
stage=$(cat "$state/stage" 2>/dev/null || echo 0)

settle() {
    if command -v systemctl >/dev/null 2>&1; then
        systemctl is-system-running --wait >/dev/null 2>&1 || :
    fi
    sleep "$1"
}

output_disk() {
    for dev in /sys/block/*; do
        if [ "$(cat "$dev/serial" 2>/dev/null)" = petitout ]; then
            echo "/dev/${dev##*/}"
            return 0
        fi
    done
    return 1
}

case "$stage" in
0)
    settle 20
    echo 1 >"$state/stage"
    sync
    reboot
    ;;
1)
    settle 30
    echo 2 >"$state/stage"
    logger -t petit-capture "rebooting"
    sync
    reboot
    ;;
2)
    settle 30
    logger -t petit-capture "capturing"
    sleep 2
    out=$(mktemp -d)
    if command -v journalctl >/dev/null 2>&1; then
        journalctl --flush >/dev/null 2>&1 || :
        journalctl -o short -b -1 --no-pager >"$out/previous.log"
        journalctl -o short -b 0 --no-pager >"$out/current.log"
    else
        cp /var/log/messages "$out/messages.log"
    fi
    uname -r >"$out/kernel"
    cp /etc/os-release "$out/os-release"
    echo 3 >"$state/stage"
    disk=$(output_disk) && tar -cf "$disk" -C "$out" .
    sync
    poweroff
    ;;
esac
