if ! command -v gtklock > /dev/null 2>&1; then
    sudo apt install gtklock
else
    echo "gtklock already installed, skipping."
fi
