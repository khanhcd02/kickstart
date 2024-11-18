lang en_US
keyboard us
timezone America/New_York --utc
rootpw $2b$10$3QWL6yvubieMnzEHP88B2u5PFfemb3wWCZoh2Mfm0VYJwlbgtT.I6 --iscrypted
reboot
text
cdrom
bootloader --append="rhgb quiet crashkernel=auto"
zerombr
clearpart --all --initlabel
autopart
network --device=link --hostname=rhel8.localdomain --bootproto=dhcp
firstboot --disable
selinux --enforcing
firewall --enabled --ssh
%packages
@^graphical-server-environment
%end