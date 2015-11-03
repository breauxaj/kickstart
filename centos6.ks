install
text
url --url http://mirror.rackspace.com/CentOS/6/os/x86_64/
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
repo --name=EPEL --baseurl=http://dl.fedoraproject.org/pub/epel/6/x86_64
repo --name=PuppetLabs --baseurl=http://yum.puppetlabs.com/el/6/products/x86_64/
repo --name=Docker --baseurl=https://yum.dockerproject.org/repo/main/centos/6
%packages --nobase --excludedocs
@core
-abrt*
-aic94xx-firmware*
-alsa-*
-atmel-firmware-*
-bfa-firmware-*
-btrfs-progs*
-cups*
-ipw2100-firmware-*
-ivtv*
-iwl*firmware
-kexec-tools
-libertas-*-firmware
-plymouth*
-rt*-firmware*
-ql*-firmware*
-xorg-x11-drv-ati-firmware-*
-zd*-firmware*
augeas
docker-engine
epel-release
expect
git
nfs-utils
nmap
ntp
oddjob
oddjob-mkhomedir
puppet
puppetlabs-release-6-11
redhat-lsb
ruby
ruby-devel
rubygems
screen
sssd
strace
subversion
tcpdump
yum-utils
%end

%post
yum -y update
yum clean all
rm -rf /var/cache/yum/*
rm -f /etc/udev/rules.d/70*
sed -i '/^(HWADDR|UUID)=/d' /etc/sysconfig/network-scripts/ifcfg-eth0
%end