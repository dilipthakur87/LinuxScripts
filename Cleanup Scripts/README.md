# Disk Cleanup Script

## Description : 

* ### Getting the old config files and old kernels
``` bash
OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|ubuntu-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)
```
* ### Checking if the user is root or not !!!
``` bash
if [ $USER != root ]; then
echo -e $RED"Error: must be root"
echo -e $YELLOW"Exiting..."$ENDCOLOR
exit 0
fi
```
* ### Cleaning the aptitude cache
``` bash
aptitude clean
```
* ### Removing the old config files and old kernels
``` bash
sudo aptitude purge $OLDCONF
sudo aptitude purge $OLDKERNELS
```
* ### Finding and Removing /tmp files that hasn't been accessed for more than 3 days
``` bash
sudo find <path_to_tmp_files> -type f -atime +3 -delete
```
* ### Emptying every trashes
``` bash 
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null
```

## Executing the script:
> Navigate to the directory containing the script and run: 
``` bash
sudo sh cleanup.sh
```
> You can also make it executable by running: 
``` bash
sudo chmod +x cleanup.sh
``` 
and then exexute it by running: ``` ./cleanup.sh ``` in the terminal.

## Troubleshooting : 
> **aptitude error** : Install **aptitude** by running the following command in the terminal : 
``` bash 
sudo apt-get update
sudo apt-get install aptitude
```
> **sed error** : reinstall **sed** by running the following command in the terminal :
``` bash 
sudo apt install --reinstall sed
```