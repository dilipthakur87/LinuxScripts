#!/bin/bash

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|ubuntu-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)
YELLOW="\033[1;33m"
RED="\033[0;31m"
ENDCOLOR="\033[0m"

if [ $USER != root ]; then
  echo -e $RED"Error: must be root"
  echo -e $YELLOW"Exiting..."$ENDCOLOR
  exit 0
fi

echo -e $YELLOW"Cleaning apt cache..."$ENDCOLOR
aptitude clean

echo -e $YELLOW"Removing old config files..."$ENDCOLOR
sudo aptitude purge $OLDCONF

echo -e $YELLOW"Removing old kernels..."$ENDCOLOR
sudo aptitude purge $OLDKERNELS

echo -e $YELLOW"Removine tmp files that hasn't been accessed for more than 3 days..."$ENDCOLOR
if sudo find /tmp -type f -atime +3 -delete; then
	echo -e $RED"/tmp files deleted"$ENDCOLOR
else
	find /tmp && echo -e $RED"Error deleting /tmp files"$ENDCOLOR || echo -e $RED"/tmp file not found!!!"$ENDCOLOR
fi

if sudo find /var/tmp -type f -atime +3 -delete; then
        echo -e $RED"/var/tmp files deleted"$ENDCOLOR
else
       find /var/tmp && echo -e $RED"Error deleting /var/tmp files"$ENDCOLOR || echo -e $RED"/var/tmp file not found!!!"$ENDCOLOR
fi

if sudo find /mnt/tmp -type f -atime +3 -delete; then
        echo -e $RED"/mnt/tmp files deleted"$ENDCOLOR
else
        find /mnt/tmp && echo -e $RED"Error deleting /mnt/tmp files"$ENDCOLOR || echo -e $RED"/mnt/tmp file not found!!!"$ENDCOLOR
fi

if sudo find /usr/src/tmp -type f -atime +3 -delete; then
        echo -e $RED"/usr/src/tmp files deleted"$ENDCOLOR
else
       find /usr/src/tmp && echo -e $RED"Error deleting /usr/src/tmp files"$ENDCOLOR || echo -e $RED"/usr/src/tmp file not found!!!"$ENDCOLOR
fi

echo -e $YELLOW"Emptying every trashes..."$ENDCOLOR
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null

echo -e $YELLOW"Script Finished!"$ENDCOLOR
