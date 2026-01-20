#!/bin/bash

# Force RTX 3060 to be primary
export WLR_DRM_DEVICES=/dev/dri/card1:/dev/dri/card0
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export LIBVA_DRIVER_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1

# RTX 3060 specific
export NVIDIA_DRIVER_CAPABILITIES=all
export MOZ_ENABLE_WAYLAND=1
export WLR_RENDERER=vulkan  # RTX 3060 has good Vulkan support

exec Hyprland
