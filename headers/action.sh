#!/bin/bash

function install_brew {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function install_omz {
    if [ "$(command -v curl)" ]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
        if test -f ~/.zshrc; then
            echo ".zsh exits"
            echo "backuping .zsh"~
            cp -pf ~/.zshrc ./zshrc.backup
        fi
        cp -rf ./.zshrc ~/.zshrc
    elif [ "$(command -v wget)" ]; then
        sh -bqc "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        cp -rf ./.zshrc ~/.zshrc
    else
        echo "To install oh-my-zsh, you must have curl or wget installed." >&2
        exit 1
    fi
}

function install_p10k {
    if [ "$(command -v git)" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        cp -rf ./.p10k.zsh ~/.p10k.zsh
    else
        echo "To install p10k, you must have curl or wget installed." >&2
        exit 1
    fi
}

function install_alias {
    cp -rf ./.aliases ~/.aliases
}

function apply_zed {
    cp -rf ./zed/keymap.json ~/.config/zed/keymap.json
    cp -rf ./zed/settings.json ~/.config/zed/settings.json
}

function install_brew_pkg {
    if [[ $(uname) == *Darwin* ]]; then
        echo "U are install on MacOS now install Brewfile"
        brew bundle install --file brew/Brewfile
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "is just header file"
fi
