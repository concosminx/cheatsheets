# linux GUI

## display servers
- handles communication between the UI and the kernel
- does NOT provide a desktop
- X11 configuration stored in /etc/X11/xorg.conf or in /etc/X11/xorg.conf.d
- Wayland Display Server - created to replace X11

## linux desktop comparison
- provides a GUI
  - KDE Plasma
  - Cinnamon
  - Unity
  - GNOME
  - MATE

## linux remote desktop options
- VNC (Virtual Network Computing)
  - most used
  - uses RFB protocol
  - operates on TCP Port 5900+N (N the number for the user)
  - 
- NX / NoMachine
  - uses OpenSSH tunneling (port 22)
  - cross-platform
  - faster than VNC
- XRDP
  - supports Remote Desktop Protocol
  - uses TCP 3389 (standard RDP port)
- Spice
  - Simple Protocol for Independent Computing Environments

## console redirection 
- with SSH port forwarding
- pre-requisites
  - each side needs OpenSSH installed
  - port forwarding has to be enabled in OpenSSH configuration *AllowTCPForwarding yes*
  - 4 types
    - Local: local port forwarding
      - `ssh -L <local port>:<destination server>:<remote port><SSH server>`
      - example: `ssh -L 1338:someserver.com:80 localhost`
    - Remote: port fwd. starts at the remote host as opposed to the local SSH client
      - provide access to a local resource to a remote host through ssh
      - `ssh -R <remote port>:localhost:<local port> user@remote-SSH-server`
      - `ssh _R 1337:localhost:2049 user@remoteSSH`
    - X11 fwd.
    - VNC fwd.
      - `ssh -L 5901:localhost:5903 user@remote-server`


    
