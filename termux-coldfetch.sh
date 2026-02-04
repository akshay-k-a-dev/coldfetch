#!/data/data/com.termux/files/usr/bin/bash

CYAN="\033[1;36m"
RESET="\033[0m"

is_termux() {
    [[ "$PREFIX" == *"com.termux"* ]]
}

get_os() {
    ANDROID_VER=$(getprop ro.build.version.release 2>/dev/null)
    DEVICE=$(getprop ro.product.model 2>/dev/null)
    echo -e "${CYAN}OS:${RESET} Android $ANDROID_VER ($DEVICE)"
}

get_kernel() {
    echo -e "${CYAN}Kernel:${RESET} $(uname -r)"
}

get_uptime() {
    echo -e "${CYAN}Uptime:${RESET} $(uptime | awk -F, '{print $1}' | sed 's/.*up //')"
}

get_shell() {
    echo -e "${CYAN}Shell:${RESET} $SHELL"
}

get_cpu() {
    CPU_MODEL=$(grep -m 1 'Hardware' /proc/cpuinfo | awk -F: '{print $2}' | xargs)
    CPU_CORES=$(nproc)
    echo -e "${CYAN}CPU:${RESET} $CPU_MODEL ($CPU_CORES cores)"
}

get_memory() {
    free -h | awk '/Mem:/ {
        printf "'${CYAN}'Memory:'${RESET}' %s / %s\n", $3, $2
    }'
}

get_storage() {
    echo -e "${CYAN}Storage:${RESET}"
    df -h ~/storage/shared 2>/dev/null || df -h /
}

get_packages() {
    COUNT=$(pkg list-installed 2>/dev/null | wc -l)
    echo -e "${CYAN}Packages:${RESET} $COUNT (Termux)"
}

get_battery() {
    LEVEL=$(termux-battery-status 2>/dev/null | grep percentage | grep -o '[0-9]*')
    STATUS=$(termux-battery-status 2>/dev/null | grep status | cut -d '"' -f4)

    if [ -n "$LEVEL" ]; then
        echo -e "${CYAN}Battery:${RESET} $LEVEL% ($STATUS)"
    fi
}

coldfetch() {
    clear
    echo -e "${CYAN}=== Termux System Info ===${RESET}"

    get_os
    get_kernel
    get_uptime
    get_shell
    get_cpu
    get_memory
    get_storage
    get_packages
    get_battery
}

coldfetch
