### mount shared folders in Ubuntu using VMware tools

- `sudo vmhgfs-fuse .host:/ /mnt/hgfs/ -o allow_other -o uid=1000`
- If the hgfs directory doesn't exist, try: `sudo vmhgfs-fuse .host:/ /mnt/ -o allow_other -o uid=1000`
- find out the share's name with `vmware-hgfsclient` -> `my-shared-folder`
- and run `sudo vmhgfs-fuse .host:/my-shared-folder /mnt/hgfs/ -o allow_other -o uid=1000`
- requirements `sudo apt-get install open-vm-tools open-vm-tools-desktop`
