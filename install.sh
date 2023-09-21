#!/bin/bash

# List of packages to install
pacman_packages=(
    alacritty
    htop
    neofetch
    neovim
    thunar
    pavucontrol
    blueman
    slock
    arandr
    code
    ranger
    stow
    feh
    picom
    ttf-jetbrains-mono-nerd
)

aur_packages=(
    i3-gaps-rounded-git
)

echo "Updating package database..."
sudo pacman -Sy

echo "Installing Pacman packages..."
sudo pacman -S "${pacman_packages[@]}"

echo "Installing yay"
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si && cd .. && rm -rf yay-bin

echo "Installing AUR packages..."
yay -S --needed "${aur_packages[@]}"


# Get the directory where this script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# List of subdirectories containing dotfiles to be installed
config_dirs=("alacritty" "i3" "i3status" "picom")  # Add more directories as needed

# Loop through the subdirectories and use stow to install dotfiles
for dir in "${config_dirs[@]}"; do
    echo "Installing dotfiles in $dir..."
    stow -d "$script_dir" -t "$HOME" "$dir"
done

echo "Installation complete."