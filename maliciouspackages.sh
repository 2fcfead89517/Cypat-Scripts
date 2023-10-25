#!/bin/bash

# List of package names to search for
packages=("nmap" "john" "hydra" "ophcrack" "wireshark" "nginx")

# Loop through the list of package names
for package in "${packages[@]}"; do
    # Debug: Print the output of dpkg -l
    dpkg -l | grep "ii  $package"
    
    # Trim leading/trailing whitespace
    package=$(echo "$package" | xargs)
    
    if dpkg -l | grep -q "ii  $package"; then
        echo "$package is installed, removing..."
        if sudo apt-get remove --purge --auto-remove "$package"; then
            echo "Successfully removed $package."
        else
            echo "Failed to remove $package."
        fi
    else
        echo "$package is not installed."
    fi
done
