#!/bin/bash

cat << "HI"
 ___           _        _ _
|_ _|_ __  ___| |_ __ _| | | ___ _ __
 | || '_ \/ __| __/ _` | | |/ _ \ '__|
 | || | | \__ \ || (_| | | |  __/ |
|___|_| |_|___/\__\__,_|_|_|\___|_|
HI

# variables for making text bold

bold=$(tput bold)
normal=$(tput sgr0)

# asking if user wants to install configs

while true; do
  read -p "${bold}DO YOU WANT TO START THE INSTALLATION NOW?${normal} (Yy/Nn): " yn
  case $yn in
  [Yy]*)
    echo ":: Installation started."
    echo
    break
   ;;
  [Nn]*)
    echo ":: Installation canceled"
    exit
    break
   ;;
  *)
    echo ":: Please answer yes or no."
    ;;
  esac
done

INSTALL_DIR="$HOME/.config/"
DOTFILES_DIR="$(pwd)/DOTFILES/zed"
BACKUP_DIR="${INSTALL_DIR}/zed-oldconfig"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to handle success or failure messages
check_status() {
  if [ $? -eq 0 ]; then
    echo "Operation successful."
  else
    echo "Operation failed!"
    exit 1
  fi
}

# Backup old config
if [ -d "$INSTALL_DIR/zed"]; then
   echo "Backing up existitng configuration: $INSTALL_DIR/zed to $BACKUP_DIR/zed"
   mv "$INSTALL_DIR/zed" "$BACKUP_DIR/"
   check_status
else
    echo "Did not find any existitng configuration..."
fi

# Copy new config
echo "Copying new configuration from $DOTFILES_DIR to $INSTALL_DIR"
cp -r "$DOTFILES_DIR" "$INSTALL_DIR/"
check_status

cat << "BYE"
 _____        _                    __ _         _
|__  /___  __| |   ___ ___  _ __  / _(_) __ _  (_)___
  / // _ \/ _` |  / __/ _ \| '_ \| |_| |/ _` | | / __|
 / /|  __/ (_| | | (_| (_) | | | |  _| | (_| | | \__ \
/____\___|\__,_|  \___\___/|_| |_|_| |_|\__, | |_|___/
                                       |___/
 _           _        _ _          _
(_)_ __  ___| |_ __ _| | | ___  __| |
| | '_ \/ __| __/ _` | | |/ _ \/ _` |
| | | | \__ \ || (_| | | |  __/ (_| |
|_|_| |_|___/\__\__,_|_|_|\___|\__,_|
BYE
echo "Zed config is now ready to use!"
echo "Thanks for using this repo, report issues if any"
