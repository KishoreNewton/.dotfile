#!/bin/bash

echo "Installing all available fonts with icon support on Arch Linux..."

# Update package database
sudo pacman -Syu --noconfirm

# Install all font packages from official repositories
sudo pacman -S --noconfirm \
  adobe-source-code-pro-fonts \
  adobe-source-han-sans-fonts \
  adobe-source-han-serif-fonts \
  adobe-source-sans-fonts \
  adobe-source-serif-fonts \
  cantarell-fonts \
  gnu-free-fonts \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-emoji \
  noto-fonts-extra \
  otf-cormorant \
  otf-latin-modern \
  otf-latinmodern-math \
  terminus-font \
  tex-gyre-fonts \
  ttf-anonymous-pro \
  ttf-apple-emoji \
  ttf-arphic-ukai \
  ttf-arphic-uming \
  ttf-bitstream-vera \
  ttf-caladea \
  ttf-carlito \
  ttf-cascadia-code \
  ttf-cormorant \
  ttf-croscore \
  ttf-dejavu \
  ttf-droid \
  ttf-fantasque-sans-mono \
  ttf-fira-code \
  ttf-fira-mono \
  ttf-fira-sans \
  ttf-font-awesome \
  ttf-hack \
  ttf-ibm-plex \
  ttf-inconsolata \
  ttf-indic-otf \
  ttf-jetbrains-mono \
  ttf-joypixels \
  ttf-junicode \
  ttf-khmer \
  ttf-lato \
  ttf-liberation \
  ttf-linux-libertine \
  ttf-monofur \
  ttf-opensans \
  ttf-proggy-clean \
  ttf-roboto \
  ttf-roboto-mono \
  ttf-sarasa-gothic \
  ttf-sazanami \
  ttf-tibetan-machine \
  ttf-ubuntu-font-family \
  ttf-ubuntu-mono-nerd \
  wqy-microhei \
  wqy-zenhei

# Install AUR helper if not already installed (using yay as an example)
if ! command -v yay &> /dev/null; then
  echo "Installing yay AUR helper..."
  sudo pacman -S --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi

# Install additional icon fonts and font packages from AUR
yay -S --noconfirm \
  all-repository-fonts \
  ttf-material-design-icons-git \
  otf-nerd-fonts-fira-code \
  ttf-nerd-fonts-symbols \
  nerd-fonts-complete \
  ttf-weather-icons \
  ttf-symbola \
  ttf-devicons \
  ttf-icomoon-feather \
  ttf-ionicons \
  ttf-feather \
  ttf-fork-awesome \
  ttf-material-icons \
  ttf-iosevka \
  ttf-iosevka-nerd \
  ttf-twemoji \
  ttf-baekmuk \
  ttf-comic-neue \
  ttf-envy-code-r \
  ttf-impallari-cantora \
  ttf-input \
  ttf-league-gothic \
  ttf-league-script \
  ttf-mononoki \
  ttf-ms-fonts \
  ttf-oswald \
  ttf-quintessential \
  ttf-signika \
  ttf-symbola \
  awesome-terminal-fonts \
  otf-droid-nerd \
  otf-firamono-nerd \
  otf-overpass-nerd

# Install patched Nerd Fonts for additional icon support
yay -S --noconfirm \
  ttf-meslo-nerd-font-powerlevel10k \
  nerd-fonts-dejavu-complete \
  nerd-fonts-fira-code \
  nerd-fonts-hack \
  nerd-fonts-inconsolata \
  nerd-fonts-jetbrains-mono \
  nerd-fonts-roboto-mono \
  nerd-fonts-source-code-pro \
  nerd-fonts-ubuntu-mono

# Update font cache
echo "Updating font cache..."
fc-cache -fv

echo "Font installation completed! Your system now has all available fonts with icon support."
