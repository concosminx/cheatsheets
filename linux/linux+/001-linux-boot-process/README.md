# steps 
1. Bootstrap phase
  BIOS / UEFI / PXE

2. Bootloader phase
	- GRUB - load the linux system kernel (operates in stages)
	- configuration file `/boot/grub/menu.lst` or `/boot/grub/grub.conf`
	- GRUB2 configuration file `/etc/default/grub` and directory `/etc/grub.d` 
	- check version `grub-install -V` or `grub2-install -V`

3. Kernel phase

4. Initialisation phase

# mkinitramfs command - ubuntu

- `cd /boot`
- `uname -r` display the current kernel version
- `sudo cp /boot/initrd.img-${uname -r} /root` create a bk using shell extension
- `sudo ls -lah /root` check if the bk is ok
- `sudo makeinitramfs -0 /boot/initrd.img-{uname -r} ${uname-r}` create a new file 


# centos

- `initramfs` the same role as `initrd` from ubuntu
- `sudo dracut newimage.img`
- `sudo lsinitrd newimage.img | less` 
- `sudo dracut --add-drivers <driver> newimage.img`


# boot commands

- `grub2-install` - not now
- `cp /boot/grub2/grub.cfg /boot/grub2/grub.cfg.older`
- `nano /etc/default/grub` - we can modify the timeout
- `grub2-mkconfig -o /boot/grub2/grub.cfg.newer` will pick-up the changes made
- `cp grub.cfg.newer grub.cfg` overwrite current version 
