## Combined Docker Host Back-up Script

```bash
#!/bin/bash

# --- GLOBAL CONFIGURATION ---
# Base directory where all backups will be stored
BACKUP_BASE_DIR="/mnt/docker_backups" 
# Log file for the entire script
GLOBAL_LOG_FILE="${BACKUP_BASE_DIR}/combined_backup.log" 
# Current date and time for backup file naming
DATE=$(date +%Y%m%d_%H%M%S)
# Number of days to retain old backups
RETENTION_DAYS=7 

# --- EMAIL NOTIFICATION CONFIGURATION ---
# Your email address to receive notifications
NOTIFICATION_EMAIL="your_email@example.com" 
# Sender email address
SENDER_EMAIL="backup_server@yourdomain.com" 
EMAIL_SUBJECT_SUCCESS="[Docker Backup] SUCCESS: Daily Backup $DATE"
EMAIL_SUBJECT_FAILURE="[Docker Backup] FAILURE: Daily Backup $DATE"

# --- GLOBAL SCRIPT STATUS FLAGS ---
# Initial overall script status. Will be determined at the end based on internal flags.
SCRIPT_OVERALL_STATUS="SUCCESS"
# Internal flags to track if any critical errors or warnings occurred during execution.
SCRIPT_HAS_ERRORS="false"   # Set to 'true' if any critical error occurs.
SCRIPT_HAS_WARNINGS="false" # Set to 'true' if any non-critical warning occurs (only if no errors).

# --- MYSQL/MARIADB CONFIGURATION ---
# Define MySQL/MariaDB containers and associated databases for logical backup.
# Format: "CONTAINER_NAME:USER:PASSWORD:DB1,DB2,DB3"
#   - CONTAINER_NAME: The name of your Docker MySQL/MariaDB container.
#   - USER: The MySQL/MariaDB user with backup privileges.
#   - PASSWORD: The password for the specified user.
#   - DB1,DB2,DB3: A comma-separated list of specific databases to backup.
#                  Leave this field empty (e.g., "container:::"), to backup ALL
#                  user databases (excluding 'information_schema', 'performance_schema', 'mysql', 'sys').
MYSQL_CONTAINERS=(
    "my_mysql_container:root:mysecretpassword:mydatabase1,mydatabase2"
    "my_mariadb_container:admin:anotherpassword:" # Example: Backs up all databases for this container
)

# --- POSTGRESQL CONFIGURATION ---
# Define PostgreSQL containers and associated databases for logical backup (custom format).
# Format: "CONTAINER_NAME:USER:PASSWORD:DB1,DB2,DB3"
#   - CONTAINER_NAME: The name of your Docker PostgreSQL container.
#   - USER: The PostgreSQL user with backup privileges.
#   - PASSWORD: The password for the specified user.
#   - DB1,DB2,DB3: A comma-separated list of specific databases to backup.
#                  Leave this field empty (e.g., "container::password:"), to backup ALL
#                  user databases (excluding 'template0', 'template1', 'postgres').
POSTGRES_CONTAINERS=(
    "my_postgres_container:postgres:password123:mydb1,mydb2"
    "another_pg_container:pgadmin:securepass:myotherdb"
    "yet_another_pg:specific_user:very_strong_pass:" # Example: Backs up all databases for this container
)
# NOTE ON PASSWORDS: Storing passwords directly in the script is generally not ideal for high-security environments.
# For single-server setups, this is common. For increased security, consider Docker Secrets or environment variables
# sourced from restricted files.

# --- NAMED DOCKER VOLUMES CONFIGURATION ---
# Define a list of specific named Docker volumes to back up.
DOCKER_VOLUME_NAMES=(
    "my_app_data"
    "another_important_volume"
    # "a_missing_volume" # Example: If this volume doesn't exist, it will trigger a warning.
)
# Directory for named volume backups
DOCKER_VOLUMES_BACKUP_DIR="${BACKUP_BASE_DIR}/docker_volumes"

# --- DOCKER COMPOSE STACKS CONFIGURATION ---
# Base directory where your Docker Compose stack subfolders are located (e.g., /docker).
# Each subfolder is considered a separate Docker Compose stack.
BASE_DOCKER_COMPOSE_DIR="/docker" 
# Define a list of specific Docker Compose stack configurations to back up.
# Format: "STACK_NAME:STOP_AND_START"
#   - STACK_NAME: The name of the Docker Compose stack (must match the folder name under BASE_DOCKER_COMPOSE_DIR).
#   - STOP_AND_START: 'true' or 'false'.
#       - 'true': The stack will be stopped before backup (docker compose down) and started afterwards (docker compose up -d).
#                 This is recommended for databases or applications with active writes to ensure a consistent backup.
#                 Causes temporary downtime.
#       - 'false': The stack will NOT be stopped/started. Backup will be performed while it's running.
#                  Avoids downtime but may result in inconsistent data for actively writing services.
TARGET_DOCKER_COMPOSE_STACKS=(
    "my_web_app:true"          # This stack will be stopped/started for backup
    "database_service:true"    # This stack will be stopped/started for backup
    "monitoring_stack:false"   # This stack will NOT be stopped/started
    "kavita:true"              # Example for your reported Kavita stack
    # "a_missing_stack:true"   # Example: If this stack directory doesn't exist, it will trigger a warning.
)
# Directory for Docker Compose stack backups
DOCKER_COMPOSE_BACKUP_DIR="${BACKUP_BASE_DIR}/docker_compose_stacks"

# --- AUXILIARY FUNCTIONS ---

# Logs messages to the global log file and stdout
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$GLOBAL_LOG_FILE"
}

# Sets the internal error flag
set_overall_failure() {
    SCRIPT_HAS_ERRORS="true"
    log_message "A critical error occurred. Setting internal error flag."
}

# Sets the internal warning flag (only if no critical errors have occurred)
set_overall_warning() {
    if [ "$SCRIPT_HAS_ERRORS" = "false" ]; then # Only set warning if no errors are present
        SCRIPT_HAS_WARNINGS="true"
        log_message "A warning occurred. Setting internal warning flag."
    fi
}

# Creates a directory if it does not exist. Exits script on failure.
create_dir_if_not_exists() {
    local dir_path="$1"
    if [ ! -d "$dir_path" ]; then
        mkdir -p "$dir_path"
        if [ $? -eq 0 ]; then
            log_message "Directory '$dir_path' created successfully."
        else
            log_message "ERROR: Could not create directory '$dir_path'. Script will exit."
            set_overall_failure # This is a critical infrastructure error
            send_notification # Send failure notification immediately
            exit 1 # Exit immediately if base directories cannot be created
        fi
    fi
}

# --- BACKUP FUNCTIONS ---

# Backs up MySQL/MariaDB databases
backup_mysql() {
    local container_info="$1"
    IFS=':' read -r CONTAINER_NAME USER PASSWORD DATABASES <<< "$container_info"
    log_message "Starting MySQL/MariaDB logical backup for container: $CONTAINER_NAME"

    local container_backup_dir="${BACKUP_BASE_DIR}/mysql/${CONTAINER_NAME}"
    create_dir_if_not_exists "$container_backup_dir"

    local DB_LIST=()
    if [ -z "$DATABASES" ]; then
        # Get all databases (excluding system dbs)
        DB_LIST=$(docker exec "$CONTAINER_NAME" mysql -u "$USER" -p"$PASSWORD" -BNe "SHOW DATABASES" | grep -v "information_schema\|performance_schema\|mysql\|sys")
    else
        IFS=',' read -ra DB_LIST <<< "$DATABASES"
    fi

    if [ -z "$DB_LIST" ]; then
        log_message "     WARNING: No databases found or specified for container $CONTAINER_NAME. Skipping MySQL/MariaDB backup for this container."
        set_overall_warning
        return 0
    fi

    for DB_NAME in $DB_LIST; do
        log_message "   - Backing up database: $DB_NAME (SQL format)"
        local BACKUP_FILE="${container_backup_dir}/${DB_NAME}_${DATE}.sql"
        docker exec "$CONTAINER_NAME" mysqldump -u "$USER" -p"$PASSWORD" "$DB_NAME" > "$BACKUP_FILE"
        if [ $? -eq 0 ]; then
            log_message "     Backup for $DB_NAME completed successfully: $BACKUP_FILE"
        else
            log_message "     ERROR backing up $DB_NAME in container $CONTAINER_NAME."
            set_overall_failure 
        fi
    done
    log_message "MySQL/MariaDB backup for container '$CONTAINER_NAME' finished."
}

# Backs up PostgreSQL databases
backup_postgresql() {
    local container_info="$1"
    # Parse container info into CONTAINER_NAME, USER, PASSWORD, and DATABASES
    IFS=':' read -r CONTAINER_NAME USER PASSWORD DATABASES <<< "$container_info"
    log_message "Starting PostgreSQL logical backup for container: $CONTAINER_NAME"

    local container_backup_dir="${BACKUP_BASE_DIR}/postgresql/${CONTAINER_NAME}"
    create_dir_if_not_exists "$container_backup_dir"

    local DB_LIST=()
    if [ -z "$DATABASES" ]; then
        # Get all databases (excluding template0, template1, postgres)
        # Set PGPASSWORD for the psql command to list databases
        PGPASSWORD="$PASSWORD" docker exec "$CONTAINER_NAME" psql -U "$USER" -t -c "SELECT datname FROM pg_database WHERE datistemplate = false;" > /tmp/pg_db_list.txt 2>&1
        if [ $? -ne 0 ]; then
            log_message "     ERROR: Could not list databases for container $CONTAINER_NAME. Check user/password or container status."
            log_message "       PSQL Error Output: $(cat /tmp/pg_db_list.txt 2>/dev/null)"
            rm -f /tmp/pg_db_list.txt
            set_overall_failure
            return 1
        fi
        DB_LIST=$(grep -v "postgres" /tmp/pg_db_list.txt | sed 's/ //g')
        rm -f /tmp/pg_db_list.txt
    else
        IFS=',' read -ra DB_LIST <<< "$DATABASES"
    fi

    if [ -z "$DB_LIST" ]; then
        log_message "     WARNING: No databases found or specified for container $CONTAINER_NAME. Skipping PostgreSQL backup for this container."
        set_overall_warning
        return 0
    fi

    for DB_NAME in $DB_LIST; do
        log_message "   - Backing up database: $DB_NAME (Custom format)"
        local BACKUP_FILE="${container_backup_dir}/${DB_NAME}_${DATE}.dump"
        # Export PGPASSWORD specifically for the pg_dump command within this function scope
        PGPASSWORD="$PASSWORD" docker exec "$CONTAINER_NAME" pg_dump -U "$USER" -F c -Z 9 "$DB_NAME" > "$BACKUP_FILE"
        if [ $? -eq 0 ]; then
            log_message "     Backup for $DB_NAME completed successfully: $BACKUP_FILE"
        else
            log_message "     ERROR backing up $DB_NAME in container $CONTAINER_NAME."
            set_overall_failure
        fi
    done
    log_message "PostgreSQL backup for container '$CONTAINER_NAME' finished."
}

# Backs up named Docker volumes
backup_docker_volume() {
    local VOLUME_NAME="$1"
    log_message "Starting backup for Docker volume: $VOLUME_NAME"

    local volume_backup_dir="${DOCKER_VOLUMES_BACKUP_DIR}/${VOLUME_NAME}"
    create_dir_if_not_exists "$volume_backup_dir"

    local BACKUP_FILE="${volume_backup_dir}/${VOLUME_NAME}_${DATE}.tar.gz"

    # Check if the volume exists
    if ! docker volume inspect "$VOLUME_NAME" &>/dev/null; then
        log_message "   WARNING: Volume '$VOLUME_NAME' does not exist. Skipping backup."
        set_overall_warning # Modified to warning, as it's a configurable item not found
        return 1 # Exit this function, but not the whole script
    fi

    log_message "   - Creating archive for volume '$VOLUME_NAME'..."
    # Use a temporary container to access volume content and archive it
    # Mount the volume to /volume_data in the temporary container
    # Mount the backup destination to /backup_output in the temporary container
    docker run --rm -v "$VOLUME_NAME":/volume_data -v "${volume_backup_dir}":/backup_output \
           ubuntu:latest tar -czf /backup_output/"$(basename "$BACKUP_FILE")" -C /volume_data .
    
    if [ $? -eq 0 ]; then
        log_message "     Backup for volume '$VOLUME_NAME' completed successfully: $BACKUP_FILE"
    else
        log_message "     ERROR backing up volume '$VOLUME_NAME'."
        set_overall_failure
    fi
    log_message "Backup for volume '$VOLUME_NAME' finished."
}

# Backs up a single Docker Compose stack
backup_docker_compose_stack() {
    local stack_config="$1" # e.g., "my_web_app:true"
    IFS=':' read -r STACK_NAME STOP_START_FLAG <<< "$stack_config" # Parse stack name and flag

    local STACK_PATH="${BASE_DOCKER_COMPOSE_DIR}/${STACK_NAME}" # Construct path from base dir and stack name

    log_message "Starting backup for Docker Compose stack: $STACK_NAME (path: $STACK_PATH, Stop/Start: $STOP_START_FLAG)"

    local stack_backup_dir="${DOCKER_COMPOSE_BACKUP_DIR}/${STACK_NAME}"
    create_dir_if_not_exists "$stack_backup_dir"

    local BACKUP_FILE="${stack_backup_dir}/${STACK_NAME}_${DATE}.tar.gz"

    # --- Pre-check: Verify stack directory and compose file existence ---
    if [ ! -d "$STACK_PATH" ]; then
        log_message "   WARNING: Stack directory '$STACK_NAME' (path: '$STACK_PATH') does not exist. Skipping backup."
        set_overall_warning
        return 1 # Exit this function, but not the whole script
    fi
    if [ ! -f "${STACK_PATH}/docker-compose.yml" ] && [ ! -f "${STACK_PATH}/docker-compose.yaml" ]; then
        log_message "   WARNING: Stack directory '$STACK_PATH' exists but does not contain a docker-compose.yml or .yaml file. Skipping backup."
        set_overall_warning
        return 1 # Exit this function, but not the whole script
    fi

    # --- Conditional Stop/Start based on STOP_START_FLAG ---
    if [ "$STOP_START_FLAG" = "true" ]; then
        # --- STEP 1: Stop the Docker Compose stack for consistency ---
        log_message "   - Stopping stack '$STACK_NAME' in directory '$STACK_PATH'..."
        pushd "$STACK_PATH" > /dev/null # Enter the stack's directory
        docker compose down --remove-orphans # Stop services and remove orphaned containers
        EXIT_CODE_DOWN=$?
        popd > /dev/null # Exit the directory

        if [ $EXIT_CODE_DOWN -ne 0 ]; then
            log_message "   ERROR: Could not stop stack '$STACK_NAME'. Backup might be inconsistent. This is a critical error."
            set_overall_failure
            # We will continue with the backup, but mark the overall status as failure.
        else
            log_message "   Stack '$STACK_NAME' stopped successfully."
        fi
    else
        log_message "   - Stop/Start not enabled for stack '$STACK_NAME'. Backing up while running."
    fi

    # --- STEP 2: Create the archive ---
    log_message "   - Creating archive for stack '$STACK_NAME'..."
    tar -czf "$BACKUP_FILE" -C "$STACK_PATH" .

    if [ $? -eq 0 ]; then
        log_message "     Backup for stack '$STACK_NAME' completed successfully: $BACKUP_FILE"
    else
        log_message "     ERROR backing up stack '$STACK_NAME'."
        set_overall_failure
    fi

    # --- Conditional Start (only if it was stopped) ---
    if [ "$STOP_START_FLAG" = "true" ]; then
        log_message "   - Starting stack '$STACK_NAME' in directory '$STACK_PATH'..."
        pushd "$STACK_PATH" > /dev/null
        docker compose up -d
        EXIT_CODE_UP=$?
        popd > /dev/null

        if [ $EXIT_CODE_UP -ne 0 ]; then
            log_message "   ERROR: Could not start stack '$STACK_NAME' back up. This is a critical error."
            set_overall_failure
        else
            log_message "   Stack '$STACK_NAME' started successfully."
        fi
    fi

    log_message "Backup for stack '$STACK_NAME' finished."
}

# --- CLEANUP FUNCTION ---

# Cleans up old backups based on retention policy
cleanup_old_backups() {
    log_message "Starting cleanup of backups older than $RETENTION_DAYS days."

    # Clean up MySQL/MariaDB backups (.sql files)
    find "${BACKUP_BASE_DIR}/mysql" -type f -name "*.sql" -mtime +"$RETENTION_DAYS" -delete
    if [ $? -ne 0 ]; then set_overall_failure; log_message "Error during MySQL cleanup."; fi

    # Clean up PostgreSQL backups (.dump files)
    find "${BACKUP_BASE_DIR}/postgresql" -type f -name "*.dump" -mtime +"$RETENTION_DAYS" -delete
    if [ $? -ne 0 ]; then set_overall_failure; log_message "Error during PostgreSQL cleanup."; fi

    # Clean up named Docker volume backups (.tar.gz files)
    find "${DOCKER_VOLUMES_BACKUP_DIR}" -type f -name "*.tar.gz" -mtime +"$RETENTION_DAYS" -delete
    if [ $? -ne 0 ]; then set_overall_failure; log_message "Error during Docker volumes cleanup."; fi

    # Clean up Docker Compose stack backups (.tar.gz files)
    find "${DOCKER_COMPOSE_BACKUP_DIR}" -type f -name "*.tar.gz" -mtime +"$RETENTION_DAYS" -delete
    if [ $? -ne 0 ]; then set_overall_failure; log_message "Error during Docker Compose stacks cleanup."; fi

    log_message "Old backup cleanup completed."
}

# --- NOTIFICATION FUNCTION ---

# Sends an email notification about the script's execution status
send_notification() {
    local subject
    
    # Determine the email subject based on the script's overall status
    if [ "$SCRIPT_OVERALL_STATUS" = "SUCCESS" ]; then
        subject="$EMAIL_SUBJECT_SUCCESS"
    elif [ "$SCRIPT_OVERALL_STATUS" = "WARNING" ]; then
        subject="[Docker Backup] WARNING: Daily Backup $DATE"
    else
        # If not SUCCESS and not WARNING, it must be FAILURE
        subject="$EMAIL_SUBJECT_FAILURE"
    fi

    # Include the last 100 lines of the global log file in the email body
    mail_body=$(tail -n 100 "$GLOBAL_LOG_FILE")
    
    # The email message body, which includes the overall status dynamically
    mail_message="Overall backup status: $SCRIPT_OVERALL_STATUS\n\nLast 100 lines from log:\n\n$mail_body"

    # Send the email using the 'mail' command
    echo -e "$mail_message" | mail -s "$subject" -r "$SENDER_EMAIL" "$NOTIFICATION_EMAIL"

    # Log whether the email was sent successfully
    if [ $? -eq 0 ]; then
        log_message "Email notification sent to $NOTIFICATION_EMAIL with subject: '$subject'."
    else
        log_message "ERROR: Could not send email notification to $NOTIFICATION_EMAIL."
    fi
}

# --- MAIN EXECUTION ---

log_message "--- Combined Docker Backup Script - START ($DATE) ---"

# Ensure base backup directory exists
create_dir_if_not_exists "$BACKUP_BASE_DIR"

# --- 1. MySQL/MariaDB Backups ---
log_message "--- Starting MySQL/Mariadb backups ---"
create_dir_if_not_exists "${BACKUP_BASE_DIR}/mysql"
for container in "${MYSQL_CONTAINERS[@]}"; do
    backup_mysql "$container"
done
log_message "--- MySQL/Mariadb backups finished ---"

# --- 2. PostgreSQL Backups ---
log_message "--- Starting PostgreSQL backups ---"
create_dir_if_not_exists "${BACKUP_BASE_DIR}/postgresql"
for container in "${POSTGRES_CONTAINERS[@]}"; do
    backup_postgresql "$container"
done
log_message "--- PostgreSQL backups finished ---"

# --- 3. Named Docker Volumes Backups ---
log_message "--- Starting Named Docker Volume backups ---"
create_dir_if_not_exists "${DOCKER_VOLUMES_BACKUP_DIR}"
if [ ${#DOCKER_VOLUME_NAMES[@]} -eq 0 ]; then
    log_message "No named Docker volumes defined in DOCKER_VOLUME_NAMES. Skipping this section."
    set_overall_warning
else
    for volume_name in "${DOCKER_VOLUME_NAMES[@]}"; do
        backup_docker_volume "$volume_name"
    done
fi
log_message "--- Named Docker Volume backups finished ---"

# --- 4. Docker Compose Stacks Backups ---
log_message "--- Starting Docker Compose Stacks backups ---"
create_dir_if_not_exists "${DOCKER_COMPOSE_BACKUP_DIR}"
if [ ${#TARGET_DOCKER_COMPOSE_STACKS[@]} -eq 0 ]; then
    log_message "No Docker Compose stacks defined in TARGET_DOCKER_COMPOSE_STACKS. Skipping this section."
    set_overall_warning
else
    # Loop through each stack configuration (e.g., "my_web_app:true")
    for stack_config in "${TARGET_DOCKER_COMPOSE_STACKS[@]}"; do
        backup_docker_compose_stack "$stack_config" # Pass the full config string
    done
fi
log_message "--- Docker Compose Stacks backups finished ---"

# --- Cleanup Old Backups ---
log_message "--- Starting cleanup of old backups ---"
cleanup_old_backups
log_message "--- Cleanup finished ---"

# Determine final script status based on flags
# Errors take precedence over warnings.
if [ "$SCRIPT_HAS_ERRORS" = "true" ]; then
    SCRIPT_OVERALL_STATUS="FAILURE"
elif [ "$SCRIPT_HAS_WARNINGS" = "true" ]; then
    SCRIPT_OVERALL_STATUS="WARNING"
else
    SCRIPT_OVERALL_STATUS="SUCCESS"
fi

log_message "--- Combined Docker Backup Script - END ($DATE) ---"

# Send final notification
send_notification

exit 0 # Script exits with success code
```

