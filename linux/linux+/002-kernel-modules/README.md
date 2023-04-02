# lsmod

- list module command
- no additional arguments

# insmod | rmmod

- insert | remove modules
- use `-v` for verbose output
- are deprecated (we will use modprobe)

# modinfo

- displays information about a specific module
- `modeinfo -d` prints only the description

# modprobe

- is dependency aware

# depmod 

- use to find and handle kernel dependencies 
- used frequently with `-a` option

# dmesg

- used to read the kernel ring buffer
- has *kernel logs* 
