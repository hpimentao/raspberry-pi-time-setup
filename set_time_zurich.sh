#!/bin/bash

set -euo pipefail

# Function to check if timedatectl is available
check_timedatectl() {
    if ! command -v timedatectl >/dev/null 2>&1; then
        echo "Error: 'timedatectl' command not found. Please ensure systemd is installed."
        exit 1
    fi
}

# Function to check internet connectivity
check_internet() {
    echo "Checking internet connectivity..."
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; then
        echo "Internet is available."
    else
        echo "Error: Internet is not available. Please check your connection."
        exit 1
    fi
}

# Function to set the time zone
set_timezone() {
    local timezone="$1"
    echo "Setting time zone to $timezone..."
    timedatectl set-timezone "$timezone"
}

# Function to enable NTP synchronization
enable_ntp() {
    echo "Enabling NTP for automatic time synchronization..."
    timedatectl set-ntp true
}

# Function to wait for time synchronization
wait_for_sync() {
    echo "Waiting for time synchronization..."
    local max_attempts=10
    local attempt=1
    while [ "$(timedatectl show -p NTPSynchronized --value)" != "yes" ]; do
        if [ "$attempt" -ge "$max_attempts" ]; then
            echo "Error: Time synchronization failed after $max_attempts attempts."
            exit 1
        fi
        echo "Attempt $attempt/$max_attempts: Time not synchronized yet. Retrying in 5 seconds..."
        sleep 5
        attempt=$((attempt + 1))
    done
    echo "Time synchronized successfully."
}

# Function to display current time
display_time() {
    echo "Current date and time after synchronization:"
    timedatectl status | grep "Local time"
}

# Main script execution
main() {
    check_timedatectl
    check_internet
    set_timezone "Europe/Zurich"
    enable_ntp
    wait_for_sync
    display_time
    echo "Time setup completed with Zurich time zone and automatic synchronization."
}

# Run the main function
main
