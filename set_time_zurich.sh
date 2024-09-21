
#!/bin/bash

# Function to check internet connectivity
check_internet() {
    echo "Checking internet connectivity..."
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        echo "Internet is available."
    else
        echo "Internet is not available. Please check your connection."
        exit 1
    fi
}

# Set the time zone to Zurich
echo "Setting time zone to Zurich (Europe/Zurich)..."
sudo timedatectl set-timezone Europe/Zurich

# Enable NTP for automatic synchronization
echo "Enabling NTP for automatic time synchronization..."
sudo timedatectl set-ntp true

# Check internet connectivity before synchronization
check_internet

# Wait for time synchronization
echo "Synchronizing time with internet time servers..."
sleep 5  # Wait a few seconds to allow synchronization

# Verify the time synchronization
echo "Current date and time after synchronization:"
timedatectl status | grep "Local time"

echo "Time setup completed with Zurich time zone and automatic synchronization."
