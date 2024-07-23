#!/bin/bash

#specify the directory you want to name the jail
chr=/bruh/lol
#specify the name of the jail group
group=jail
#add all of the valid users. You have to create them on your own first though
names=("bruh")

#Add users to jail group
sudo addgroup $group
for i in "${names[@]}"; do
sudo usermod -aG jail "$i"

#create jail directory and permissions
sudo mkdir -pv $chr
sudo chown -v root:root $chr

#create user directories
sudo mkdir -pv $chr/home/"$i"
sudo chown -Rv "$i":"$i" $chr/home/"$i"
sudo chmod -Rv 700 $chr/home/"$i"
done

#create dependencies. DON'T TOUCH THESE!!!
sudo mkdir -pv $chr/{bin,lib,lib64,dev}
sudo cp -v --parents /etc/{passwd,group} $chr
ls -l /dev/{null,zero,stdin,stdout,stderr,random,tty}
sudo mknod -m 666 $chr/dev/null c 1 3
sudo mknod -m 666 $chr/dev/random c 1 8
sudo mknod -m 666 $chr/dev/tty c 5 0
sudo mknod -m 666 $chr/dev/zero c 1 5
sudo ln -sv /proc/self/fd/2 $chr/dev/stderr
sudo ln -sv /proc/self/fd/0 $chr/dev/stdin
sudo ln -sv /proc/self/fd/1 $chr/dev/stdout

#Specify the commands you want to give the users.
#Add to the list within the /bin/{ }
#I think the /bin/bash is essential. I wouldn't take it out just in case, unless you know better. 
sudo cp -v /bin/{bash,ls,cat,} $chr/bin
dlist="$(ldd /bin/{bash,ls,cat} | egrep -o '/lib.*\.[0-9]')"
for i in $dlist; do sudo cp -v --parents "$i" "${chr}"; done

echo ""
echo ""
echo ==========================Done===============================                        	 
echo ""
echo "Add this to /etc/ssh/sshd_config:"
echo ""
echo '(comment out "Subsystem  	sftp	/usr/lib/openssh/sftp-server" and add below:'
echo "Subsystem   	sftp	internal-sftp"
echo ""
echo 'At the very bottom add:'
echo ""
#specify whatever you set the jail group to. Example: jail
echo 'Match group (whatever $group is)'
#Don't put $chr. Just type out the chroot directory you specified. Example: /bruh/lol
echo '    	ChrootDirectory (whatever $chr is)'
echo '    	AllowTcpForwarding no'
echo ""
echo "Don't forget to restart the service by doing 'sudo systemctl restart ssh'"
