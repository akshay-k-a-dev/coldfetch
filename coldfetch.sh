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

# Function to display ASCII art logo based on OS
display_logo() {
    case "$OS_NAME" in
        *"Ubuntu"*)
            echo -e "${CYAN}
            .-/+oossssoo+/-.               
        \`:+ssssssssssssssssss+:           
      -+ssssssssssssssssssyyssss+-        
    .ossssssssssssssssssdMMMNysssso.      
   /ssssssssssshdmmNNmmyNMMMMhssssss/     
  +ssssssssshmydMMMMMMMNddddyssssssss+    
 /sssssssshNMMMyhhyyyyhmNMMMNhssssssss/   
.ssssssssdMMMNhsssssssssshNMMMdssssssss.  
+sssshhhyNMMNyssssssssssssyNMMMysssssss+ 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso 
+sssshhhyNMMNyssssssssssssyNMMMysssssss+ 
.ssssssssdMMMNhsssssssssshNMMMdssssssss.  
 /sssssssshNMMMyhhyyyyhmNMMMNhssssssss/   
  +ssssssssshmydMMMMMMMNddddyssssssss+    
   /ssssssssssshdmmNNmmyNMMMMhssssssss/     
    .ossssssssssssssssssdMMMNysssso.      
      -+ssssssssssssssssssyyssss+-        
        \`:+ssssssssssssssssss+:           
            .-/+oossssoo+/-.               
${RESET}"
            ;;
        *"Arch"*)
            echo -e "${CYAN}
      /\                      
     /  \   Arch Linux        
    / /\ \                    
   / ____ \                   
  /_/    \_\                  
${RESET}"
            ;;
        *"Fedora"*)
            echo -e "${CYAN}
          ▄▄▄▄▄▄▄▄▄▄▄  
         █           █ 
         █    Fedora  █
         █           █ 
          ▀▀▀▀▀▀▀▀▀▀▀  
${RESET}"
            ;;
        *"Debian"*)
            echo -e "${CYAN}
       _,met\$\$\$\$\$gg.          
    ,g\$\$\$\$\$\$\$\$\$\$\$\$\$P.       
  ,g\$\$P\"\"       \"\"\"Y\$\$.\".    
 ,\$\$P'              \`C\$\$C    
,\$\$P       ,ggs.     \`W\$\$    
d\$\$'     ,\$P\"\'   .    \$\$\$    
\$\$\$P      d\$'     ,    \$\$P    
\$\$\$\$c    .\$\"    ,     d\$\$'    
 \`Y\$\$\$b   \`.'   ,      \$\$P     
   \`\"Y\$\$b       ,     d\$\$'     
      \`\"Y\$\$b,       ,d\$\$'      
         \`\"Y\$\$b,   ,d\$\$'       
            \`\"Y\$\$b,d\$\$'        
               \`\"Y\$\$'          
                  \$\$            
                  \$\$            
                  \"\"            
${RESET}"
            ;;
        *"CentOS"*)
            echo -e "${CYAN}
                 ..            
               .PLTJ.          
              <><><><>         
     KKSSV' 4KKK LJ KKKL.      
     KKV,  4KKKK LJ KKKK.      
     V'   4KKKKK LJ KKKK.      
         .KKKKK' LJ 'KKKK.     
 L.     .KKKK'   LJ   'KKK     
 'M.    'KE'     LJ    'K.     
  'W.   '         J     '      
   'W.             J           
    '                E         
${RESET}"
            ;;
        *"Manjaro"*)
            echo -e "${CYAN}
██████████████████  ████████  
██████████████████  ████████  
██████████████████  ████████  
██████████████████  ████████  
████████            ████████  
████████  ████████  ████████  
████████  ████████  ████████  
████████  ████████  ████████  
████████  ████████  ████████  
████████  ████████  ████████  
████████  ████████  ████████  
████████  ████████  ████████  
████████  ████████  ████████  
████████  ████████  ████████  
████████  ████████  ████████  
████████  ████████  ████████  
${RESET}"
            ;;
        *)
            echo -e "${CYAN}
   _______    _       
  |__   __|  | |      
     | | ___ | | ___  
     | |/ _ \| |/ _ \ 
     | | (_) | |  __/ 
     |_|\___/|_|\___| 
${RESET}"
            ;;
    esac
}

# Function to display a progress bar
progress_bar() {
    local percentage=$1
    local label=$2
    local bar_length=20
    local filled=$((percentage * bar_length / 100))
    local empty=$((bar_length - filled))

    printf "  ${CYAN}%-10s ${RESET}[${GREEN}%-${filled}s${RESET}%*s] %3d%%\n" \
        "$label" "" $empty " " $percentage
}

# Function to display system information
coldfetch() {
    clear
    display_logo
    echo -e "${CYAN}=== System Information ===${RESET}"
    echo ""

    # Hostname and OS
    echo -e "  ${CYAN}Hostname:${RESET} $HOSTNAME"
    echo -e "  ${CYAN}OS:${RESET} $OS_PRETTY_NAME"
    echo -e "  ${CYAN}Kernel:${RESET} $(uname -r)"
    echo -e "  ${CYAN}Uptime:${RESET} $(uptime -p | sed 's/up //')"
    echo ""

    # Shell and Terminal
    echo -e "  ${CYAN}Shell:${RESET} $SHELL ($(bash --version | head -n 1))"
    echo -e "  ${CYAN}Terminal:${RESET} $TERM"
    echo ""

    # CPU and Fan Speed
    CPU_MODEL=$(grep 'model name' /proc/cpuinfo | uniq | awk -F: '{print $2}' | xargs)
    CPU_CORES=$(nproc --all)
    CPU_FREQ=$(lscpu | grep "CPU MHz" | awk '{print $3/1000 " GHz"}')
    echo -e "  ${CYAN}CPU:${RESET} 🖥️ $CPU_MODEL ($CPU_CORES cores @ $CPU_FREQ)"
    FAN_SPEED=$(sensors | grep -m 1 "fan" | awk '{print $2 " RPM"}')
    if [ -z "$FAN_SPEED" ]; then
        FAN_SPEED="Not available"
    fi
    echo -e "  ${CYAN}Fan Speed:${RESET} 🔧 $FAN_SPEED"
    echo ""

    # Memory
    RAM_TOTAL=$(free -b | grep Mem | awk '{print $2}')
    RAM_USED=$(free -b | grep Mem | awk '{print $3}')
    RAM_PERCENT=$((RAM_USED * 100 / RAM_TOTAL))
    RAM_TOTAL_HUMAN=$(free -h | grep Mem | awk '{print $2}')
    RAM_USED_HUMAN=$(free -h | grep Mem | awk '{print $3}')
    echo -e "  ${CYAN}Memory:${RESET} 💾 $RAM_USED_HUMAN / $RAM_TOTAL_HUMAN"
    progress_bar $RAM_PERCENT "RAM Usage"
    RAM_SPEED=$(sudo dmidecode --type memory | grep "Speed:" | grep -o '[0-9]\+' | head -n 1)
    echo -e "  ${CYAN}RAM Speed:${RESET} ⚡ ${RAM_SPEED} MHz"
    echo ""

    # GPU
    if command -v nvidia-smi > /dev/null; then
        GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader,nounits)
        GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
        GPU_FAN=$(nvidia-smi --query-gpu=fan.speed --format=csv,noheader,nounits)
        GPU_CLOCK=$(nvidia-smi --query-gpu=clocks.current.graphics --format=csv,noheader,nounits)
        GPU_VRAM_TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | awk '{print $1}')
        GPU_VRAM_USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits | awk '{print $1}')
        GPU_VRAM_PERCENT=$((GPU_VRAM_USED * 100 / GPU_VRAM_TOTAL))
        GPU_VRAM_TOTAL_HUMAN=$(awk "BEGIN {printf \"%.2f\", $GPU_VRAM_TOTAL / 1024}")" MiB"
        GPU_VRAM_USED_HUMAN=$(awk "BEGIN {printf \"%.2f\", $GPU_VRAM_USED / 1024}")" MiB"
        echo -e "  ${CYAN}Graphics:${RESET} 🎮 NVIDIA $GPU_NAME | Temp: ${GPU_TEMP}°C | Fan: ${GPU_FAN}% | Clock: ${GPU_CLOCK} MHz"
        echo -e "  ${CYAN}VRAM:${RESET} 💾 ${GPU_VRAM_USED_HUMAN} / ${GPU_VRAM_TOTAL_HUMAN}"
        progress_bar $GPU_VRAM_PERCENT "VRAM Usage"
    else
        GPU_INFO=$(lspci | grep -i 'vga\|3d\|2d')
        if [ -z "$GPU_INFO" ]; then
            GPU_INFO=$(lshw -C display | grep -i "product" | awk -F: '{print $2}' | xargs)
            if [ -z "$GPU_INFO" ]; then
                GPU_INFO="Integrated GPU"
            fi
        fi
        echo -e "  ${CYAN}Graphics:${RESET} 🎮 $GPU_INFO"
    fi
    echo ""

    # Storage
    echo -e "  ${CYAN}Storage:${RESET} 💾"
    lsblk -o NAME,SIZE,MODEL | grep -v "loop\|sr0"
    echo ""
}

# Main function to run coldfetch
coldfetch_main() {
    get_os_info
    coldfetch
}

# Run coldfetch
coldfetch_main
