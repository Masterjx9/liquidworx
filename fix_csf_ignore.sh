#!/bin/bash

# List of processes to ignore
PROCESSES_TO_IGNORE=(
    "/usr/local/interworx/mysql/sbin/mariadbd"
    "/usr/lib/systemd/systemd"
    "/opt/iworx/iworxphp82/root/usr/sbin/php-fpm"
    "/opt/iworx/iworxphp81/root/usr/sbin/php-fpm"
    "/opt/iworx/iworxphp80/root/usr/sbin/php-fpm"
    "/opt/iworx/iworxphp74/root/usr/sbin/php-fpm"
    "/opt/iworx/iworxphp73/root/usr/sbin/php-fpm"
    "/opt/iworx/iworxphp72/root/usr/sbin/php-fpm"
    "/opt/iworx/iworxphp71/root/usr/sbin/php-fpm"
    "/opt/iworx/iworxphp70/root/usr/sbin/php-fpm"
    "/opt/iworx/iworxphp56/root/usr/sbin/php-fpm"
    "/opt/iworx/iworxphp55/root/usr/sbin/php-fpm"
    "/opt/iworx/iworxphp53/root/usr/sbin/php-fpm"
    "/usr/bin/gpg-agent"
    "/usr/bin/python2.7"
)

# Path to CSF ignore file
CSF_PIGNORE="/etc/csf/csf.pignore"

# Command lines to ignore
COMMAND_LINES_TO_IGNORE=(
    "cmd:php-fpm: pool iworx-web"
)

# Function to add a command line to the ignore list
add_cmd_to_ignore_list() {
    local cmd=$1
    echo "cmd:$cmd" >> "$CSF_PIGNORE"
}

# Check if a command line is already in the ignore list
is_cmd_already_ignored() {
    local cmd=$1
    grep -Fxq "cmd:$cmd" "$CSF_PIGNORE"
}

# Adding command line ignores
for cmd in "${COMMAND_LINES_TO_IGNORE[@]}"; do
    if is_cmd_already_ignored "$cmd"; then
        echo "Command line $cmd is already in the ignore list."
    else
        add_cmd_to_ignore_list "$cmd"
        echo "Added $cmd to the CSF ignore list."
    fi
done

# Function to check if a process is already in the ignore list
is_already_ignored() {
    local process=$1
    grep -Fxq "exe:$process" "$CSF_PIGNORE"
}

# Function to add a process to the ignore list
add_to_ignore_list() {
    local process=$1
    echo "exe:$process" >> "$CSF_PIGNORE"
}

# Main script execution
if [ ! -f "$CSF_PIGNORE" ]; then
    echo "Error: CSF is not installed or csf.pignore file does not exist."
    exit 1
fi

# Adding a comment before the entries
echo -e "\n# Added entries from LiquidWorx script" >> "$CSF_PIGNORE"

for process in "${PROCESSES_TO_IGNORE[@]}"; do
    if is_already_ignored "$process"; then
        echo "Process $process is already in the ignore list."
    else
        add_to_ignore_list "$process"
        echo "Added $process to the CSF ignore list."
    fi
done

# Optionally, restart CSF to apply changes
read -p "Do you want to restart CSF to apply changes? (y/n): " restart_csf
if [ "$restart_csf" == "y" ]; then
    csf -r
    echo "CSF restarted."
else
    echo "Please remember to restart CSF to apply the changes."
fi
