#!/bin/bash

# Define the log file
LOG_FILE="wardragon_signalhound_audit.log"

# Start logging
exec > >(tee -a $LOG_FILE) 2>&1

echo "============================="
echo " Wardragon OS Signal Hound Audit"
echo "============================="
echo ""

# 1. List the /bin directory
echo "Listing /bin directory..."
ls -l /bin
echo ""

# 2. System Information
echo "Gathering system information..."
echo "OS Details: $(uname -a)"
echo "Distribution Info: $(lsb_release -a)"
echo "Kernel Version: $(uname -r)"
echo "CPU Info: $(lscpu | grep 'Model name')"
echo "Total Memory: $(grep MemTotal /proc/meminfo | awk '{print $2 / 1024 " MB"}')"
echo "Available Disk Space: $(df -h / | grep '/' | awk '{print $4}')"
echo ""

# 3. Check for Signal Hound Devices
echo "Checking if Signal Hound BB60C or BB60D is connected..."
if lsusb | grep -i "2817:0005" >/dev/null 2>&1; then
    echo "Signal Hound BB60C/BB60D device detected."
else
    echo "No Signal Hound BB60C/BB60D device detected."
fi
echo ""

# 4. Check if Spike software is installed
echo "Checking for Signal Hound Spike software..."
if command -v spike >/dev/null 2>&1 || [ -d "/usr/local/lib/Spike" ]; then
    echo "Signal Hound Spike software and drivers are installed."
else
    echo "Signal Hound Spike software and drivers are NOT detected."
fi
echo ""

# 5. List directories where Spike might be located
echo "Searching for Spike software in common directories..."
find / -type d -name "Spike" 2>/dev/null
echo ""

# 6. Check PATH and other environment variables
echo "Checking PATH environment variable..."
echo $PATH
echo ""

# 7. Verifying USB connection quality
echo "Checking USB connection quality..."
lsusb -v | grep -i "Signal Hound" -A 10
echo ""

# 8. Suggest adding Spike to PATH (if not already there)
if ! command -v spike >/dev/null 2>&1; then
    echo "Spike is not in your PATH. Consider adding it for easier access."
    echo "You can add Spike to your PATH by editing your ~/.bashrc or ~/.profile file."
fi
echo ""

# 9. Log timestamp for future reference
echo "Audit completed on: $(date)"
echo ""

echo "============================="
echo " Audit Complete"
echo "============================="
