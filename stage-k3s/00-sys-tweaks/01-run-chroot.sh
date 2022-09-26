# Enabling legacy iptables on Raspberry Pi OS
update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

# Enabling cgroups for Raspberry Pi OS
sed -i -e 'cgroup_memory=1 cgroup_enable=memory' /boot/cmdline.txt 