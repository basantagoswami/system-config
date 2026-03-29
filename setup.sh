#!/bin/bash
set -e

# Ask for password at the beginning so that everything after this works without having to be prompted for password
sudo -v

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install Nix
if ! command -v nix > /dev/null 2>&1; then
    sh "$REPO_DIR/install-nix.sh" --daemon
    echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
    sudo systemctl restart nix-daemon
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
else
    echo "Nix already installed, skipping."
fi

# Copy wallpaper
mkdir -p ~/.local/share/backgrounds
cp "$REPO_DIR/assets/background.jpg" ~/.local/share/backgrounds/background.jpg

# Install Nix packages
nix profile add "$REPO_DIR#default"

# Install packages that can't be installed via Nix for various reasons
sh $REPO_DIR/install-sway.sh
sh $REPO_DIR/install-swaylock.sh

# Stow dotfiles
for pkg in "$REPO_DIR/dotfiles"/*/; do
    stow -d "$REPO_DIR/dotfiles" -t ~ "$(basename "$pkg")"
done

# Install sway session wrapper for GDM
sudo cp "$REPO_DIR/sway-session" /usr/local/bin/sway-session
sudo chmod +x /usr/local/bin/sway-session
sudo cp "$REPO_DIR/sway-nix.desktop" /usr/share/wayland-sessions/sway-nix.desktop
