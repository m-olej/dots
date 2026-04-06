#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# ---------------------------------------------------------
# 🛠️ HARDCODED TARGETS
# ---------------------------------------------------------

# 1. Apps that live in ~/.config/
# Format -> "repo_folder_name:config_subfolder_path"
# If they are the same, you can just write "hypr"
CONFIG_APPS=(
    "hypr"
    "waybar"
    "nvim"
    "kitty"
    "wtf"
    "lf"
    "mako"
    "rofi"
    "spotify-player"
    "systemd-user:systemd/user"  
    "environment.d"
)

CONFIG_ROOT_FILES=(
    "zsh:.zshrc"
    "zsh:.p10k.zsh"
    "zsh:.zshenv"
)

# 2. Singular files that live in ~/ (Home directory)
# Format -> "repo_folder_name:actual_file_name"
HOME_FILES=(
)

HOME_APPS=(
    "zsh-d:.zshrc.d"
)


# ---------------------------------------------------------
# 🚀 LOGIC: INIT
# ---------------------------------------------------------
init_structure() {
    echo "🚀 Initializing dotfiles structure in $DOTFILES_DIR..."
    mkdir -p "$DOTFILES_DIR"

    # Handle ~/.config/ apps
    for entry in "${CONFIG_APPS[@]}"; do
        # Parse mapping (e.g. "systemd-user:systemd/user")
        if [[ "$entry" == *":"* ]]; then
            pkg="${entry%%:*}"
            target="${entry##*:}"
        else
            pkg="$entry"
            target="$entry"
        fi

        echo "📦 Setting up $pkg (targeting ~/.config/$target)..."
        mkdir -p "$DOTFILES_DIR/$pkg"
        mkdir -p "$CONFIG_DIR/$target"

        # Rescue existing configs
        if [ -n "$(ls -A "$CONFIG_DIR/$target" 2>/dev/null)" ] && [ -z "$(ls -A "$DOTFILES_DIR/$pkg" 2>/dev/null)" ]; then
            echo "   -> Moving existing configs from $CONFIG_DIR/$target to $DOTFILES_DIR/$pkg"
            mv "$CONFIG_DIR/$target/"* "$DOTFILES_DIR/$pkg/" 2>/dev/null || true
        fi
    done

    # Handle ~/ files
    for entry in "${HOME_FILES[@]}"; do
        folder="${entry%%:*}"
        file="${entry##*:}"

        echo "📄 Setting up $file in $folder..."
        mkdir -p "$DOTFILES_DIR/$folder"

        if [ -f "$HOME/$file" ] && [ ! -f "$DOTFILES_DIR/$folder/$file" ]; then
            echo "   -> Moving existing $file to $DOTFILES_DIR/$folder/"
            mv "$HOME/$file" "$DOTFILES_DIR/$folder/"
        fi
    done

    # Handle ~/.config/ root files
    for entry in "${CONFIG_ROOT_FILES[@]}"; do
        folder="${entry%%:*}"
        file="${entry##*:}"

        echo "📄 Setting up $file in $folder..."
        mkdir -p "$DOTFILES_DIR/$folder"

        if [ -f "$CONFIG_DIR/$file" ] && [ ! -f "$DOTFILES_DIR/$folder/$file" ]; then
            echo "   -> Moving existing $file to $DOTFILES_DIR/$folder/"
            mv "$CONFIG_DIR/$file" "$DOTFILES_DIR/$folder/"
        fi
    done

    # Handle ~/ apps (Directories)
    for entry in "${HOME_APPS[@]}"; do
        if [[ "$entry" == *":"* ]]; then
            pkg="${entry%%:*}"
            target="${entry##*:}"
        else
            pkg="$entry"
            target="$entry"
        fi

        echo "📦 Setting up $pkg (targeting ~/$target)..."
        mkdir -p "$DOTFILES_DIR/$pkg"
        mkdir -p "$HOME/$target"

        # Rescue existing configs
        if [ -n "$(ls -A "$HOME/$target" 2>/dev/null)" ] && [ -z "$(ls -A "$DOTFILES_DIR/$pkg" 2>/dev/null)" ]; then
            echo "   -> Moving existing configs from $HOME/$target to $DOTFILES_DIR/$pkg"
            mv "$HOME/$target/"* "$DOTFILES_DIR/$pkg/" 2>/dev/null || true
        fi
    done

    echo ""
    echo "✅ Initialization complete!"
}

