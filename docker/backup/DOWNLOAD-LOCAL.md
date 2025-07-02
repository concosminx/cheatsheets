# SFTP Sync Script Guide

## Purpose
Automates SFTP synchronization of files from a Linux cloud server to a Windows machine using WinSCP.

## Prerequisites
* WinSCP installed (GUI and Command-line components).
* SSH private key file (`.pem` format).
* Server's SSH host key fingerprint (e.g., `ssh-rsa 2048 SHA256:...`).

## Configuration (`sync_cloud_backups.bat`)

Edit the `CONFIGURATION SECTION` of the script:

| Variable                     | Description                                                                     | Example Value                                  |
| :--------------------------- | :------------------------------------------------------------------------------ | :--------------------------------------------- |
| `WINSCP_PATH`                | Full path to `WinSCP.com` executable.                                           | `C:\Program Files (x86)\WinSCP\WinSCP.com`     |
| `LOCAL_BACKUP_BASE_DIR`      | Base directory on Windows for all synced data & logs.                           | `<Your Local Backup Base Path>`                |
| `SERVER1_USER`               | SSH username on your cloud server.                                              | `john`                                       |
| `SERVER1_IP`                 | IP address of your cloud server.                                                | `1.2.3.4`                                      |
| `SERVER1_REMOTE_BACKUP_DIR`  | Full path to the directory on the server to sync from.                          | `/home/user/backups`                           |
| `SERVER1_SSH_KEY`            | Full path to your SSH private key file (`.pem`).                                | `C:\Users\User\.ssh\my_key.pem`                |
| `SERVER1_LOCAL_SYNC_DIR`     | Local path where this server's backups will be stored (under `LOCAL_BACKUP_BASE_DIR`). | `<Your Local Backup Base Path>\Server1Backups` |
| `SERVER1_FINGERPRINT`        | **Crucial:** Server's SSH host key fingerprint.                                 | `ssh-rsa 2048 SHA256:YOUR_FINGERPRINT_HERE`    |

*(Repeat `SERVER2_` variables for additional servers.)*

Connect via `WinSCP GUI`, then navigate to Tabs > Server/protocol Information > Protocol tab and copy the `SHA-256` fingerprint.

## Usage

1.  **Save** the edited `.bat` file.
2.  **Run as Administrator:** Right-click the `.bat` file and select "Run as administrator" to avoid permission issues.

## Logging & Troubleshooting

All logs are generated in the `Logs` subdirectory within your `LOCAL_BACKUP_BASE_DIR`.

1.  **Main Script Log (`sync_log_YYYYMMDD_HHMMSS.log`)**:
    * Records overall script execution, directory creation, and final status of each sync attempt (e.g., `ERROR: Sync for ServerX failed with error code 1`).

2.  **WinSCP Detailed Log (`WinSCP_Detailed_Sync_Log_YYYYMMDD_HHMMSS.log`)**:
    * **This log is paramount for troubleshooting.** It contains direct output from WinSCP, detailing connection attempts, transfer progress, and **the precise reason for any synchronization failure** (e.g., "No such file or directory", "Permission denied", "Synchronization was not successful").

**If `error code 1` occurs in the main log, immediately check the corresponding `WinSCP_Detailed_Sync_Log` for the specific cause.**


