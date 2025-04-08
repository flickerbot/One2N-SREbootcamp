#!/bin/bash
# Supports Ubuntu/Debian, CentOS/RHEL, and macOS

set -e  # Exit on error

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to display messages
print_message() { 
    echo "$1"
   
}

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command_exists apt-get; then
        OS="debian"
    elif command_exists yum || command_exists dnf; then
        OS="rhel"
    else
        print_message "Unsupported Linux distribution. Please install manually."
        exit 1
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    if ! command_exists brew; then
        print_message "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
else
    print_message "Unsupported operating system: $OSTYPE. Please install manually."
    exit 1
fi

# Install VirtualBox
install_virtualbox() {
    print_message "Installing VirtualBox..."
    
    if [[ "$OS" == "debian" ]]; then
        sudo apt-get update
        sudo apt-get install -y virtualbox
    elif [[ "$OS" == "rhel" ]]; then
        sudo yum install -y epel-release
        sudo yum install -y kernel-devel kernel-headers make patch gcc
        sudo yum install -y VirtualBox
    elif [[ "$OS" == "macos" ]]; then
        brew install --cask virtualbox
    fi
}

# Install Vagrant
install_vagrant() {
    print_message "Installing Vagrant..."
    
    if [[ "$OS" == "debian" ]]; then
        sudo apt-get update
        sudo apt-get install -y curl
        curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
        sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
        sudo apt-get update
        sudo apt-get install -y vagrant
    elif [[ "$OS" == "rhel" ]]; then
        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
        sudo yum install -y vagrant
    elif [[ "$OS" == "macos" ]]; then
        brew install vagrant
    fi
}

# Verify installations
verify_installations() {
    print_message "Verifying installations..."
    
    if command_exists VBoxManage; then
        VBOX_VERSION=$(VBoxManage --version)
        echo "VirtualBox installed successfully (version: $VBOX_VERSION)"
    else
        echo "WARNING: VirtualBox installation might have failed."
    fi
    
    if command_exists vagrant; then
        VAGRANT_VERSION=$(vagrant --version)
        echo "Vagrant installed successfully ($VAGRANT_VERSION)"
    else
        echo "WARNING: Vagrant installation might have failed."
    fi
}

# Main execution
echo "Starting installation of VirtualBox and Vagrant"

install_virtualbox
install_vagrant
verify_installations

echo "Installation complete!"
