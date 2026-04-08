# Essentials bootstrap

## Install git & paru
sudo pacman -S --needed git paru

## Clone your dotfiles repository into your home folder
git clone https://github.com/m-olej/dots.git ~/dotfiles
cd ~/dotfiles

# Install default packages

## 1. Install all official repository packages
sudo pacman -S --needed - < system-state/pkglist-repo.txt

## 2. Install all AUR packages (CachyOS uses paru by default)
paru -S --needed - < system-state/pkglist-aur.txt

# Restore initial root config & system-state

## 1. Restore pacman/makepkg tweaks
sudo cp system-state/etc/pacman.conf /etc/
sudo cp system-state/etc/makepkg.conf /etc/

## 2. Load your GNOME/GTK dconf settings
dconf load / < system-state/dconf-settings.ini

# Apply dots

## 1. Make the script executable just in case Git dropped the permission
chmod +x dotmanager.sh

## 2. Run the apply command!
./dotmanager.sh apply

# Enable services

# Enable GDM (GNOME Display Manager)
sudo systemctl enable gdm.service

# Enable custom systemd services
systemctl --user daemon-reload
systemctl --user enable battery-alert.service
systemctl --user enable cliphist.service
systemctl --user enable hypridle.service
systemctl --user enable hyprpaper.service
systemctl --user enable polkitd.service
systemctl --user enable spotify.service
systemctl --user enable ssh-agent.service


# Change default shell
# chsh -s $(which zsh)