```batch
@echo off
setlocal

:: ==============================================================================
:: === CONFIGURATION SECTION ===
:: ==============================================================================

:: Path to WinSCP.com executable. Adjust if not in default location.
set "WINSCP_PATH=D:\.....\WinSCP.com"

:: Local base directory for synced backups
set "LOCAL_BACKUP_BASE_DIR=E:\Data\BackUps"

:: --- SERVER 1 CONFIGURATION ---
set "SERVER1_USER=cloud-user"
set "SERVER1_IP=ip_server_1"
set "SERVER1_REMOTE_BACKUP_DIR=/home/cloud-user/back-up"
set "SERVER1_SSH_KEY=D:\ ....\ssh-rsa.key.ppk"
set "SERVER1_LOCAL_SYNC_DIR=%LOCAL_BACKUP_BASE_DIR%\Server1Backups"
:: You MUST get your server's SSH host key fingerprint.
:: Connect once manually with WinSCP and accept the key, or use 'ssh-keyscan <IP>' on Linux.
set "SERVER1_FINGERPRINT=ssh-ed25519 255 fingerprint-sever-1" 

:: --- SERVER 2 CONFIGURATION (similar to Server 1) ---
set "SERVER2_USER=cloud-user"
set "SERVER2_IP=ip_server_2"
set "SERVER2_REMOTE_BACKUP_DIR=/home/cloud-user/back-up"
set "SERVER2_SSH_KEY=D:\ ....\ssh-rsa.key.ppk"
set "SERVER2_LOCAL_SYNC_DIR=%LOCAL_BACKUP_BASE_DIR%\Server2Backups"
set "SERVER2_FINGERPRINT=ssh-ed25519 255 fingerprint-sever-2" 

:: --- LOGGING SETTINGS ---
set "LOG_DIR=%LOCAL_BACKUP_BASE_DIR%\Logs"
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (set current_date=%%d%%c%%b%%a)
for /f "tokens=1-3 delims=:. " %%a in ('time /t') do (set current_time=%%a%%b%%c)
set "LOG_FILE=%LOG_DIR%\sync_log_%current_date%_%current_time%.log"

:: --- NEW: Specific log file for WinSCP's detailed output, now in the same Logs folder ---
set "WINSCP_DETAILED_LOG=%LOG_DIR%\WinSCP_Detailed_Sync_Log_%current_date%_%current_time%.log"

:: ==============================================================================
:: === END OF CONFIGURATION SECTION ===
:: ==============================================================================

:: Ensure the log directory exists
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

:: --- NEW: Create WinSCP's detailed log file here after the log directory is confirmed ---
:: This ensures the file exists before WinSCP tries to write to it.
type nul > "%WINSCP_DETAILED_LOG%" 2>&1

:: ==============================================================================
:: === MAIN EXECUTION SECTION ===
:: ==============================================================================

echo [%DATE% %TIME%] --- Starting combined cloud backup sync script --- >> "%LOG_FILE%" 2>&1

:: Ensure the base local backup directory exists
if not exist "%LOCAL_BACKUP_BASE_DIR%" (
    mkdir "%LOCAL_BACKUP_BASE_DIR%" >> "%LOG_FILE%" 2>&1
    if %errorlevel% neq 0 (
        echo ERROR: Failed to create base local backup directory "%LOCAL_BACKUP_BASE_DIR%". Exiting script. >> "%LOG_FILE%" 2>&1
        goto :EOF
    )
)

:: Call the sync function for each configured server
:: SERVER 1
call :SYNC_SERVER "%SERVER1_USER%" "%SERVER1_IP%" "%SERVER1_REMOTE_BACKUP_DIR%" "%SERVER1_SSH_KEY%" "%SERVER1_LOCAL_SYNC_DIR%" "Server1" "%SERVER1_FINGERPRINT%"

:: SERVER 2 (Uncomment the line below and configure SERVER2_ variables above to enable)
call :SYNC_SERVER "%SERVER2_USER%" "%SERVER2_IP%" "%SERVER2_REMOTE_BACKUP_DIR%" "%SERVER2_SSH_KEY%" "%SERVER2_LOCAL_SYNC_DIR%" "Server2" "%SERVER2_FINGERPRINT%"

echo [%DATE% %TIME%] --- Combined cloud backup sync script finished --- >> "%LOG_FILE%" 2>&1

goto :EOF

:: --- CORE SYNC FUNCTION ---
:SYNC_SERVER
set "CURRENT_SERVER_USER=%~1"
set "CURRENT_SERVER_IP=%~2"
set "CURRENT_REMOTE_BACKUP_DIR=%~3"
set "CURRENT_SSH_KEY=%~4"
set "CURRENT_LOCAL_SYNC_DIR=%~5"
set "SERVER_NAME=%~6"
set "CURRENT_FINGERPRINT=%~7"

echo [%DATE% %TIME%] Starting sync for %SERVER_NAME% (%CURRENT_SERVER_IP%) >> "%LOG_FILE%" 2>&1

:: --- Creating local sync directory if it doesn't exist ---
echo --- Creating local sync directory for %SERVER_NAME% if it doesn't exist --- >> "%LOG_FILE%" 2>&1
if not exist "%CURRENT_LOCAL_SYNC_DIR%" (
    mkdir "%CURRENT_LOCAL_SYNC_DIR%" >> "%LOG_FILE%" 2>&1
    if %errorlevel% neq 0 (
        echo ERROR: Failed to create local sync directory for %SERVER_NAME%. Exiting sync for this server. >> "%LOG_FILE%" 2>&1
        goto :EOF
    )
)

echo --- WinSCP command for %SERVER_NAME% --- >> "%LOG_FILE%" 2>&1

:: Call WinSCP.com with the command file, passing variables
:: Now using the separate WINSCP_DETAILED_LOG for WinSCP's internal output
"%WINSCP_PATH%" /ini=nul /log="%WINSCP_DETAILED_LOG%" /command ^
    "option batch abort" ^
    "option confirm off" ^
    "open sftp://%CURRENT_SERVER_USER%@%CURRENT_SERVER_IP% -hostkey=""%CURRENT_FINGERPRINT%"" -privatekey=""%CURRENT_SSH_KEY%""" ^
    "synchronize local -delete ""%CURRENT_LOCAL_SYNC_DIR%"" ""%CURRENT_REMOTE_BACKUP_DIR%/""" ^
    "close" ^
    "exit" >> "%LOG_FILE%" 2>&1 2>&1

set "LAST_ERROR_LEVEL=%errorlevel%"

if %LAST_ERROR_LEVEL% equ 0 (
    echo [%DATE% %TIME%] Sync for %SERVER_NAME% completed successfully. >> "%LOG_FILE%" 2>&1
) else (
    echo [%DATE% %TIME%] ERROR: Sync for %SERVER_NAME% failed with error code %LAST_ERROR_LEVEL%. >> "%LOG_FILE%" 2>&1
    echo Please check the connection, SSH key, and remote path. Ensure SSH fingerprint is correct. >> "%LOG_FILE%" 2>&1
	echo For detailed WinSCP errors, check: %WINSCP_DETAILED_LOG% >> "%LOG_FILE%" 2>&1
)
goto :EOF

endlocal
```


