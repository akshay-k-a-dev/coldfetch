#!/bin/bash

# Colors
CYAN="\033[1;36m"
GREEN="\033[1;32m"
RESET="\033[0m"

# Function to get OS information
get_os_info() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS_NAME=$NAME
        OS_PRETTY_NAME=$PRETTY_NAME
    else
        OS_NAME=$(uname -s)
        OS_PRETTY_NAME=$OS_NAME
    fi
    HOSTNAME=$(hostname)
}

# Function to display system information
coldfetch() {
    clear
    echo -e "${CYAN}=== System Information ===${RESET}"
    echo -e "${CYAN}Hostname:${RESET} $HOSTNAME"
    get_os
    get_kernel
    get_uptime
    get_terminal
    get_shell
    get_cpu
    get_cpu_fan_speed
    get_memory
    get_ram_speed
    get_gpu
    get_storage
    get_storage_speed
    get_distribution
    get_package_manager
    get_number_of_packages
    get_screen_resolution
    get_language
}

# Function to get OS details
get_os() {
    echo -e "${CYAN}OS:${RESET} $OS_PRETTY_NAME"
}

# Function to get kernel details
get_kernel() {
    echo -e "${CYAN}Kernel:${RESET} $(uname -r)"
}

# Function to get uptime
get_uptime() {
    echo -e "${CYAN}Uptime:${RESET} $(uptime -p | sed 's/up //')"
}

# Function to get terminal details
get_terminal() {
    TERMINAL=$(echo $TERM)
    echo -e "${CYAN}Terminal:${RESET} $TERMINAL"
}

# Function to get shell details
get_shell() {
    echo -e "${CYAN}Shell:${RESET} $SHELL ($(bash --version | head -n 1))"
}

# Function to get CPU details
get_cpu() {
    CPU_MODEL=$(grep 'model name' /proc/cpuinfo | uniq | awk -F: '{print $2}' | xargs)
    CPU_CORES=$(nproc --all)
    CPU_FREQ=$(lscpu | grep "CPU MHz" | awk '{print $3/1000 " GHz"}')
    echo -e "${CYAN}CPU:${RESET} $CPU_MODEL ($CPU_CORES cores @ $CPU_FREQ)"
}

# Function to get CPU fan speed
get_cpu_fan_speed() {
    # Fetch fan speed using sensors
    FAN_SPEED=$(sensors | grep -m 1 "fan" | awk '{print $2 " RPM"}')
    if [ -z "$FAN_SPEED" ]; then
        FAN_SPEED="Not available"
    fi
    echo -e "${CYAN}CPU Fan Speed: ${RESET}$FAN_SPEED"
}

# Function to get memory details
get_memory() {
    RAM_TOTAL=$(free -h | grep Mem | awk '{print $2}')
    RAM_USED=$(free -h | grep Mem | awk '{print $3}')
    RAM_AVAILABLE=$(free -h | grep Mem | awk '{print $7}')
    echo -e "${CYAN}Memory:${RESET} $RAM_USED / $RAM_TOTAL (Available: $RAM_AVAILABLE)"
}

# Function to get RAM speed
get_ram_speed() {
    RAM_SPEED=$(sudo dmidecode --type memory | grep "Speed:" | grep -o '[0-9]\+' | head -n 1)
    echo -e "${CYAN}RAM Speed:${RESET} ${RAM_SPEED} MHz"
}

