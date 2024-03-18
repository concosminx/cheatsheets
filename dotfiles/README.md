# Various windows batch files


### Install jar(s) in local maven from command line
```Batchfile
call mvn install:install-file -Dfile="ojdbc7.jar" -DgroupId=com.oracle -DartifactId=ojdbc7 -Dversion=12.1.0.1 -Dpackaging=jar

pause
```


### Simple back-up script for windows 
```Batchfile
rem prerequisites 7z needs to be in windows path

echo "Save to B drive"

cd /d E:\

7z a -bd Management.zip Management\

xcopy "E:\Management.zip" B:\ /Y

del Management.zip

rem rd /s /q Content
rem call 7z a .\Content\Dropbox.zip "D:\Dropbox" -pPasswordHere

pause
```

### Complex back-up script for windows
- configuration file (BackupConfig.txt)
```Batchfile
#one file or folder / line
D:\Dropbox\Photos\Utile\Photo_Content
D:\Projects\GIT\web-samples\bootstrap\setup
```

- actual back-up script 
```Batchfile
@ECHO OFF

REM Source: https://www.alphr.com/windows-batch-script-to-backup-data/
REM Performs full or incremental backups of folders and files configured by the user.

REM Usage---
REM   > BackupScript

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

REM ---Configuration Options---

REM Folder location where you want to store the resulting backup archive.
REM This folder must exist. Do not put a '\' on the end, this will be added automatically.
REM You can enter a local path, an external drive letter (ex. F:) or a network location (ex. \\server\backups)
SET BackupStorage=D:\Backup

REM Which day of the week do you want to perform a full backup on?
REM Enter one of the following: Sun, Mon, Tue, Wed, Thu, Fri, Sat, *
REM Any day of the week other than the one specified below will run an incremental backup.
REM If you enter '*', a full backup will be run every time.
SET FullBackupDay=*

REM Location where 7-Zip is installed on your computer.
REM The default is in a folder, '7-Zip' in your Program Files directory.
SET InstallLocationOf7Zip=%ProgramFiles%\7-Zip

REM +-----------------------------------------------------------------------+
REM | Do not change anything below here unless you know what you are doing. |
REM +-----------------------------------------------------------------------+

REM Usage variables.
SET exe7Zip=%InstallLocationOf7Zip%\7z.exe
SET dirTempBackup=%TEMP%\backup
SET filBackupConfig=BackupConfig.txt

REM Validation.
IF NOT EXIST %filBackupConfig% (
  ECHO No configuration file found, missing: %filBackupConfig%
  GOTO End
)
IF NOT EXIST "%exe7Zip%" (
  ECHO 7-Zip is not installed in the location: %dir7Zip%
  ECHO Please update the directory where 7-Zip is installed.
  GOTO End
)

REM Backup variables.
FOR /f "tokens=1,2,3,4 delims=/ " %%a IN ('date /t') DO (
  SET DayOfWeek=%%a
  SET NowDate=%%d-%%b-%%c
  SET FileDate=%%b-%%c-%%d
)

IF {%FullBackupDay%}=={*} SET FullBackupDay=%DayOfWeek%
IF /i {%FullBackupDay%}=={%DayOfWeek%} (
  SET txtBackup=Full
  SET swXCopy=/e
) ELSE (
  SET txtBackup=Incremental
  SET swXCopy=/s /d:%FileDate%
)

ECHO Starting to copy files.
IF NOT EXIST "%dirTempBackup%" MKDIR "%dirTempBackup%"
FOR /f "skip=1 tokens=*" %%A IN (%filBackupConfig%) DO (
  SET Current=%%~A
  IF NOT EXIST "!Current!" (
    ECHO ERROR! Not found: !Current!
  ) ELSE (
    ECHO Copying: !Current!
    SET Destination=%dirTempBackup%\!Current:~0,1!%%~pnxA
    REM Determine if the entry is a file or directory.
    IF "%%~xA"=="" (
      REM Directory.
      XCOPY "!Current!" "!Destination!" /v /c /i /g /h /q /r /y %swXCopy%
    ) ELSE (
      REM File.
      COPY /v /y "!Current!" "!Destination!"
    )
  )
)
ECHO Done copying files.
ECHO.

SET BackupFileDestination=%BackupStorage%\Backup_%FileDate%_%txtBackup%.zip

REM If the backup file exists, remove it in favor of the new file.
IF EXIST "%BackupFileDestination%" DEL /f /q "%BackupFileDestination%"

ECHO Compressing backed up files. (New window)
REM Compress files using 7-Zip in a lower priority process.
START "Compressing Backup. DO NOT CLOSE" /belownormal /wait "%exe7Zip%" a -tzip -r -mx5 "%BackupFileDestination%" "%dirTempBackup%\"
ECHO Done compressing backed up files.
ECHO.

ECHO Cleaning up.
IF EXIST "%dirTempBackup%" RMDIR /s /q "%dirTempBackup%"
ECHO.

:End
ECHO Finished.
ECHO.

ENDLOCAL
```