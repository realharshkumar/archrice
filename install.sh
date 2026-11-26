#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

sudo pacman -S --needed --noconfirm git base-devel stow
sudo pacman -S --needed --noconfirm - < packages/native.txt

if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
  (cd /tmp/yay-bin && makepkg -si --noconfirm)
fi
yay -S --needed --noconfirm $(cat packages/aur.txt)

mkdir -p ~/Pictures/Screenshots
rm -f ~/.bashrc ~/.bash_profile   # remove defaults so stow can link ours
stow -t ~ home
