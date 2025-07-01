#!/bin/bash

# 杀死所有占用GPU的进程
kill -9 $(nvidia-smi --query-compute-apps=pid --format=csv,noheader | sort | uniq)

# 重置所有GPU
nvidia-smi --reset-gpu

# 清除内核模块
sudo rmmod nvidia_uvm
sudo rmmod nvidia_drm
sudo rmmod nvidia_modeset
sudo rmmod nvidia

# 重新加载模块
sudo modprobe nvidia
sudo modprobe nvidia_uvm
sudo modprobe nvidia_modeset
sudo modprobe nvidia_drm

# 清理缓存
sync; echo 3 | sudo tee /proc/sys/vm/drop_caches
