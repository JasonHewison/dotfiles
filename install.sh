#!/usr/bin/env bash

set -ex

SCRIPTPATH="$(pwd -P)"
source "$SCRIPTPATH/scripts/_install-helpers.sh"
BACKUP="$(date +'%Y%m%d%H%M%S')"

install-brew

brew-install node
brew tap mscharley/homebrew
brew-install alacritty
brew-install bat
brew-install ctop
brew-install fzf
brew-install git
brew-install jq
brew-install python2
brew-install python3
brew-install neovim

pip2-install neovim
pip3-install neovim

brew-install mysql
brew-install neofetch
brew-install reattach-to-user-namespace
brew-install ripgrep
brew-install tmux
brew-install tree
brew-install yarn
brew-install zsh

brew-cask-install java8
brew-cask-install font-source-code-pro

if [ ! -d /usr/local/n/ ]; then
  sudo mkdir -p /usr/local/n 
  sudo chown -R $(whoami) /usr/local/n
  npm-install n
  /usr/local/bin/n latest
fi
npm-install pure-prompt

if [ ! -d ~/.config/ ]; then
  echo Creating ~/.config
  mkdir ~/.config
fi

if [ ! "$(readlink ~/.config/nvim/init.vim)" = "${SCRIPTPATH}/neovim/init.vim" ]; then
  if [ -d ~/.config/nvim/ ]; then
    echo Backing up existing neovim config
    mv ~/.config/nvim "$HOME/.config/nvim.bak-${BACKUP}"
  fi
  echo Creating ~/.config/nvim
  mkdir ~/.config/nvim

  if [ ! -f ~/.config/nvim/autoload/plug.vim ]; then
    echo Installing vim plug
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  echo Symlinking neovim config
  ln -s "${SCRIPTPATH}/neovim/init.vim" ~/.config/nvim/init.vim
fi

if [ ! "$(readlink ~/.config/alacritty/alacritty.yml)" = "${SCRIPTPATH}/alacritty/alacritty.yml" ]; then
  echo Symlinking alacritty config
  if [ -f ~/.config/alacritty/alacritty.yml ] || [ -h ~/.config/alacritty/alacritty.yml ]; then
    mv ~/.config/alacritty "$HOME/.config/alacritty.bak-${BACKUP}"
  fi
  mkdir ~/.config/alacritty

  ln -s "${SCRIPTPATH}/alacritty/alacritty.yml" ~/.config/alacritty/alacritty.yml
fi

if [ ! "$(readlink ~/.tmux.conf)" = "${SCRIPTPATH}/tmux/tmux.conf" ]; then
  echo Symlinking tmux config
  if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
    mv ~/.tmux.conf "$HOME/.tmux.conf.bak-${BACKUP}"
  fi
  ln -s "${SCRIPTPATH}/tmux/tmux.conf" ~/.tmux.conf
fi

if [ ! "$(readlink ~/.zshrc)" = "${SCRIPTPATH}/zsh/zshrc" ]; then
  echo Symlinking zsh config
  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    mv ~/.zshrc "$HOME/.zshrc.bak-${BACKUP}"
  fi
  ln -s "${SCRIPTPATH}/zsh/zshrc" ~/.zshrc

  if ! grep "$(command -v zsh)" /etc/shells; then
    command -v zsh | sudo tee -a /etc/shells
  fi

  chsh -s "$(command -v zsh)"
fi

if [ ! "$(readlink ~/.gitconfig)" = "${SCRIPTPATH}/git/gitconfig" ]; then
  echo Symlinking git config
  if [ -f ~/.gitconfig ] || [ -h ~/.gitconfig ]; then
    mv ~/.gitconfig "$HOME/.gitconfig.bak-${BACKUP}"
  fi
  ln -s "${SCRIPTPATH}/git/gitconfig" ~/.gitconfig
fi

# Make OSX feel a little snappier, I normally run this after running https://gist.github.com/BenNunney/7219538

if [ ! "$(scutil --get ComputerName)" != "Jason Hewison MPB" ]; then
  sudo scutil --set ComputerName "Jason Hewison MBP"
fi
if [ ! "$(scutil --get HostName)" != "Jason Hewison MPB" ]; then
  sudo scutil --set HostName "Jason Hewison MBP"
fi
if [ ! "$(scutil --get LocalHostName)" != "Jason-Hewison-MPB" ]; then
  sudo scutil --set LocalHostName "Jason-Hewison-MBP"
fi

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Menu bar: hide the useless Time Machine and Volume icons
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
systemsetup -setrestartfreeze on

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Speed up window tranisations
defaults write NSGlobalDomain NSWindowResizeTime 0.01;

# Speed up mission control transition (F3)
defaults write com.apple.dock expose-animation-duration -float 0.1; 

# Speed up Launchpad (F4)
defaults write com.apple.dock springboard-show-duration -float 0.1;
defaults write com.apple.dock springboard-hide-duration -float 0.1;

# Stop dock item jumping when they want my attension
defaults write com.apple.dock no-bouncing -bool TRUE;

# Set preview to default screenshots to jpg.
defaults write com.apple.screencapture type jpg
killall SystemUIServer

# Save screenshots to Screenshots folder
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Restart dock so effects can kick in.
killall Dock;

