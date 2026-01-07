#!/bin/bash

DOTFILES_DIR=$(pwd)
# List the folders you want to symlink into ~/.config
CONFIG_FOLDERS=("nvim")

echo "🚀 Starting Dotfiles Symlinking..."

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

for folder in "${CONFIG_FOLDERS[@]}"; do
    if [ -d "$DOTFILES_DIR/$folder" ]; then
        TARGET="$HOME/.config/$folder"
        
        # Backup if it's a real directory and not a link
        if [ -d "$TARGET" ] && [ ! -L "$TARGET" ]; then
            echo "📦 Backing up existing $folder config..."
            mv "$TARGET" "${TARGET}.bak"
        fi

        echo "🔗 Linking $folder -> $TARGET"
        ln -sfn "$DOTFILES_DIR/$folder" "$TARGET"
    fi
done

# Special case for files that live directly in $HOME (like .bashrc)
# ln -sf "$DOTFILES_DIR/shell/.bashrc" "$HOME/.bashrc"

echo "✨ Setup Complete!"
