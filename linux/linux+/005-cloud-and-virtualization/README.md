# cloud and virtualization 

## VM templates
- OFV - Open Virtualization Format
- not so easy to transfer in this format
- OVA - Open Virtualization Appliance - created to adress this issue (bundless all of the OVF files into a single file)

## initialization tools 
- Cloud init - used to initialize a cloud instance
- uses `/etc/cloud/cloud.cfg`

## Anaconda installer
- installer program used by different linux distributions 
- can be automated through a *kickstart file*
- can be generated useing the kickstart configurator or performing a manual instalation with Anaconda (*/root/anaconda-ks.cfg*)

## storage types
1) thin-provisioned storage: used on-demand
  - critically important to monitor and set alarms in this type of provisioning
2) thick-provisioned
  - allocated up front; constant or static; risk of under-utilization or wasting space
3) blob storage
  - set of large unstructured data
  - three types: block blobs (text or binary data), append blobs (optimized for append, like logging), page blobs (store random access files up to 8TB)
  - fixed size blocks
  - AWS Elastic Block Storage (EBS), Google Cloud Persistent Disk, Azure Disks
 
## virtual network 
1) local network (host-only or local adapter is used) so the network only lives inside a host sistem where the virtual machines run
  - offers speed and security
2) NAT - network address translation
  - only one public IP address goes to the outside world
  - internal (private) IPs are translated (IN / OUT)
3) dual-homed
  - has an active connection in 2 active networks (redundancy / connect two networks)
4) bridged networks
  - in virtualization, a bridged adapter makes a VM look like any other system
5) overlay networks
  - one network layered on top of the other
  - controlled by software / applications
  - a method of network virtualization

## hypervisor types
1) type 1 (bare metal); full access to system hardware (eg. VMWare ESXi)
2) type 2 (virtualization application installed on a host OS) (eg. VirtualBox on Windows)
3) embedded (used in embedded systems) (eg. self driving cars / automation)

### chroots
- `chroot` or `root jail` - the root access provided to the application is a virtual root filesystem
- used for security and to separate applications from each other

## containers 
- environments made up of files, libraries and configurations
- types: Linux Containers (LXC) and Docker
 
## virtualization commands
- `libvirt` - used to work with the KVM (Kernel-based Virtual Machine) hypervisor
- `virsh` - CLI for libvirt
- `sudo apt-get install libvirt-clients` (Ubuntu) or `yum install libvirt-client` (CentOS)
- common commands
  - virsh list - list domains (VMs)
  - virsh list --all - includes the inactive ones
  - virsh console - connect to VM console
  - virsh create - create a VM from an XML file
  - virsh reboot - reboot VM
  - virsh shutdown - gracefully shutdown VM
 - `vmm` - GUI for manage VMs
 


