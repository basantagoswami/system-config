if ! command -v sway > /dev/null 2>&1; then
    sudo apt install sway
else
    echo "Sway already installed, skipping."
fi
