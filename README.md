
# Coldfetch

Coldfetch is a system information fetcher similar to `neofetch` and `screenfetch` with a very minimalistic and simple basic UI.

## Features

- Display system hostname
- Operating system details
- Kernel version
- System uptime
- Terminal information
- Shell details
- CPU details (model, cores, frequency)
- CPU fan speed
- Memory details (total, used, available)
- RAM speed
- GPU details (name, temperature, fan speed, clock, VRAM)
- Storage details (devices and sizes)
- Storage speed
- Distribution name
- Package manager information
- Number of installed packages
- Screen resolution
- System language

## Installation

To install Coldfetch, you can use the provided `install.sh` script. Clone the repository and run the script:

```bash
git clone https://github.com/Akshay-code-space/coldfetch.git
cd coldfetch
chmod +x install.sh
./install.sh
```

## Dependencies

Coldfetch relies on several system utilities to gather information. Ensure the following dependencies are installed on your system:

- `bash`
- `lsblk`
- `free`
- `dmidecode`
- `lscpu`
- `sensors`
- `nvidia-smi` (for NVIDIA GPUs)
- `amdgpu-pro` (for AMD GPUs)
- `lspci`
- `xdpyinfo`
- `hdparm`
- `awk`
- `grep`
- `hostname`
- `uptime`

## Usage

After installation, you can run Coldfetch by simply typing `coldfetch` in your terminal:

```bash
coldfetch
```

## Script Details

The Coldfetch script includes functions to gather and display various system information:

- `get_os_info()`: Retrieves the operating system information.
- `get_os()`: Displays the OS name and version.
- `get_kernel()`: Displays the kernel version.
- `get_uptime()`: Displays the system uptime.
- `get_terminal()`: Displays the terminal information.
- `get_shell()`: Displays the shell information.
- `get_cpu()`: Displays CPU details including model, cores, and frequency.
- `get_cpu_fan_speed()`: Displays the CPU fan speed.
- `get_memory()`: Displays memory usage details.
- `get_ram_speed()`: Displays the RAM speed.
- `get_gpu()`: Displays GPU details including name, temperature, fan speed, clock, and VRAM.
- `get_storage()`: Displays storage devices and their sizes.
- `get_storage_speed()`: Displays the speed of the storage devices.
- `get_distribution()`: Displays the Linux distribution name.
- `get_package_manager()`: Displays the package manager information.
- `get_number_of_packages()`: Displays the number of installed packages.
- `get_screen_resolution()`: Displays the screen resolution.
- `get_language()`: Displays the system language.

## Example Output

```
=== System Information ===
Hostname: server lin
OS: Fedora
Kernel: x.y.z
Uptime: 2 days, 2 hours
Terminal: xterm-256color
Shell: /bin/bash (GNU bash, version 5.0.17(1)-release)
CPU: Intel i5 8th (4 cores @ 2.4 GHz)
CPU Fan Speed: fan1: 1200 RPM
Memory: 4.5G / 16G (Available: 11G)
RAM Speed: 2400 MHz
Graphics: AMD RX 580 | Temp: 50°C | Fan: 30% | Clock: 1500 MHz | VRAM: 2G / 6G
Storage:
NAME   SIZE MODEL
sda    1.8T WDC WD2003FZEX-0
sdb    931G Samsung SSD 860
Storage Speed:
sda: Timing cached reads: 16722 MB in 2.00 seconds = 8363.24 MB/sec
sdb: Timing cached reads: 16916 MB in 2.00 seconds = 8470.13 MB/sec
Distribution: Fedora
Package Manager: DNF 4.2.17
Number of Packages: 1234 (Fedora)
Screen Resolution: 1920x1080
Language: en_US.UTF-8
```

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

This project was inspired by similar tools like `neofetch` and `screenfetch`.