### How to Use the Combined Script

## Save the Script:

Save the content above into a file, for example, `combined_docker_backup.sh`

## Make it Executable:

```bash
chmod +x combined_docker_backup.sh
```

## Configure the Script:

Open the script in a text editor and carefully review the `--- GLOBAL CONFIGURATION ---` and subsequent configuration sections

- `BACKUP_BASE_DIR`: Set the main directory where all your backups will go.

- `NOTIFICATION_EMAIL, SENDER_EMAIL`: Crucial for receiving notifications. Make sure your Linux server is set up to send emails (e.g., ssmtp configured with Gmail as discussed previously).

- `MYSQL_CONTAINERS`: List your MySQL/MariaDB containers with their user, password, and specific databases (or leave databases empty for all).

- `POSTGRES_CONTAINERS`: List your PostgreSQL containers with their user and specific databases (or empty for all).

- `PGPASSWORD_PG`: Set your PostgreSQL password here if required. If not, leave it empty.

- `DOCKER_VOLUME_NAMES`: List the exact names of the Docker volumes you want to back up.

- `BASE_DOCKER_COMPOSE_DIR`: Set the root directory where your Docker Compose stack folders reside (e.g., /docker).

- `TARGET_DOCKER_COMPOSE_STACKS`: List the exact folder names of the Docker Compose stacks you want to back up.

## Test the Script

```bash
./combined_docker_backup.sh
```

- Check the `GLOBAL_LOG_FILE` (e.g., `/mnt/docker_backups/combined_backup.log`) for any errors or warnings.

- Verify that backup files are created in the correct directories within `BACKUP_BASE_DIR`.

- Check your email for the notification.

## Schedule with Cron

Once you're confident the script runs correctly, schedule it with `cron` for daily execution.

- `crontab -e`
- Add the following line to the crontab file, replacing `/path/to/your/script/combined_docker_backup.sh` with the actual full path: 
  
```bash
0 2 * * * /path/to/your/script/combined_docker_backup.sh > /dev/null 2>&1
```