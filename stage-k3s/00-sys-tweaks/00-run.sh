#!/bin/bash -e

# Install files
install -m 644 files/cmdline.txt "${ROOTFS_DIR}/boot/"
install -v -m 644 files/fstab "${ROOTFS_DIR}/etc/fstab"

# Enabling legacy iptables on Raspberry Pi OS
on_chroot << EOF
    update-alternatives --set iptables /usr/sbin/iptables-legacy
    update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
EOF