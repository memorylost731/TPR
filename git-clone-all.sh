#!/bin/bash

# Create a directory for the projects if it doesn't exist
mkdir -p ~/Projects
cd ~/Projects

# Function to clone or update a repository
clone_or_update_repo() {
  repo_url=$1
  repo_name=$(basename "$repo_url" .git)
  
  if [ -d "$repo_name" ]; then
    echo "Updating $repo_name..."
    cd "$repo_name" && git pull origin main && cd ..
  else
    echo "Cloning $repo_name..."
    git clone "$repo_url"
  fi
}

# ROCm Repositories
clone_or_update_repo "https://github.com/RadeonOpenCompute/ROCm.git"
clone_or_update_repo "https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime.git"
clone_or_update_repo "https://github.com/RadeonOpenCompute/ROCm-Device-Libs.git"
clone_or_update_repo "https://github.com/RadeonOpenCompute/ROCm-CompilerSupport.git"
clone_or_update_repo "https://github.com/RadeonOpenCompute/ROCm-GPUDebugSDK.git"
clone_or_update_repo "https://github.com/RadeonOpenCompute/ROCr-Runtime.git"
clone_or_update_repo "https://github.com/RadeonOpenCompute/ROCclr.git"
clone_or_update_repo "https://github.com/RadeonOpenCompute/ROCm-Driver.git"

# HIP - Heterogeneous-Compute Interface for Portability
clone_or_update_repo "https://github.com/ROCm-Developer-Tools/HIP.git"

# TensorFlow ROCm repository
clone_or_update_repo "https://github.com/tensorflow/tensorflow.git"

# CodeGeeX (Assumed from the details)
clone_or_update_repo "https://github.com/THUDM/CodeGeeX.git"

# ROCm libraries and tools
clone_or_update_repo "https://github.com/ROCmSoftwarePlatform/rocBLAS.git"
clone_or_update_repo "https://github.com/ROCmSoftwarePlatform/rocFFT.git"
clone_or_update_repo "https://github.com/ROCmSoftwarePlatform/rocRAND.git"
clone_or_update_repo "https://github.com/ROCmSoftwarePlatform/rocThrust.git"
clone_or_update_repo "https://github.com/ROCmSoftwarePlatform/rocSPARSE.git"
clone_or_update_repo "https://github.com/ROCmSoftwarePlatform/MIOpen.git"

# Add more repositories as needed
clone_or_update_repo "https://github.com/ROCmSoftwarePlatform/rocPRIM.git"
clone_or_update_repo "https://github.com/ROCmSoftwarePlatform/rocSOLVER.git"
clone_or_update_repo "https://github.com/ROCmSoftwarePlatform/hipBLAS.git"

# Dependencies for ROCm components
clone_or_update_repo "https://github.com/RadeonOpenCompute/hcc.git"
clone_or_update_repo "https://github.com/ROCm-Developer-Tools/aomp.git"

echo "All repositories have been cloned or updated."
