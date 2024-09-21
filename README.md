
# Raspberry Pi Time Synchronization Script

This project provides a simple and effective way to automatically synchronize the system time on a Raspberry Pi. It is particularly useful for scenarios where the Raspberry Pi might boot up with an incorrect date and time, such as after being powered off for an extended period.

## Features

- Automatically sets the system time using an HTTP-based time API.
- Ensures accurate time synchronization by enabling NTP after the initial time setting.
- Supports multiple methods for setting the system time, including fallback mechanisms.
- Designed to work without a Real-Time Clock (RTC) module, making it ideal for use in environments where hardware constraints exist.

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/hpimentao/raspberry-pi-time-sync.git
   cd raspberry-pi-time-sync
   ```

2. **Make the Script Executable:**

   ```bash
   chmod +x time-sync.sh
   ```

3. **Run the Script:**

   ```bash
   sudo ./time-sync.sh
   ```

4. **Automate the Script at Boot (Optional):**

   To ensure the script runs automatically at boot, follow these steps:

   - **Move the Script to `/usr/local/bin`:**

     ```bash
     sudo mv time-sync.sh /usr/local/bin/time-sync.sh
     ```

   - **Create a Systemd Service File:**

     ```bash
     sudo nano /etc/systemd/system/time-sync.service
     ```

     Add the following content:

     ```ini
     [Unit]
     Description=Time Synchronization Script
     After=network-online.target
     Wants=network-online.target

     [Service]
     Type=oneshot
     ExecStart=/usr/local/bin/time-sync.sh

     [Install]
     WantedBy=multi-user.target
     ```

   - **Enable and Start the Service:**

     ```bash
     sudo systemctl daemon-reload
     sudo systemctl enable time-sync.service
     sudo systemctl start time-sync.service
     ```

   - **Verify Service Status:**

     ```bash
     systemctl status time-sync.service
     ```

## Usage

- The script is designed to run automatically at boot if configured as a systemd service.
- You can also run the script manually as needed to force a time update.

## Contributing

Feel free to submit issues and pull requests if you find any bugs or have suggestions for improvements.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

## Acknowledgments

Special thanks to the maintainers of WorldTimeAPI and other reliable time services that make this project possible.
