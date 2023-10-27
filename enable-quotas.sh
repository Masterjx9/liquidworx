#!/bin/bash

# Function to check if quotas are enabled
check_quotas_enabled() {
  mount_output=$(mount | grep ' / ')
  if [[ $mount_output == *"usrquota"* && $mount_output == *"grpquota"* ]]; then
    return 0
  else
    return 1
  fi
}

# Function to enable quotas
enable_quotas() {
  # Backup /etc/fstab
  cp /etc/fstab /etc/fstab.bak

  # Update /etc/fstab to add usrquota and grpquota options
  sed -i '/ \/\ / s/defaults/defaults,usrquota,grpquota/' /etc/fstab

  # Remount the filesystem
  mount -o remount /

  # Check if quotas are now enabled
  if ! check_quotas_enabled; then
    echo "Failed to enable quotas. Please check the system manually."
    exit 1
  fi

  # Create and enable quotas
  quotacheck -cugvm /
  quotaon /
}

# Main script execution
if check_quotas_enabled; then
  echo "Quotas are already enabled."
else
  echo "Quotas are not enabled. Enabling now..."
  enable_quotas
  echo "Quotas have been successfully enabled."
fi
