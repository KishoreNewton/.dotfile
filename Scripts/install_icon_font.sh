#!/bin/bash

# Check if yay is installed, if not install it
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    sudo pacman -S --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# Install official repository packages
echo "Installing packages from official repositories..."
sudo pacman -S --noconfirm \
    ttf-font-awesome \
    ttf-material-design-icons-desktop-git \
    noto-fonts-emoji \
    ttf-nerd-fonts-symbols \
    adobe-source-han-sans-otc-fonts \
    ttf-dejavu \
    ttf-liberation \
    noto-fonts

# Install AUR packages
echo "Installing packages from AUR..."
yay -S --noconfirm \
    ttf-material-icons-git \
    ttf-weather-icons \
    ttf-ionicons \
    ttf-icomoon-feather \
    ttf-octicons

# Update font cache
echo "Updating font cache..."
fc-cache -fv

echo "Font installation completed!"
echo "Please log out and log back in for changes to take effect."
