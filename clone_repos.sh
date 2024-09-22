#!/bin/bash

# List of repositories to clone
REPOS=(
    "https://github.com/RadeonOpenCompute/ROCm.git"
    "https://github.com/RadeonOpenCompute/ROCm-cmake.git"
    "https://github.com/RadeonOpenCompute/ROCm-Device-Libs.git"
    "https://github.com/RadeonOpenCompute/rocFFT.git"
    # Add more repositories as per your cvs file
)

# Directory where you want to clone the repos
BASE_DIR=~/Projects

# Clone all repos
for REPO in "${REPOS[@]}"; do
    git clone "$REPO" "$BASE_DIR"
done

echo "All repositories have been cloned."
