# Essentials bootstrap

## Install git & paru

```sh
sudo pacman -S --needed git paru
```

## Clone your dotfiles repository into your home folder

```sh
git clone https://github.com/m-olej/dots.git ~/dotfiles
cd ~/dotfiles
```

## Load your GNOME/GTK dconf settings

```sh
dconf load / < system-state/dconf-settings.ini
```

# Apply dots

## 1. Make the script executable just in case Git dropped the permission

```sh
chmod +x dotmanager.sh
```

## 2. Run the apply command!

```sh
./dotmanager.sh apply
```

# Enable services

# Enable GDM (GNOME Display Manager)

```sh
sudo systemctl enable gdm.service
```

# Enable custom systemd services

```sh
systemctl --user daemon-reload
systemctl --user enable battery-alert.service
systemctl --user enable cliphist.service
systemctl --user enable hypridle.service
systemctl --user enable hyprpaper.service
systemctl --user enable spotify.service
systemctl --user enable ssh-agent.service
```


# Change default shell

```sh
# chsh -s $(which zsh)
```
