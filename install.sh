#!/bin/bash

# List of packages to install
packages=(
    alacritty
    htop
    neofetch
    neovim
    thunar
    pavucontrol
    slock
    arandr
    code
    ranger
    stow
    feh
    picom
    i3-gaps
    ttf-jetbrains-mono-nerd
)

# Update package database and install the packages
echo "Updating package database..."
sudo pacman -Sy

echo "Installing packages..."
sudo pacman -S "${packages[@]}"

echo "Installing yay"
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si && cd .. && rm -rf yay-bin

yay -S i3-gaps-rounded-git

echo "Installation complete."