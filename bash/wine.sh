#!/bin/bash
# Script for downloading & installing wine on Debian based systems
# Originaly author: #ToDo: please write your information
# Modified by: Mobin Aydinfar <mobin@mobintestserver.ir>
# License: GPLv3+
# Project: https://github.com/qasem-talaee/wine-pyqt5

# Updating repos info using apt
sudo apt update
if [ $? -ne 0 ]  ; then
  #echo "[INFO] apt update is Done!"
  exit 0
fi

# Installing recommended packages (apt-transport-https & ...)
sudo apt install software-properties-common apt-transport-https wget -y
if [ $? -ne 0 ]  ; then
  #echo "[INFO] Installing recommended packages is Done!"
  exit 0
fi

# Add i386 packages for wine, Required!
# ToDo: Find a way to detect ARM systems
sudo dpkg --add-architecture i386
if [ $? -ne 0 ]  ; then
  #echo "[INFO] Adding i386 repos is Done!"
  exit 0
fi

# You have two way for downloading and installing wine:
# 1. Using wine in official repos, its default & usually there is a very old version of wine in it.
# 2. Using wine repo on ubuntu/debian. for this, you must uncomment its & commnet #1 installing commands

# 2(Advanced):

# Downloading wine repo info for apt
# ToDo: Find a way to detect distro & auto setting $1 & $2
# $1 = ubuntu  ## Distro name (ubuntu, debian, devuan &...)
# S2 = jammy ## Distro code name (jammy, bullseye, ceres & ...)
#wget -nc https://dl.winehq.org/wine-builds/"$1"/dists/"$2"/winehq-"$2".sources
#if [ $? -ne 0 ]  ; then
#  #echo "[INFO] Downloading wine repo info is Done!"
#  exit 0
#fi

# Adding wine repo info to apt sources
#sudo mv winehq-"$2".sources /etc/apt/sources.list.d/
#if [ $? -ne 0 ]  ; then
#  #echo "[INFO] Adding wine repo info to apt sources is Done!"
#  exit 0
#fi

# Downloading winehq keyring for verify packages from wine repo
#wget -nc https://dl.winehq.org/wine-builds/winehq.key
#if [ $? -ne 0 ]  ; then
#  #echo "[INFO] Downloading winehq keyring is Done!"
#  exit 0
#fi

# Adding winehq.key to keyrings
# apt-key is Deprecated. copyring [file].key to /etc/share/keyrings/ to adding keyring on apt
#sudo mv winehq.key /usr/share/keyrings/winehq-archive.key
#if [ $? -ne 0 ]  ; then
#  #echo "[INFO] Adding winehq keyring is Done!"
#  exit 0
#fi

# Updating repo info
#sudo apt update
#if [ $? -ne 0 ]  ; then
#  #echo "[INFO] apt-update is Done!"
#  exit 0
#fi

# Installing winehq-[staging or devel or stable]
# By Default, installing winehq-staging
# $3 = staging
#sudo apt install winehq-"$3" --install-recommends

# 1 (Default):
sudo apt install --install-recommends wine-stable -y
if [ $? -ne 0 ]  ; then
  #echo "[INFO] Installing wine is Done!"
  exit 0
fi

# Installing Mesa vulkan driver & dxvk for wine
# ToDo: Find a way to detect nouveau for not installing mesa-vulkan-drivers & dxvk (nouveau does not support Vulkan!)
# ToDo: Find a way to detect NVIDIA Proprietary driver. its not using mesa-vulkan-driver!
sudo apt install mesa-vulkan-drivers mesa-vulkan-drivers:i386 libvulkan1 libvulkan1:i386 *vulkan* *dxvk* -y
if [ $? -ne 0 ]  ; then
  #echo "[INFO] Installing vulkan driver & dxvk is Done!"
  exit 0
fi

# Checking wine version
wine --version