# ---------------------------------------------------------
# 🔗 LOGIC: APPLY
# ---------------------------------------------------------
apply_stow() {
    echo "🔗 Linking dotfiles using GNU Stow..."
    cd "$DOTFILES_DIR" || { echo "❌ Failed to enter $DOTFILES_DIR"; exit 1; }

    # Stow ~/.config/ apps
    for entry in "${CONFIG_APPS[@]}"; do
        if [[ "$entry" == *":"* ]]; then
            pkg="${entry%%:*}"
            target="${entry##*:}"
        else
            pkg="$entry"
            target="$entry"
        fi

        echo "   -> Stowing $pkg to $CONFIG_DIR/$target"
        mkdir -p "$CONFIG_DIR/$target"
        stow -t "$CONFIG_DIR/$target" "$pkg"
    done

    # Stow ~/ files
    for entry in "${HOME_FILES[@]}"; do
        folder="${entry%%:*}"
        echo "   -> Stowing $folder to $HOME"
        stow -t "$HOME" "$folder"
    done

    # Stow ~/.config/ root files
    for entry in "${CONFIG_ROOT_FILES[@]}"; do
        folder="${entry%%:*}"
        echo "   -> Stowing $folder to $CONFIG_DIR"
        stow -t "$CONFIG_DIR" "$folder"
    done

    # Stow ~/ apps (Directories)
    for entry in "${HOME_APPS[@]}"; do
        if [[ "$entry" == *":"* ]]; then
            pkg="${entry%%:*}"
            target="${entry##*:}"
        else
            pkg="$entry"
            target="$entry"
        fi

        echo "   -> Stowing $pkg to $HOME/$target"
        mkdir -p "$HOME/$target"
        stow -t "$HOME/$target" "$pkg"
    done

    echo ""
    echo "✅ All dotfiles successfully linked!"
}

# ---------------------------------------------------------
# 📥 LOGIC: EXPORT (System State & Packages)
# ---------------------------------------------------------
export_state() {
    echo "📥 Exporting system state to $DOTFILES_DIR/system-state..."
    
    # Create the directory for system backups (this won't be stowed)
    mkdir -p "$DOTFILES_DIR/system-state"

    # 1. Export Official Arch/CachyOS Packages
    # -Q (Query) -q (Quiet/no versions) -e (Explicitly installed) -n (Native repos)
    echo "   -> Exporting native pacman packages..."
    pacman -Qqen > "$DOTFILES_DIR/system-state/pkglist-repo.txt"

    # 2. Export AUR Packages
    # -m (Foreign/AUR packages)
    echo "   -> Exporting AUR packages..."
    pacman -Qqem > "$DOTFILES_DIR/system-state/pkglist-aur.txt"

    # 3. Export GTK/System Desktop Settings (dconf)
    # Even on Hyprland, GTK apps rely on these settings for themes/fonts
    if command -v dconf &> /dev/null; then
        echo "   -> Exporting dconf (GTK) settings..."
        dconf dump / > "$DOTFILES_DIR/system-state/dconf-settings.ini"
    fi

    # 4. Copy crucial /etc/ files (Backup only, DO NOT stow /etc/)
    echo "   -> Backing up essential /etc files..."
    mkdir -p "$DOTFILES_DIR/system-state/etc"
    cp /etc/pacman.conf "$DOTFILES_DIR/system-state/etc/" 2>/dev/null || true
    cp /etc/makepkg.conf "$DOTFILES_DIR/system-state/etc/" 2>/dev/null || true

    echo ""
    echo "✅ System state exported successfully!"
}

# ---------------------------------------------------------
# 🚦 ROUTER
# ---------------------------------------------------------
case "$1" in
    init) init_structure ;;
    apply) apply_stow ;;
    export) export_state ;;
    *)
        echo "Usage: $0 {init|apply|export}"
        echo "  init   - Creates the structure and moves existing configs."
        echo "  apply  - Runs GNU Stow to generate the symlinks."
        echo "  export - Backups up package lists and system state."
        exit 1
        ;;
esac
