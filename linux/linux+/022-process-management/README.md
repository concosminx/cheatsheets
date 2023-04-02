# process management

- `top`
  - u can use `h` key
- `htop`
- `time`
  - example: `time ${sudo updatedb}`

## process management commands
- `ps`
  - view processes
  - `ps aux` - more info
- `lsof` - list open files
  - `lsof <directory>` - files opened in dir
  - `lsof -u <user>` - files open by a specific user
  - `lsof -p <PID>` - ... by a process
- `pgrep` - similar with ps | grep

## process termination
- `kill` 
  - `kill <PID>` - terminate gracefully
- `killall` - kills all processes with a common characteristic (eg. name)
- `pkill` - kills all processes that share a name

## process priority
- `nice <level> <command>` - set process priority
- `NI` - column from `top` command
- `renice` - can change the process priority
  - `renice <new value> <PID>`

