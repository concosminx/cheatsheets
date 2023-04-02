# storage management 

## MBR
- designed to hold 4 partition table entries
- related to BIOS and legacy boot

## GPT
- uses 64-bit LBA addressing (8 zettabytes in size)
- related to UEFI 

## fdisk command
- `ls /dev/sd*` - check disks/partitions
- `sudo fdisk -l /dev/sdb` - list information about disk
- `sudo fdisk /dev/sdb` - starts the interactive shell
- use `m` for help

## gdisk command
- usage is similar with `fdisk`

## parted command (the modifications are written automatically)
- `sudo parted /dev/sdb` - start the interactive shell

## less /proc/partitions
- informations about partitions

## block devices
- store data in fixed-size blocks (512 bytes, 1 kb, ...)

- `lsblk` list block devices
- `lsblk -p` prints the full path
- `lsblk -fs` prints the filesystem information 

- `blkid` to get more information about block devices
- `ls -l /dev/disk/by-uuid/`
- `ls -al /sys/block`

## file systems 
- common folders
  -   */* the root directory, real filesystem
  -   */boot* contains the boot files, real filesystem
  -   */home* contains the user files; mount OR real filesystem
  -   */opt* third-party programs
  -   */usr* data for standard Linux programs
  -   */dev* is a virtual filesystem that contains device files
  -   */sys* is a virtual filesystem that provides device & bus info
  -   */proc* is a virtual filesystem for process information 

## disk space commands
- `df` used to display disk space
- `df -h` human readable option
- `df -a` all information
- `du` amount of space used
- `du -h` human readable option
- `du -sh` see the total size of directory in human readable format

## path concepts
- absolute path vs. relative path

## device mapper and LVM
- logical volumes allows for one ore more physical devices to be aggregated into a single container
- `pvcreate /dev/<device1> /dev/<device2>` aggregate devices into a physical volume
- `vcreate <vg_name> /dev/<device1> /dev/<device>2` add PVs into a volume group 
- `lvcreate -n <lv_name> -L <size> <vg_name>` create the logical volume
- `dev/vg1/lv1` will be a symbolic link to `/dev/mapper/vg1_lv1` file

### LVM commands
- `ls /dev/sd*`
- `pvcreate /dev/sdb /dev/sdc`
- `pvdisplay` - see the physical volumes
- `vgcreate vg1 /dev/sdb /dev/sdc`
- `vgdisplay` - see the volume groups
- `lvcreate -n lv1 -L 1GB vg1`
- `lvdisplay` - see the logical volumes
- `ls -al /dev/vg1/lv1` 
- `ls -al /dev/mapper`
- `ls -al /dev/dm*`
- `lvremove vg1/lv1`- remove the logical volume
- `vgremove vg1` - remove the volume group
- `pvremove /dev/sdb /dev/sdc` - remove the physical volume

## RAID
- `man mdadm` - check the manual page of `mdadm`
- `mdadm -C dev/md1 -l 1 2 /dev/sdb /dev/sdc` - (RAID 1)
- `less /proc/mdstat` - check the status
- `mdadm --detail /dev/md1` - see details about devices
- `lsblk` - u can see info about created RAID
- `cd /dev/disk` - (see the subdirectories for device information)

## File System Creation
- *ext* - the Linux extended filesystem (uses journaling starting with *ext3*)
- *ext4* - added support from file size up to 16TB (used in ubuntu as the default)
- *xfs* - default filesystem for Red Hat (RHEL 7); tends to be faster on larger drives than *ext4*

### *mkfs* command
- `lsblk` - list the block devices
- `mkfs -t ext4 /dev/sdb1` - creates an *ext4* filesystem
- `mkfs -t xfs /dev/sdc1` 

## File System Mounting
- the process of making a filesystem available for use 
- `mount | grep sd` - see the mounted filesystems
- `mount` - display all information 
- `mkdir /mnt/ext4 /mnt/xfs` - create some mounting points (*ext4*, *xfs*)
- `ls /mnt' - check the directories
- `mount /dev/sdb1 /mnt/ext4` - mount the filesystem
- `mount /dev/sdc1 /mnt/xfs` - mount the filesystem
- `mount | grep sd` - we will see the mounted filesystem
- `cat /proc/mounts` - similar info
- `cat /etc/mtab` - similar info
- `umount /mnt/ext4` - unmount

## Persistent mounts
- `cat /etc/fstab` - see persistent mounts information
- `blkid` - see available devices
- `blkid | tail -n 2 | cut -d " " -f 2 >> /etc/fstab` - get the UUID info from `blkid` and append them
- add the extra info (mount points, format, defaults)
- `mount -a` - auto mounts all the filesystems from `/etc/fstab`
- `vim /etc/crypttab` - encrypted drives

## XFS File System Tools
- `xfs_info` - display filesystem data
- `xfs_repair` - check and repair
- `xfs_admin` - change a label of a filesystem
- `xfs_info /dev/sdc1` 
- `umount /mnt/xfs`
- `xfs_repair /dev/sdc1`
- `xfs_admin -L xfs /dev/sdc1`
- `mount /dev/sdc1 /mnt/xfs`
- `blkid`

## External File Systems
### nfs
- nfs - network file system (access data across a network)
- showmount -e <nfs_system_name>
- `mount -t nfs <nfs_system_nbame>:<export> <mount_point>` (example `mount -t nfs nfsserve:/files /mnt/files`)

### smb
- used by windows (server message block)
- `samba` linux client for `smb`
- `smbclient -L <server_name> -U <user_name>` - access
- `mount //win1/files /mnt/files` - mount example 

### ntfs
- default file system on Microsoft Windows

### Multipathing 
- create multiple paths to a remote storage device
- `kpartx`
- `multipath`

# File System Troubleshooting
- `iostat` - gather I/O stats
- `fsck` - only for unmounted filesystems and ext filesystems
