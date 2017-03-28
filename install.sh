#!/usr/bin/env bash

SCRIPTPATH=`pwd -P`
BACKUP=`date +'%Y%m%d%H%M%S'`

which -s brew
if [[ $? != 0 ]] ; then
  printf "Installing Homebrew\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  printf "Updating Homebrew\n"
  brew update
fi

if brew info node | grep "Not installed"; then
  printf "Installing node\n"
  brew install node
fi

if brew cask info hyper | grep "Not installed"; then
  printf "Installing hyper\n"
  brew cask install hyper
fi

if brew info python | grep "Not installed"; then
  printf "Installing python\n"
  brew install python
fi

if brew info python3 | grep "Not installed"; then
  printf "Installing python3\n"
  brew install python3
fi

if ! gem list --local | grep "neovim"; then
  printf "Installing neovim gem"
  sudo gem install neovim
fi

if ! pip2 list --format=columns | grep "neovim"; then
  printf "Installing neovim python2 module\n"
  pip2 install neovim
fi

if brew cask info intellij-idea | grep "Not installed"; then
  printf "Installing intellij-idea\n"
  brew cask install intellij-idea
fi

if brew cask info webstorm | grep "Not installed"; then
  printf "Installing webstorm\n"
  brew cask install webstorm
fi

if brew cask info franz | grep "Not installed"; then
  printf "Installing franz\n"
  brew cask install franz
fi

if brew info neovim/neovim/neovim 2>&1 | grep "brew tap neovim/neovim"; then
  printf "Tapping neovim\n"
  brew tap neovim/neovim
fi

if brew info neovim/neovim/neovim | grep "Not installed"; then
  printf "Installing neovim\n"
  brew install neovim/neovim/neovim
fi

if brew info tmux | grep "Not installed"; then
  printf "Installing tmux\n"
  brew install tmux
fi

if brew info fish | grep "Not installed"; then
  printf "Installing fish\n"
  brew install fish
fi

if brew cask info java | grep "Not installed"; then
  printf "Installing java\n"
  brew cask install java
fi

if brew info yarn | grep "Not installed"; then
  printf "Installing yarn"
  brew install yarn
fi

if [ ! -d ~/.config/ ]; then
  printf "Creating ~/.config\n"
  mkdir ~/.config
fi

if [ -d ~/.config/nvim/ ]; then
  printf "Backing up existing neovim config\n"
  mv ~/.config/nvim ~/.config/nvim.bak-${BACKUP}
fi

printf "Creating ~/.config/nvim\n"
mkdir ~/.config/nvim

if [ -d ~/.config/fish/ ]; then
  printf "Backing up existing fish config\n"
  mv ~/.config/fish ~/.config/fish.bak-${BACKUP}


printf "Creating ~/.config/fish\n"
mkdir ~/.config/fish

if [ ! -f ~/.config/nvim/autoload/plug.vim ]; then
  printf "Installing vim plug\n"
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -f ~/.config/fish/functions/fisher.fish ]; then
  printf "Installing fisher\n"
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
fi

printf "Installing pure\n"
fish -c "fisher rafaelrinaldi/pure"

#printf "Symlinking tmux\n"
#mv ~/.tmux.conf ~/.tmux.conf.back
#ln -s ${SCRIPTPATH}/tmux/.tmux-linux.conf ~/.tmux.conf

printf "Symlinking neovim\n"
ln -s ${SCRIPTPATH}/neovim/.config/nvim/init.vim ~/.config/nvim/init.vim

printf "Symlinking fish\n"
ln -s ${SCRIPTPATH}/fish/.config/fish/config.fish ~/.config/fish/config.fish

printf "Symlinking tmux\n"
ln -s ${SCRIPTPATH}/tmux/.tmux.conf ~/.tmux.conf

if ! cat /etc/shells | grep $(which fish); then
  echo $(which fish) | sudo tee -a /etc/shells
fi

chsh -s $(which fish)

