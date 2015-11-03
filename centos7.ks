install
text
url --url http://mirror.rackspace.com/CentOS/7/os/x86_64/
lang en_US.UTF-8
keyboard us
network --device eth0 --bootproto dhcp --noipv6
rootpw changeme
firstboot --disable
authconfig --enableshadow --passalgo=sha512
selinux --permissive
# adjust to your timezone
timezone America/New_York
# disk configuration, vmware options appended
bootloader --location=mbr --driveorder=sda --append="crashkernel=128M vga=788 elevator=noop"
clearpart --all --initlabel
zerombr
part /boot --fstype ext3 --size=256
part swap --size=2048
# lvm configuration
part pv.01 --size=1 --grow
volgroup vg_root pv.01
logvol / --vgname=vg_root --size=2048 --name=lv_root
logvol /usr --vgname=vg_root --size=4096 --name=lv_usr
logvol /tmp --vgname=vg_root --size=2048 --name=lv_tmp
logvol /opt --vgname=vg_root --size=2048 --name=lv_opt
logvol /home --vgname=vg_root --size=4096 --name=lv_home
logvol /var --vgname=vg_root --size=1 --grow --name=lv_var
repo --name=EPEL --baseurl=http://dl.fedoraproject.org/pub/epel/7/x86_64
repo --name=PuppetLabs --baseurl=http://yum.puppetlabs.com/el/7/products/x86_64
repo --name=Docker --baseurl=https://yum.dockerproject.org/repo/main/centos/7
%packages --nobase --excludedocs
@core --nodefaults
-aic94xx-firmware*
-alsa-*
-biosdevname
-btrfs-progs*
-dracut-network
-iprutils
-ivtv*
-iwl*firmware
-libertas*
-kexec-tools
-NetworkManager*
-plymouth*
augeas
docker-engine
epel-release
expect
git
net-tools
nfs-utils
nmap
ntp
oddjob
oddjob-mkhomedir
puppet
puppetlabs-release-7-11
redhat-lsb
ruby
ruby-devel
rubygems
screen
sssd
strace
subversion
tcpdump
yum-cron
yum-utils
%end

%post
yum -y update
yum clean all
rm -rf /var/cache/*
%end
