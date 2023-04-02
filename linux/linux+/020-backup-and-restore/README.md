# backup and restore

## archive and restore tools
- tar, cpio, dd
- **tar**
  - options:
    - `-c` - create
    - `-x` - extract
    - `-v` - verbose
    - `-f` - file to operate on
    - `-z` - use gzip
  - examples:
    - `tar -cvf <destination file> <directory to archive>`
    - `tar -xvf <file name to extract>.tar`
    - 
- **cpio**
  - used for boot images
  - options: `-o`, `-i`, `-v`
  - examples:
    - `ls /dir1/*.txt | cpio -ov > dir1txtFiles.cpio`
    - `cpio -iv < dirtxtFiles.cpio`
- **dd**
  - data description
  - options:
    - `if`, `of`, `count`, `bs`
    - `dd if=/dev/zero of=/dev/sdb1` - copies all zeros from the source into the first partiton on `/dev/sdb` (a disk format operation known as zeroing out a disk)
  
## compression utilities
- gzip, bzip2, xz, zip
- **gzip**
  - `gzip file1` - file1 becomes file1.gz
  - `gunzip file1.gz` - un-compresses file back to file1
- **bzip2**
  - `bzip2 file1` - file1 becomes file1.bz2
  - `bunzip file1.bz2` - un-compresses file back to file1 
- **xz**
  - `xz file1`
  - `unxz file1.xz`
  - `-J` to use xz with tar
- **zip**
  - can operate on multiple files
  - `zip` to compress; `unzip` to decompress

## back-up types
- system image (clone) - exact copy
- full backup - all the data
- incremental backup - only data that has been modified since last backup
- differential - data modified
- snapshot backup - read only copy made to backup media
- options:
  - fullbackup sunday, differential backup monday - saturday
    - in case of failure on Friday, you will need Full backup + Differential backup from Thursday
  - fullbackup sunday, incremental from monday - saturday
    - in case of failure, you will need Full backup + all incrementals
- best practices:
  - a weekly full backup should been taken at a minimum
  - a system image backup should be taken at least once for any mission-critical system (if it is posible als good to clone the system, if a virtual machine) at least quarterly
  - snapshot backups should be taken before any change operation that could cause an outage, such as an operating system patch

## transfer utilities
- **sftp**
  - uses `get` and `put`
- **scp**
  - `scp <local file> user@remotehost:<target location>`
  - `scp user@remotehost:<remote source> <local target>`
- **rsync**
  - `rsync -avz /home/user1/dir1 user1@ubuntu:/home/user1`


## integrity checks
- MD5 or SHA
- `md5sum <file name>`
- `sha256sum <file name>`
- `sha512sum <file name>`