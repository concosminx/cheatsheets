# file and directory management

## file and directory operations
- `touch` used to create a file; options: `-a` modify the access timestamp, `-m` change the modified timestamp, `-d <date>` set the timestamp to a specific date
- `stat <file name>` - see all the dates 

## file readers
- `grep`  
- `cat` 
- `tail`
- `head`
- `less`
- `more`

## redirection 
- stdout (1); default
  - redirection to a file: `>` creates/overwrite and `>>` append
- stderr (2)
  - `cat missingfile 2> errorFile` - redirect error to `errorFile`
- `cat file1 missingfile &> file3` - combined both (std and err)
- stdin (0)
  - uses `<`
  - `sort < a-file-with-names.txt` - sort values in a file
  - `sort < a-file-with-names.txt > a-sorted-files-with-names.txt`
  - `<<` (heredoc)
  - `cat << EOF` - will expect input until *EOF* is typed
  - `cat << EOF > new-names.txt`
- `|` - command redirection; `cat passwords.txt | grep john`
  - `ausearch -i | grep -i john`
- redirect to `/dev/null`
- `cat /var/log/audit/audit.log | tee audit_capture.log` - output to screen & file
  - `-a` option for append
- `xargs` 
  - `find . -size +1M | xargs ls -l`

## text Processing 
- `echo "Ram pam pam!"` 
- `tr` - translate
  - `tr 'A-Z' 'a-z' < my-file.txt`
  - `tr -d [:digit:] < my-file.txt`
- `sort`
  - `sort file-name.txt`
  - `sort -n file-name.txt` - sort lines numeric
  - `sort -k 2 file-name.txt` - sort by second column
- `cut` - get fields by delimiters
  - `cut -d ":" -f 1 file-name.txt` - by *:* and get first field
- `wc` - word / lines / chars count 
  - `grep root /etc/passwd | wc -l`
- `paste` - combine files line by line

## advanced Text Processing
- `grep <option> <search> <file>`
  - `grep -i jOhN /etc/passwd` - case insensitive
  - `-v` - inverse (not)
  - `-n` - see line numbers
  - `-l /etc/*` - list any place that contain the string
  - uses regexp `ro.` or `ro*`; `^` - start and `$` - end; `\*` - escape
- `awk` - uses whitespace as delimiter
  - `awk '{ print $1,$5 }' my-example.txt` - print fields 1 and 5
  - `-F:` - use field separator *:*
- `sed` - actions on text
  - `sed s/root/ROOT/ /etc/passwd | grep -i root` - first *root*
  - `sed s/root/ROOT/g /etc/passwd | grep -i root` - global, all ap.
- `printf` - format print output

## file and directory operations 
- `pwd`
- `ls`
- `mkdir`
- `mv <file> <location>`
- `cp <file or dir> <location>`; option `-r` for directories and `-a` to retain destination timestamp
- `rm <file or dir>`
- `rmdir`
- `diff`

## transfer commands
- `scp <file> remote-pc:/home/username` - copy a file to a remote host; un can change the order to copy to localhost
- `rsync -r ./myDir centos:/home/username`; preserve timestamp with `-a`
- `-azvh` - example option

## location demands
- `find <dir> <option> <search-params>` - see options
- `locate` - needs also `sudo updatedb`
- `which` - location of a program or command
- `whereis` - similar

## link commands
- `inodes` - name, data blocks, and index number
- hard links vs soft links
- `ln` - create links
  - `ln aFile aNewFile` - hard link
  - `ls -il a*` - see the inodes
  - `ln -s aFile aSymLink` - symlink
- `unlink aNewFile` - remove hard link