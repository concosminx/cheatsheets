# localization options

## environmental variables (related to localization) 
- `LANG` - used to control all environmental variables (eg. LANG=en_US.UTF-8)
- `LC_*` - modify a locale category (LC_TIME, LC_MONETARY ...)
- `LC_ALL` - sets all; overides LANG
- use the `locale` command to see all LC
- `TZ` - set the default Timezone

## character sets 
- UTF-8 (replaces ASCII)

## localization files
- `/etc/timezone` - Ubuntu or `/etc/localtime` - CentOS (boths get the info `/usr/share/zoneinfo`)
- `ls -al /usr/share/zoneinfo/` - see all the timezones

## localization commands
- `locale` - all locale categories
- `localectl` - controls and modifies system locale settings
  - `localectl set-locale LANG=en_CA.UTF-8`
  - 

## time commands
- `timedatectl` - set time and timezone
  - `timedatectl set-timezone "America/Los_Angeles"
- `date` - print or set the time
  - `date -s "Tue May 13 20:12:12 PDT 2023"`
- `hwclock` - manage the hardware clock


