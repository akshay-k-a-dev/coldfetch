#!/bin/bash

# Function to print a header
print_header() {
    echo -e "\n======================================="
    echo -e "$1"
    echo -e "=======================================\n"
}

# Function to install dependencies based on package manager
install_dependencies() {
    print_header "Installing Dependencies"
    echo "Checking for package manager..."

    if command -v apt-get > /dev/null; then
        PKG_MANAGER="apt-get"
        INSTALL_CMD="sudo apt-get install -y"
    elif command -v apt > /dev/null; then
        PKG_MANAGER="apt"
        INSTALL_CMD="sudo apt install -y"
    elif command -v aptitude > /dev/null; then
        PKG_MANAGER="aptitude"
        INSTALL_CMD="sudo aptitude install -y"
    elif command -v pacman > /dev/null; then
        PKG_MANAGER="pacman"
        INSTALL_CMD="sudo pacman -Syu --noconfirm"
    elif command -v dnf > /dev/null; then
        PKG_MANAGER="dnf"
        INSTALL_CMD="sudo dnf install -y"
    elif command -v yum > /dev/null; then
        PKG_MANAGER="yum"
        INSTALL_CMD="sudo yum install -y"
    elif command -v zypper > /dev/null; then
        PKG_MANAGER="zypper"
        INSTALL_CMD="sudo zypper install -y"
    elif command -v eopkg > /dev/null; then
        PKG_MANAGER="eopkg"
        INSTALL_CMD="sudo eopkg install -y"
    elif command -v xbps-install > /dev/null; then
        PKG_MANAGER="xbps-install"
        INSTALL_CMD="sudo xbps-install -Sy"
    elif command -v emerge > /dev/null; then
        PKG_MANAGER="emerge"
        INSTALL_CMD="sudo emerge -av"
    else
        echo "Unsupported package manager. Please install dependencies manually."
        exit 1
    fi

    echo "Package manager found: $PKG_MANAGER"
    echo "Installing required packages..."
    $INSTALL_CMD bash coreutils util-linux procps dmidecode lm-sensors sudo hdparm

    if [ $? -eq 0 ]; then
        echo "Dependencies installed successfully."
    else
        echo "Failed to install dependencies. Please check your package manager and try again."
        exit 1
    fi

    echo "Configuring lm-sensors..."
    sudo sensors-detect --auto
    sudo service kmod start
}

# Function to install coldfetch script
install_coldfetch() {
    print_header "Installing coldfetch"
    sudo mkdir -p /opt/coldfetch
    sudo cp coldfetch.sh /opt/coldfetch/coldfetch
    sudo chmod +x /opt/coldfetch/coldfetch
    echo "coldfetch installed to /opt/coldfetch/coldfetch."
}

# Function to configure sudo permissions for coldfetch
configure_sudo_permissions() {
    print_header "Configuring sudo permissions for coldfetch"
    CURRENT_USER=$(whoami)
    echo "$CURRENT_USER ALL=(ALL) NOPASSWD: /opt/coldfetch/coldfetch" | sudo tee /etc/sudoers.d/coldfetch-sudo >/dev/null
    sudo chmod 440 /etc/sudoers.d/coldfetch-sudo
    echo "Sudo permissions configured for coldfetch."
}

# Function to create alias for coldfetch
create_coldfetch_alias() {
    print_header "Creating alias for coldfetch"
    if [ -f "$HOME/.bashrc" ]; then
        SHELL_RC="$HOME/.bashrc"
    elif [ -f "$HOME/.zshrc" ]; then
        SHELL_RC="$HOME/.zshrc"
    else
        echo "Shell configuration file not found. Please manually add alias for coldfetch."
        return
    fi

    echo "alias coldfetch='sudo /opt/coldfetch/coldfetch'" >> "$SHELL_RC"
    echo "Alias added for coldfetch in $SHELL_RC."
}

# Function to refresh alias database
refresh_alias_database() {
    print_header "Refreshing alias database"
    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    elif [ -f "$HOME/.zshrc" ]; then
        source "$HOME/.zshrc"
    else
        echo "Shell configuration file not found. Please manually refresh the alias database."
        return
    fi
    echo "Alias database refreshed."
}

# Main function to run installation steps
main() {
    install_dependencies
    install_coldfetch
    configure_sudo_permissions
    create_coldfetch_alias
    refresh_alias_database
    echo -e "\nInstallation completed successfully.\n"
}

# Run the main function
main
