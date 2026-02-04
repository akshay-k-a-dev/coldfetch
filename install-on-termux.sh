#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "Installing coldfetch for Termux..."

# Update packages
pkg update -y

# Install required tools
pkg install -y coreutils procps util-linux termux-api

echo "Copying script..."

mkdir -p $PREFIX/bin
cp coldfetch-termux.sh $PREFIX/bin/coldfetch
chmod +x $PREFIX/bin/coldfetch

echo "Installation complete!"
echo "Run using: coldfetch"
