#!/bin/bash

set -e

script_dir=$(dirname -- "$(readlink -nf $0)";)
source "$script_dir/headers/multiselect.sh"
source "$script_dir/headers/action.sh"

my_options=("Install Brew" "Install Oh My Zsh" "Install p10k theme" "Install alias" "Apply zed settings and keymap" "Install Package from Brewfile")

actions=(install_brew install_omz install_p10k install_alias apply_zed install_brew_pkg)

preselection=("true" "true" "true" "true" "true" "false")

multiselect result "${my_options[@]}" "${preselection[@]}"


idx=0
for option in "${my_options[@]}"; do
    if ${result[idx]}; then
        ${actions[idx]}
    fi

    ((idx++))
done


zsh
