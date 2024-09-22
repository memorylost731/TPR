#!/bin/bash

# Update system and install base dependencies
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y build-essential git cmake python3-dev python3-pip mesa-utils

# Install ROCm dependencies
sudo apt-get install -y rocm-dkms rocm-libs rocm-dev

# Install ROCm TensorFlow dependencies
pip3 install tensorflow-rocm transformers deepspeed

# Install ROCm tools for development
sudo apt-get install -y rocblas hipcub rocprim rocrand miopen-hip

# Install additional libraries that might be needed for code development
pip3 install numpy scipy pandas matplotlib
