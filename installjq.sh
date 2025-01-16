#!/bin/bash

# Detecting if this is running in EC2 or not (as for testing locally)
check_if_ec2() {
    # Bring me the METADATA king!
    if curl --connect-timeout 3 http://169.254.169.254/latest/meta-data/ >/dev/null 2>&1; then
        echo "Running in EC2 environment"
        return 0
    else
        echo "Not running in EC2 environment"
        return 1
    fi
}

# Creatung local bin directory because I don't trust the EC2 instance to do it for me
mkdir -p "${HOME}/bin"

# And adding local bin to PATH if it's there
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "${HOME}/.bashrc"
    export PATH="${HOME}/bin:$PATH"
fi

# Setting up a check to see if the thing I'm about to install is lurking on the machine already
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Checking where this is running - EC2 or my local Mac
check_if_ec2

# Installing jq (if it's not already installed)
if ! command_exists jq; then
    echo "Installing jq..."
    
    # Downloading jq binary
    curl -Lo "${HOME}/bin/jq" "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64"
    
    # Making it executable
    chmod +x "${HOME}/bin/jq"
    
    # Verifing installation
    if command_exists jq; then
        echo "jq installed successfully!"
        jq --version
    else
        echo "Failed to install jq"
        exit 1
    fi
else
    echo "jq is already installed"
fi

# Voila!
echo '{"message": "Bootstrap script completed successfully! Voila!"}'
