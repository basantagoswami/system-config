if ! command -v swaylock > /dev/null 2>&1; then
    sudo apt install swaylock
else
    echo "Swaylock already installed, skipping."
fi
