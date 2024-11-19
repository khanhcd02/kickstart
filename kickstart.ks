#version=DEVEL
# System authorization information
auth --useshadow --enablemd5
# Install OS instead of upgrade
install
# Use CDROM installation media
cdrom
# Use graphical install
graphical
# Firewall configuration
firewall --enabled
firstboot --disable
ignoredisk --only-use=sda
# Keyboard layouts
# old format: keyboard us
# new format:
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=link --activate
network  --hostname=localhost.localdomain
# Reboot after installation
reboot
# Root password
rootpw --iscrypted $5$QTSjXDfWmV9CHVqZ$fCWRniKkDl6WpG3XvDqJxHDEbwWc6feoOOqYEjkwYVD
# System services
services --enabled="chronyd"
# System timezone
timezone America/Los_Angeles --isUtc
user --groups=wheel --name=minhtc --password=$6$5V0NZzxFW89TUFBo$d9yC2llinH6Y333sFqfRk.RMJObAy4e4OCmELtZoWHymJ433y7k.JTcXJemqwgXU/QD880Bc1Rqo8kyfAkiPq0 --iscrypted --gecos="minhtc"
# X Window System configuration information
xconfig  --startxonboot
# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda
# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all --initlabel
# Disk partitioning information
part /boot --fstype="xfs" --size=300
part / --fstype="xfs" --size=18131
part swap --fstype="swap" --size=2048

%post
/usr/sbin/adduser minhct
/usr/sbin/usermod -p '$5$QTSjXDfWmV9CHVqZ$fCWRniKkDl6WpG3XvDqJxHDEbwWc6feoOOqYEjkwYVD' minhct
/usr/bin/chfn -f "Minh Tran" minhct
mv /etc/rc.d/rc.local /etc/rc.d/rc.local.00
echo '#!/bin/bash' > /etc/rc.d/rc.local
ln -s ../rc.local /etc/rc.d/rc5.d/S99rclocal
chmod 755 /etc/rc.d/rc.local
echo 'mkdir -p /var/log/vmware' >> /etc/rc.d/rc.local
echo 'exec 1> /var/log/vmware/rc.local.log' >> /etc/rc.d/rc.local
echo 'exec 2>&1' >> /etc/rc.d/rc.local
echo 'set -x' >> /etc/rc.d/rc.local
echo 'echo Installing Open VM Tools' >> /etc/rc.d/rc.local
echo 'set -x' >> /etc/rc.d/rc.local
echo '/bin/eject sr0 || /bin/true' >> /etc/rc.d/rc.local
echo '/bin/eject sr1 || /bin/true' >> /etc/rc.d/rc.local
echo '/bin/vmware-rpctool' \'guest.upgrader_send_cmd_line_args --default\' >> /etc/rc.d/rc.local
echo '/bin/vmware-rpctool' \'upgrader.setGuestFileRoot /tmp\' >> /etc/rc.d/rc.local
echo '/bin/vmware-rpctool' \'toolinstall.installerActive 1\' >> /etc/rc.d/rc.local
echo '/bin/vmware-rpctool' \'toolinstall.installerActive 100\' >> /etc/rc.d/rc.local
echo 'rm -f /etc/rc.d/rc.local' >> /etc/rc.d/rc.local
echo 'rm -f /etc/rc.d/rc5.d/S99rclocal' >> /etc/rc.d/rc.local
echo 'mv /etc/rc.d/rc.local.00 /etc/rc.d/rc.local' >> /etc/rc.d/rc.local
/bin/echo done
%end

%packages
@base
@core
@desktop-debugging
@dial-up
@directory-client
@fonts
@gnome-desktop
@guest-desktop-agents
@input-methods
@internet-browser
@java-platform
@multimedia
@network-file-system-client
@print-client
@x11
binutils
chrony
ftp
gcc
kernel-devel
kexec-tools
make
open-vm-tools
patch
python

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end
