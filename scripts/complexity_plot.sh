#!/usr/bin/env bash

REPO_DIR=$(git rev-parse --show-toplevel)
KCA_DIR="$REPO_DIR/.kca"
logfile="$KCA_DIR/git_log.txt"

if [ ! -e "$logfile" ]
then
    echo "Du mangler en git log. Du må kjøre kca_init"
    exit 1
fi
echo "0. antar at man har kjørt kca_init og revisions analyse for å finne en fil å se på"

valgt_fil=$1
echo "1. generer complexity_trend csv for valgt fil: $valgt_fil"
read

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

echo "2. generer plot fra complexity_trend csv"
read

png_file="${csv_file}.png"

$PYTHON_CMD "$kca_path/plotting/complexity_plot.py" "$csv_file" "$png_file"

echo "3. vis hvor plot ligger"
echo "$png_file"
