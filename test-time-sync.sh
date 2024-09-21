#!/bin/bash

# Disable NTP synchronization
sudo timedatectl set-ntp false

# Set the system date to a past date
sudo date -s "2022-01-01 12:00:00"

# Display the system date after setting it
echo "System date after manual setting:"
date

# Run your time synchronization script
sudo /path/to/your/time-sync.sh

# Display the system date after running the script
echo "System date after running time-sync.sh:"
date

# Re-enable NTP synchronization
sudo timedatectl set-ntp true

# Verify NTP status
timedatectl status | grep "System clock synchronized"
