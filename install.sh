#!/bin/bash

set -e

printf "\e[35m Make sure you installed zsh.\e[0m\n";

while true; do
    read -p "Do you wish to install this program? [Y/n] : " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

if test -f ~/.zshrc; then
  echo ".zsh exits"
  echo "backuping .zsh"~
  cp -pf ~/.zshrc ./zshrc.backup
fi


echo "installing oh-my-zsh"
if [ "$(command -v curl)" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
elif [ "$(command -v wget)" ]; then
  sh -bqc "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
else
  echo "To install oh-my-zsh, you must have curl or wget installed." >&2
  exit 1
fi

echo "installing oh-my-zsh"
if [ "$(command -v git)" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
  echo "To install p10k, you must have curl or wget installed." >&2
  exit 1
fi

echo "replacing dotfiles"
cp -rf ./.zshrc ~/.zshrc
cp -rf ./.p10k.zsh ~/.p10k.zsh
cp -rf ./.aliases ~/.aliases

while true; do
    read -p "Do you wish to install Brew Bundle? [Y/n] : " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

brew bundle install --file brew/Brewfile

source ~/.zshrc
echo "Success"
