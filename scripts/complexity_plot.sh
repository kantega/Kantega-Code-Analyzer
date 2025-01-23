#!/usr/bin/env bash

REPO_DIR=$(git rev-parse --show-toplevel)
KCA_DIR="$REPO_DIR/.kca"
logfile="$KCA_DIR/git_log.txt"

echo "1. Looking for git log"

if [ ! -e "$logfile" ]
then
    echo "No git log found, please run kca_init"
    exit 1
fi

echo "2. git log found"

valgt_fil=$1

# Method 1: Check if $1 is empty
if [ -z "$valgt_fil" ]; then
    echo "Error: No file parameter provided"
    exit 1
fi
echo "3. Generating complexity_trend csv for chosen file: $valgt_fil"

me=$0
kca_path=$(dirname "$me")

start_commit=$(git log --format="%h" | tail -n 1)
end_commit=$(git log --format="%h" | head -n 1)

valgt_fil_name=$(basename $valgt_fil)

csv_file=".kca/${valgt_fil_name}.complexity_trend.csv"

# Check if python3 is available
if command -v python3 &>/dev/null; then
    PYTHON_CMD=python3
# Check if python is available
elif command -v python &>/dev/null; then
    PYTHON_CMD=python
else
    echo "Error: Python is not installed."
    exit 1
fi

$PYTHON_CMD "$kca_path/../maat-scripts-python3/miner/git_complexity_trend.py" --file "$valgt_fil" --start "$start_commit" --end "$end_commit" > "$csv_file"

echo "4. Generating plot from complexity_trend csv"

png_file="${csv_file}.png"

$PYTHON_CMD "$kca_path/plotting/complexity_plot.py" "$csv_file" "$png_file"

echo "5. Plot generated, located at: $png_file"
