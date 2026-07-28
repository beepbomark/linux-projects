#!/bin/bash

# Hardware Information Script
# Retrieves basic system and hardware information.
# The report is displayed in the terminal and saved to a file.

# Get the directory containing this script.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Hardware report output file.
OUTPUT_FILE="$SCRIPT_DIR/hardware_info.txt"

# Collect hardware information inside a function.
get_hardware_info() {

    echo "================================"
    echo "     SYSTEM HARDWARE INFO"
    echo "================================"

    # Record when the report was generated.
    echo
    echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"

    # Display hostname and kernel information.
    echo
    echo "System Information:"
    echo "Hostname: $(hostname)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"

    # Display CPU information.
    echo
    echo "CPU Information:"
    lscpu | grep -E 'Model name|Socket|Core|Thread|CPU\(s\)'

    # Display memory information.
    echo
    echo "Memory Information:"
    free -h

    # Display storage devices.
    echo
    echo "Storage Information:"
    lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS

    # Display PCI devices if lspci is available.
    echo
    echo "PCI Devices:"

    if command -v lspci > /dev/null 2>&1; then
        lspci
    else
        echo "lspci is not installed."
        echo "Install it with: sudo apt install pciutils"
    fi

    echo
    echo "================================"
    echo "     END OF HARDWARE INFO"
    echo "================================"
}

# Display the report and write it to the output file.
get_hardware_info | tee "$OUTPUT_FILE"

echo
echo "Hardware report saved to: $OUTPUT_FILE"