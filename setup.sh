#!/bin/bash
set -e

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

# Install Sway
sh $REPO_DIR/install-sway.sh

# Copy wallpaper
mkdir -p ~/.local/share/backgrounds
cp "$REPO_DIR/assets/background.jpg" ~/.local/share/backgrounds/background.jpg

# Install Nix packages
nix profile add "$REPO_DIR#default"

# Stow dotfiles
for pkg in "$REPO_DIR/dotfiles"/*/; do
    stow -d "$REPO_DIR/dotfiles" -t ~ "$(basename "$pkg")"
done

# Install sway session wrapper for GDM
sudo cp "$REPO_DIR/sway-session" /usr/local/bin/sway-session
sudo chmod +x /usr/local/bin/sway-session
sudo cp "$REPO_DIR/sway-nix.desktop" /usr/share/wayland-sessions/sway-nix.desktop
