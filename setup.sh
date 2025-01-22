#!/usr/bin/env bash

echo "Initate KCA setup"
absolute_path=$(pwd)
# Create .bashrc if it doesn't exist
if [ ! -f ~/.bashrc ]; then
    echo "Creating .bashrc file for aliases"
    touch ~/.bashrc
fi

echo "Creating KCA aliases"
# Add alias for kca_init if it doesn't exist
if ! grep -q "alias kca_init=" ~/.bashrc; then
    echo "alias kca_init='$absolute_path/scripts/init.sh'" >> ~/.bashrc
fi

# Add alias for kca_hotspots if it doesn't exist
if ! grep -q "alias kca_hotspots=" ~/.bashrc; then
    echo "alias kca_hotspots='$absolute_path/scripts/hotspots.sh'" >> ~/.bashrc
fi

# Add alias for kca_complexity if it doesn't exist
if ! grep -q "alias kca_complexity=" ~/.bashrc; then
    echo "alias kca_complexity='$absolute_path/scripts/complexity_plot.sh'" >> ~/.bashrc
fi

source ~/.bashrc
echo "Setup complete"
