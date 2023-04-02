# job scheduling

## the cron daemon
- `crond` starts up when the system boots
- runs in bg. and check user "cron tables" 
- also uses a global, system crontab `/etc/crontab/` to run scripts at specific intervals (from the dirs):
  - /etc/cron.hourly
  - /etc/cron.daily
  - /etc/cron.weekly
  - /etc/cron/monthly
- anacron check for missed runs ... 
- `less /etc/crontab` - see existing jobs configuration
- `less /etc/anacron` - see anacron configuration
- `ll /var/spool/aancron` - files checked by anacron
- `ls /etc/cron.daily` - see daily scripts

### the *crontab* utility
- cron table files are one of the places the cron daemon looks for schedule jobs
- stored in `/var/spool/cron/<username>` (centos) or `/var/spool/cron/crontabs/<username>` (ubuntu)
- used for custom user scheduled jobs
- Minute | Hour | Day of Month | Month | Day of year
- `crontab -e`
  - `* * * * * /usr/bin/echo 'This is running every minute" >> /tmp/minute-test` - run every minute
- `crontab -r` - remove a job

### the *at* command 
- `at <-f filename> time` - basic syntax
  - `at -f script.sh + 1 minute`
  - the time can be fixed: `at noon`, `at midnight`, `at 08:04` or relative `at now`, `at now + 10 minutes`
  - `/var/spool/at` - job queue
  - `atq` - see job queue
  - `atrm <job number>` - remove a job from queue
  - example:
    - `at now +3 minutes`
    - `echo "only a test" >> /tmp/attest`
    - `atq`
    - `ls /var/spool/at`
    - `less /var/spool/at/<atfile>`

### job control
- `some_script.sh &` - the process is sent to th bg.
- `jobs` - see the job running in the bg.
- `fg <job number>` - bring a job back in foreground
- `Ctrl+C` = SIGINT (terminate the job)
- `Ctrl+Z` = SIGSTP (pause the job)
- `bg` - to send the paused job in the bg.
- `nohup some_script.sh &` - run the script in background evet if the user logs out

### the *kill* command
- `kill <SIGNAL> <PID>` - kill a process
  - SIGTERM 15 (terminate gracefully)
  - SIGKILL  9 (brute-force kill)
- `pkill cups` - for example this command will kill all printer-related processes  