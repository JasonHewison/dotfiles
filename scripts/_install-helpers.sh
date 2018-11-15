#!/usr/bin/env bash

brew-install() {
  if brew info "$@" | grep "Not installed"; then
    echo Installing "$@"
    brew install "$@"
  fi
}

brew-cask-install() {
  if brew cask info "$@" | grep "Not installed"; then
    echo Installing "$@" cask
    brew cask install "$@"
  fi
}

pip2-install() {
  if ! pip2 list --format=columns | grep "$@"; then
    echo Installing "$@" python2 module
    pip2 install --user "$@"
  fi
}

pip3-install() {
  if ! pip3 list --format=columns | grep "$@"; then
    echo Installing "$@" python3 module
    pip3 install --user "$@"
  fi
}

npm-install() {
  if ! npm -g ls | grep "- ${@}@"; then
    echo Installing "$@" npm package
    npm install -g "$@"
  fi
}

install-brew() {
  if command -v brew; then
    echo "Updating Homebrew"
    brew update
  else
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew tap caskroom/cask
  brew tap homebrew/cask-versions
  brew tap homebrew/cask-fonts
}
