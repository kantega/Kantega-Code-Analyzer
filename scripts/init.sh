#!/usr/bin/env bash

REPO_DIR=$(git rev-parse --show-toplevel)

echo "Step 1: Creating .kca folder"
KCA_DIR="$REPO_DIR/.kca"
mkdir -p $KCA_DIR

echo "Step 2: Creating git log"
grep "$KCA_DIR/*" "$REPO_DIR/.git/info/exclude" > /dev/null || echo -e "\n$KCA_DIR/*\n" >> "$REPO_DIR/.git/info/exclude"
git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames > "$KCA_DIR/git_log.txt"

# Todo: Kjør maat summary
# Todo: verifisere?
