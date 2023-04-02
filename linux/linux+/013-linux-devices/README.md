# linux devices

## network devices
- configure the wireless network with `iwconfig`
  - `iwconfig` - list all available interfaces
  - `iwlist <interface(int)>` - scan (to list available Wi-Fi networks)
  - `iwconfig <int>` - see interface status
  - `iwconfig <int> essid <Wi-Fi name>` - see network to connect to
  - `iwconfig <int> commit` - apply changes
- bluetooth installed with `bluez` package; provides `bluetoothctl` and `hcitool`:
  - `bluetoothctl list`
  - `bluetoothctl scan on`
  - `hcitool scan`
  - `bluetoothctl pair <controller_MAC>`


## I/O devices
- GPIO - communicate and program / control external devices 
- HBA - host bus adaptor (IDE, SCSI, SATA, Ethernet)

## Output devices

## Printer devices
- `/etc/cups`
- `/etc/cups/cupsd.conf`
- uses IPP (Internet Printing Interface), port *631*
- `lpc`, `lpq`, `lpr`, `lprm`

## Devices buses
- USB
- PCI
- SATA / SCSI
- `lsdev` and `lshw` commands
  - `lsdev` lists system hardware information from `/proc/ioports`, `/proc/dma` and `/pro/interrupts`
  - `which procinfo`
  - `apt install procinfo`
  - `lshw -class disk -sanitize`

## *procfs* filesystem
- expose hardware and process state information from the kernel (is a pseudofilesystem)
- IRQ - used by devices to signal CPU the have to send data
  - can be seen in `/proc/interrupts`
- I/O Ports - memory addresses for communicating with a device
  - can be seen in `/proc/ioports`
- DMA - Direct Memory Access - sppeds things up
  - can pe seen in `/proc/dma`
- `ls /proc`

## *sysfs* filesystem
- a pseudofilesystem
- `/sys` - properties and statistics of hardware and filesystems
  - /sys/block 
  - /sys/bus
  - /sys/devices
  - /sys/fs
  - /sys/kernel

# *udev* and *udev rules*
- userspace /dev - acts as a device manager for the kernel
- rules:
  - /usr/lib/udev/rules.d - system default (lowest priority)
  - /etc/udev/rules.d - custom rules
  - /run/udev/rules.d - not persistent custom rules
  - numbers first; then names (alphabetically)

# *udevadm* command
- manage or gather device information
  - obtain information about a device
    - `udevadm info -q`; query types: name, symlink, path, property or all
    - `udevadm info -n /dev/sda`
    - `udevadm info -q property -n /dev/sda`
  - display uevents
    - `udevadm monitor`
  - test rule changes
    - `udevadm test --<action><device>`
    - `udevadm test --action="dd" /dev/char/89:0`
    - `udevadm trigger`
  - apply rule changes
    - `udevadm control --reload`

# USB devices
- `lsusb -t` - tree
- `lsusb -v` - verbose

## PCI devices
- `lspci -v`   

## Storage devices
- IDE 
- SCSI 
  - parallel interface
  - max 16 devices on a SCSI bus
  - priority 7,6,5 ...0,15, ...8
- SATA
  - Serial AT Attachment
  - SATA I - SATA III
  - eSATA - ability to connect external devices
- `lsblk -p` - list all block devices with full path
- 