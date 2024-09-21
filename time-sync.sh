#!/bin/bash

set -euo pipefail

# Function to set the time zone
set_timezone() {
    local timezone="$1"
    echo "Setting time zone to $timezone..."
    timedatectl set-timezone "$timezone"
}

# Function to set the system time from WorldTimeAPI JSON response
set_time_from_api() {
    echo "Attempting to set system time from WorldTimeAPI..."

    # Fetch the current time in ISO format from the API
    RESPONSE=$(curl -s http://worldtimeapi.org/api/timezone/Europe/Zurich)

    if [[ -n "$RESPONSE" ]]; then
        # Extract the datetime field
        CURRENT_TIME=$(echo "$RESPONSE" | grep -oP '"datetime":"\K[^"]+')
        if [[ -n "$CURRENT_TIME" ]]; then
            echo "Setting system time to: $CURRENT_TIME"
            # Convert ISO format to a format acceptable by the date command
            FORMATTED_TIME=$(date -d "$CURRENT_TIME" +"%Y-%m-%d %H:%M:%S")
            sudo date -s "$FORMATTED_TIME"
        else
            echo "Failed to extract datetime from API response."
            exit 1
        fi
    else
        echo "Failed to retrieve data from WorldTimeAPI."
        exit 1
    fi
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
    set_timezone "Europe/Zurich"
    set_time_from_api
    enable_ntp
    wait_for_sync
    display_time
    echo "Time setup completed with Zurich time zone and automatic synchronization."
}

# Run the main function
main
