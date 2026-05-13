#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

if [ "$EUID" -eq 0 ]; then
  echo -e "${RED}Please do not run this script as root. Run as your normal user. It will ask for sudo when needed.${NC}"
  exit 1
fi

# --- Visual Setup ---
GREEN='\033[1;32m'
BLUE='\033[1;34m'
RED='\033[1;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}  Starting Post-Rice Installer  ${NC}"
echo -e "${BLUE}=================================================${NC}\n"

# --- 0. Get package manager ---
echo -e "${GREEN}[0/5] Installing paru AUR helper...${NC}"
sudo pacman -Syu
sudo pacman -S --needed git paru

# --- 1. Install Packages ---
echo -e "${GREEN}[1/5] Installing System & AUR Packages...${NC}"

PACKAGES=(
    # Core Desktop & UI
    hyprland hypridle hyprlock hyprpaper 
    waybar rofi-wayland cliphist mako
    
    # TUI apps
    spotify-player wlctl btop glow bluetui
    
    # Productivity
    rnote obsidian wtfutil gtasks

    # Utilities
    lf jq grim swappy slurp nvim

    # Programming
    fnm uv rustup asdf
)

# Use paru to install all packages, skipping already installed ones
paru -S --needed --noconfirm "${PACKAGES[@]}"
 
# --- 2. Configuring GTK theme ---
echo -e "${GREEN}[2/5] Setting up GTK theme...${NC}"

# Safely write to AccountsService as root
cat <<EOF | sudo tee /var/lib/AccountsService/users/$USER > /dev/null
[User]
Session=hyprland-uwsm
Icon=/var/lib/AccountsService/icons/$USER
SystemAccount=false
EOF

sudo cp $HOME/dotfiles/wallpapers/prof.jpg /var/lib/AccountsService/icons/$USER

if [ ! -d "/usr/share/themes/Andromeda" ]; then
    sudo git clone https://github.com/EliverLara/Andromeda-gtk.git /usr/share/themes/Andromeda
fi

gsettings set org.gnome.desktop.interface gtk-theme "Andromeda"
gsettings set org.gnome.desktop.wm.preferences theme "Andromeda"

if [ -f "$HOME/dotfiles/system-state/dconf-settings.ini" ]; then
    dconf load / < "$HOME/dotfiles/system-state/dconf-settings.ini"
fi

# --- 3. System Permissions ---
echo -e "\n${GREEN}[3/5] Configuring Real-Time Audio Privileges...${NC}"
if groups "$USER" | grep &>/dev/null '\brealtime\b'; then
    echo "User is already in the 'realtime' group."
else
    sudo gpasswd -a "$USER" realtime
    echo "Added $USER to the realtime group."
fi


# --- 3. Executable Permissions ---
echo -e "\n${GREEN}[4/5] Setting Executable Permissions for Scripts...${NC}"

# Ensure directories exist before trying to chmod
[ -d "$HOME/.config/hypr/scripts" ] && chmod +x "$HOME"/.config/hypr/scripts/*.sh
[ -d "$HOME/.config/rofi" ] && chmod +x "$HOME"/.config/rofi/*.sh
[ -d "$HOME/.config/wtf/scripts" ] && chmod +x "$HOME"/.config/wtf/scripts/*.sh

# --- 5. Service Activation ---
echo -e "\n${GREEN}[5/5] Enabling System & User Services...${NC}"

systemctl --user daemon-reload
systemctl --user enable battery-alert.service
systemctl --user enable cliphist.service
systemctl --user enable hypridle.service
systemctl --user enable hyprpaper.service
systemctl --user enable spotify.service
systemctl --user enable ssh-agent.service

# System Services
sudo systemctl enable --now rtkit-daemon.service
sudo systemctl enable --now cronie.service

# User Services
systemctl --user daemon-reload

echo -e "\n${BLUE}=================================================${NC}"
echo -e "${GREEN}  Installation Complete!  ${NC}"
echo -e "${GREEN}  Restart system to see changes  ${NC}"
echo -e "${BLUE}=================================================${NC}\n"