# Function to get GPU details
get_gpu() {
    if command -v nvidia-smi > /dev/null; then
        GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader,nounits)
        GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
        GPU_FAN=$(nvidia-smi --query-gpu=fan.speed --format=csv,noheader,nounits)
        GPU_CLOCK=$(nvidia-smi --query-gpu=clocks.current.graphics --format=csv,noheader,nounits)
        GPU_VRAM_TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | awk '{print $1/1024 " MiB"}')
        GPU_VRAM_USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits | awk '{print $1/1024 " MiB"}')
        echo -e "${CYAN}Graphics:${RESET} NVIDIA $GPU_NAME | Temp: ${GPU_TEMP}°C | Fan: ${GPU_FAN}% | Clock: ${GPU_CLOCK} MHz | VRAM: ${GPU_VRAM_USED} / ${GPU_VRAM_TOTAL}"
    elif command -v amdgpu-pro > /dev/null; then
        GPU_NAME=$(amdgpu-pro --query | grep 'Device' | awk -F': ' '{print $2}')
        GPU_TEMP=$(sensors | grep -i 'edge' | head -n 1 | awk '{print $2}')
        GPU_FAN=$(sensors | grep -i 'fan' | head -n 1 | awk '{print $2}')
        GPU_CLOCK=$(cat /sys/class/drm/card*/device/pp_dpm_sclk | grep '*' | awk '{print $2}')
        GPU_VRAM_TOTAL=$(grep 'Memory:' /opt/amdgpu/share/AMDGPUUsage | awk '{print $2}')
        GPU_VRAM_USED=$(grep 'Used Memory:' /opt/amdgpu/share/AMDGPUUsage | awk '{print $3}')
        echo -e "${CYAN}Graphics:${RESET} AMD $GPU_NAME | Temp: ${GPU_TEMP}°C | Fan: ${GPU_FAN} RPM | Clock: ${GPU_CLOCK} MHz | VRAM: ${GPU_VRAM_USED} / ${GPU_VRAM_TOTAL}"
    else
        GPU_INFO=$(lspci | grep -i 'vga\|3d\|2d')
        if [ -z "$GPU_INFO" ]; then
            GPU_INFO=$(lshw -C display | grep -i "product" | awk -F: '{print $2}' | xargs)
            if [ -z "$GPU_INFO" ]; then
                GPU_INFO="Integrated GPU"
            fi
        fi
        echo -e "${CYAN}Graphics:${RESET} $GPU_INFO"
    fi
}

# Function to display storage details
get_storage() {
    echo -e "${CYAN}Storage:${RESET}"
    lsblk -o NAME,SIZE,MODEL | grep -v "loop\|sr0"
}

# Function to display storage speed details
get_storage_speed() {
    STORAGE_DEVICES=$(lsblk -d -o NAME | grep -v "loop\|NAME\|sr0")
    for DEV in $STORAGE_DEVICES; do
        STORAGE_SPEED=$(sudo hdparm -tT /dev/$DEV | grep "Timing" | head -n 1)
        echo -e "${CYAN}${DEV}:${RESET} $STORAGE_SPEED"
    done
}

# Function to get distribution name
get_distribution() {
    echo -e "${CYAN}Distribution:${RESET} $OS_NAME"
}

# Function to get package manager details
get_package_manager() {
    if command -v apt > /dev/null; then
        PACKAGE_MANAGER="APT $(apt -v | head -n 1)"
    elif command -v pacman > /dev/null; then
        PACKAGE_MANAGER="Pacman $(pacman -V | head -n 1)"
    elif command -v rpm > /dev/null; then
        PACKAGE_MANAGER="RPM $(rpm --version | head -n 1)"
    elif command -v dnf > /dev/null; then
        PACKAGE_MANAGER="DNF $(dnf --version | head -n 1)"
    elif command -v zypper > /dev/null; then
        PACKAGE_MANAGER="Zypper $(zypper --version | head -n 1)"
    elif command -v eopkg > /dev/null; then
        PACKAGE_MANAGER="eopkg $(eopkg --version | head -n 1)"
    elif command -v xbps > /dev/null; then
        PACKAGE_MANAGER="XBPS $(xbps --version | head -n 1)"
    else
        PACKAGE_MANAGER="Unknown"
    fi
    echo -e "${CYAN}Package Manager:${RESET} $PACKAGE_MANAGER"
}

# Function to display number of installed packages
get_number_of_packages() {
    if command -v dpkg > /dev/null; then
        NUM_PACKAGES=$(dpkg-query -f '${binary:Package}\n' -W | wc -l)
        echo -e "${CYAN}Number of Packages:${RESET} $NUM_PACKAGES (Debian-based)"
    elif command -v rpm > /dev/null; then
        NUM_PACKAGES=$(rpm -qa | wc -l)
        echo -e "${CYAN}Number of Packages:${RESET} $NUM_PACKAGES (RPM-based)"
    elif command -v pacman > /dev/null; then
        NUM_PACKAGES=$(pacman -Q | wc -l)
        echo -e "${CYAN}Number of Packages:${RESET} $NUM_PACKAGES (Arch Linux)"
    else
        echo -e "${CYAN}Number of Packages:${RESET} Not available"
    fi
}

# Function to get screen resolution
get_screen_resolution() {
    SCREEN_RESOLUTION=$(xdpyinfo | grep dimensions | awk '{print $2}')
    echo -e "${CYAN}Screen Resolution:${RESET} $SCREEN_RESOLUTION"
}

# Function to get language details
get_language() {
    echo -e "${CYAN}Language:${RESET} $LANG"
}

# Main function to run coldfetch
coldfetch_main() {
    get_os_info
    coldfetch
}

# Run coldfetch
coldfetch_main
