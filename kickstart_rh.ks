#version=RHEL8
# Use graphical install
graphical


%packages
@^workstation-product-environment
kexec-tools

%end

# Keyboard layouts
keyboard --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=ens160 --ipv6=auto --activate
network  --hostname=localhost.localdomain

# Run the Setup Agent on first boot
firstboot --enable

#ignoredisk --only-use=nvme0n1
autopart
# Partition clearing information
clearpart --none --initlabel

# System timezone
timezone America/New_York --isUtc

# Root password
rootpw --iscrypted $6$dmkscnYAVBX6Wn/g$OKc2YIQohRHAXAFPQOIeFQNNs2LBd076s10V37RYQzwHwOXPNXTykHj4hw8BjUl15JB3I8u.9Lmi423rz7Mry/
user --name=minhtc --password=$6$8jkOVMRl2qI3qd56$K6lG7nLnUAvqjVzwS7pbZ1XgJ7oASNUIKiM0EHn0CeNLgKY7H3kaUOGk.0SHkou1FNfz8uKjZg3.a3YnOPFDF. --iscrypted --gecos="minhtc"

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end
