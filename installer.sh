#!/bin/bash

# Set the URL of the exporter binary on GitHub
exporter_url="https://github.com/srkaviani/User-Monitoring/raw/main/UserResource"

# Set the installation directory
install_dir="/opt/user_resource"

# Set the systemd unit file path
unit_file="/etc/systemd/system/user_resource_exporter.service"

# Download the binary
echo "Downloading exporter binary..."
mkdir -p "$install_dir"
curl -L -o "$install_dir/exporter" "$exporter_url"
chmod +x "$install_dir/exporter"

# Create the systemd unit file
echo "Creating systemd unit file..."
cat <<EOF > "$unit_file"
[Unit]
Description=User Resource Exporter
After=network.target

[Service]
ExecStart=$install_dir/exporter
WorkingDirectory=$install_dir
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd manager
systemctl daemon-reload

# Enable and start the exporter service
echo "Enabling and starting the exporter service..."
systemctl enable user_resource_exporter
systemctl start user_resource_exporter

echo "User Resource Exporter has been installed, enabled, and started."
