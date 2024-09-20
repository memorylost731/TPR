#!/bin/bash

# Script Name: install_dev_tools.sh
# Description: Installs development and debugging tools from source.
# Log File
LOG_FILE=~/install_dev_tools.log

# Start logging
exec > >(tee -i "$LOG_FILE") 2>&1

echo "=== Development Tools Installation Started at $(date) ==="

# Step 1: Update and Upgrade the System
echo "Updating and upgrading the system..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Step 2: Install Essential Build Dependencies
echo "Installing essential build dependencies..."
sudo apt-get install -y build-essential cmake git wget unzip \
libcurl4-openssl-dev libssl-dev pkg-config python3-dev

# Step 3: Install Radare2 from Source
echo "Installing Radare2 from source..."
if [ -d ~/radare2_src ]; then
    echo "Radare2 source directory exists. Pulling latest changes..."
    cd ~/radare2_src
    git pull
else
    echo "Cloning Radare2 repository..."
    git clone https://github.com/radareorg/radare2.git ~/radare2_src
    cd ~/radare2_src
fi

echo "Building Radare2..."
sys/install.sh

echo "Radare2 installation completed."

# Verify Radare2 Installation
if command -v radare2 >/dev/null 2>&1; then
    echo "Radare2 installed successfully: $(radare2 -v)"
else
    echo "ERROR: Radare2 installation failed."
    exit 1
fi

# Step 4: Install Ghidra from Source
echo "Installing Ghidra from source..."
GITHUB_RELEASE_URL=$(curl -s https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest | grep browser_download_url | grep ghidra | grep zip | cut -d '"' -f 4)

if [ -z "$GITHUB_RELEASE_URL" ]; then
    echo "ERROR: Unable to fetch Ghidra download URL."
    exit 1
fi

echo "Downloading Ghidra from $GITHUB_RELEASE_URL..."
wget -O ~/ghidra.zip "$GITHUB_RELEASE_URL"

echo "Extracting Ghidra..."
unzip -o ~/ghidra.zip -d ~/
rm ~/ghidra.zip

# Create a symbolic link for easy access
if [ -d ~/ghidra_* ]; then
    GHIDRA_DIR=$(ls -d ~/ghidra_* | head -n1)
    ln -sf "$GHIDRA_DIR" ~/ghidra
    echo "Ghidra installed successfully at ~/ghidra"
else
    echo "ERROR: Ghidra extraction failed."
    exit 1
fi

# Verify Ghidra Installation
if [ -f ~/ghidra/ghidraRun ]; then
    echo "Ghidra installed successfully: $(~/ghidra/ghidraRun --version 2>/dev/null)"
else
    echo "ERROR: Ghidra installation failed."
    exit 1
fi

# Step 5: Install Exotic Debug Tools (Optional)
echo "Installing additional exotic debug tools..."

# Example: Installing Radiff2 (part of Radare2)
# Radiff2 is already installed with Radare2

# Add more exotic tools here as needed

echo "Exotic debug tools installation completed."

# Step 6: Install Python Development Packages
echo "Installing Python development packages..."
sudo pip3 install --upgrade pip
sudo pip3 install numpy scipy matplotlib numba pyqt5 h5py flask flask_socketio eventlet
sudo pip3 install dash

# Step 7: Remove dash_devices if Installed
echo "Removing dash_devices if installed..."
sudo pip3 uninstall -y dash_devices || echo "dash_devices not installed."

# Step 8: Ensure Execute Permissions on Critical Scripts
echo "Setting execute permissions on critical scripts..."
chmod +x ~/krakensdr_passive_radar/kraken_pr_start.sh
chmod +x ~/krakensdr_passive_radar/kraken_pr_stop.sh
chmod +x ~/krakensdr_passive_radar/heimdall_daq_fw/Firmware/daq_start_sm.sh
chmod +x ~/krakensdr_passive_radar/kraken_pr/gui_run.sh
chmod +x ~/krakensdr_passive_radar/krakensdr_pr/_UI/_web_interface/kraken_web_interface.py

echo "Execute permissions set successfully."

echo "=== Development Tools Installation Completed at $(date) ==="

