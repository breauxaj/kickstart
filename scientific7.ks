install
text
url --url http://ftp1.scientificlinux.org/linux/scientific/7x/x86_64/os/
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
bootloader --location=mbr --driveorder=sda --append="crashkernel=128M vga=788 elevator=noop net.ifnames=0 biosdevname=0"
clearpart --all --initlabel
zerombr
part /boot --fstype ext3 --size=256
part swap --size=2048
# lvm configuration
part pv.01 --size=1 --grow
volgroup rootvg pv.01
logvol / --vgname=rootvg --size=2048 --name=rootlv
logvol /usr --vgname=rootvg --size=4096 --name=usrlv
logvol /tmp --vgname=rootvg --size=2048 --name=tmplv
logvol /opt --vgname=rootvg --size=2048 --name=optlv
logvol /home --vgname=rootvg --size=4096 --name=homelv
logvol /var --vgname=rootvg --size=1 --grow --name=varlv
repo --name=EPEL --baseurl=http://dl.fedoraproject.org/pub/epel/7/x86_64
repo --name=PuppetLabs --baseurl=http://yum.puppetlabs.com/el/7/products/x86_64
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
puppetlabs-release
redhat-lsb
ruby
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
yum history sync
yum clean all
rm -rf /var/cache/*
mv /etc/sysconfig/network-scripts/ifcfg-enp0s3 /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i 's/enp0s3/eth0/g' /etc/sysconfig/network-scripts/ifcfg-eth0
%end
