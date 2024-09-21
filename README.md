
# Raspberry Pi Time Setup Script for Zurich Time Zone

This repository provides a bash script to set up the date and time on a Raspberry Pi running Debian. The script sets the time zone to Zurich (Europe/Zurich) and ensures that the system time is automatically synchronized with internet time servers via NTP, eliminating the need for manual time entry.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Script Details](#script-details)
- [License](#license)

## Introduction

Keeping the correct date and time on your Raspberry Pi is crucial for various applications, especially those that rely on time-sensitive operations. This script automates the process of setting the time zone to Zurich and synchronizes the system time with internet time servers.

## Prerequisites

- Raspberry Pi running Debian-based OS.
- Internet connection for time synchronization.

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/raspberry-pi-time-setup.git
   ```

2. **Navigate to the Directory**

   ```bash
   cd raspberry-pi-time-setup
   ```

3. **Make the Script Executable**

   ```bash
   chmod +x set_time_zurich.sh
   ```

## Usage

Run the script with `sudo` to ensure it has the necessary permissions:

```bash
sudo ./set_time_zurich.sh
```

## Script Details


#### What the Script Does:

- **Check Internet Connectivity:**

  - Uses `ping` to verify that the Raspberry Pi is connected to the internet.
  - If no connection is detected, the script exits with a message.

- **Set Time Zone to Zurich:**

  - Executes `timedatectl set-timezone Europe/Zurich` to set the system time zone.

- **Enable NTP Synchronization:**

  - Ensures NTP is enabled with `timedatectl set-ntp true` for automatic time synchronization.

- **Synchronize Time:**

  - Waits for 5 seconds to allow the system to synchronize time with internet servers.

- **Display Current Time:**

  - Displays the updated local time to confirm successful synchronization.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
