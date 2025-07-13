#!/bin/bash

# modified https://unix.stackexchange.com/questions/146570/arrow-key-enter-menu/415155#415155
function multiselect {
    clear
    ESC=$( printf "\033")
    cursor_blink_on()   { printf "$ESC[?25h"; }
    cursor_blink_off()  { printf "$ESC[?25l"; }
    cursor_to()         { printf "$ESC[$1;${2:-1}H"; }
    print_inactive()    { printf "$2   $1 "; }
    print_active()      { printf "$2  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()    { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }

    local return_value=$1
    shift
    local -a options=()
    local -a defaults=()

    # Split options and defaults
    while [[ $# -gt 0 ]]; do
        if [[ "$1" == "true" || "$1" == "false" ]]; then
            defaults+=("$1")
        else
            options+=("$1")
        fi
        shift
    done

    local num_options=${#options[@]}
    if [[ ${#defaults[@]} -ne $num_options ]]; then
        echo "Error: Number of options and defaults must match!"
        return 1
    fi

    local -a selected=()
    for ((i=0; i<num_options; i++)); do
        if [[ "${defaults[i]}" == "true" ]]; then
            selected+=("true")
        else
            selected+=("false")
        fi
        printf "\n"
    done

    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $num_options))

    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    echo "
    Use arrow keys to move up/down, spacebar to select, and enter to confirm."

    key_input() {
        local key
        IFS= read -rsn1 key 2>/dev/null >&2
        if [[ $key = "" ]]; then echo enter; fi
        if [[ $key = $'\x20' ]]; then echo space; fi
        if [[ $key = "k" ]]; then echo up; fi
        if [[ $key = "j" ]]; then echo down; fi
        if [[ $key = $'\x1b' ]]; then
            read -rsn2 key
            if [[ $key = [A ]]; then echo up; fi
            if [[ $key = [B ]]; then echo down; fi
        fi
    }

    toggle_option() {
        local option=$1
        if [[ ${selected[option]} == "true" ]]; then
            selected[option]="false"
        else
            selected[option]="true"
        fi
    }

    print_options() {
        local idx=0
        for ((i=0; i<num_options; i++)); do
            local prefix="[ ]"
            if [[ ${selected[idx]} == "true" ]]; then
                prefix="[\e[38;5;46m✔\e[0m]"
            fi
            cursor_to $(($startrow + $idx))
            if [[ $idx -eq $1 ]]; then
                print_active "${options[i]}" "$prefix"
            else
                print_inactive "${options[i]}" "$prefix"
            fi
            ((idx++))
        done
    }

    local active=0
    while true; do
        print_options $active
        case `key_input` in
            space)  toggle_option $active;;
            enter)  print_options -1; break;;
            up)     ((active--));
                    if [ $active -lt 0 ]; then active=$((num_options - 1)); fi;;
            down)   ((active++));
                    if [ $active -ge $num_options ]; then active=0; fi;;
        esac
    done

    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    local results_str="("
    for val in "${selected[@]}"; do
        results_str+="\"$val\" "
    done
    results_str+=")"

    eval "$return_value=$results_str"

    clear
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    #
    # usage example
    #
    my_options=("Option 1" "Option 2" "Option 3")
    preselection=("false" "true" "false")

    multiselect result "${my_options[@]}" "${preselection[@]}"

    idx=0
    for option in "${my_options[@]}"; do
        if ${result[idx]}; then
            echo "$option => ${result[idx]}"
        fi

        ((idx++))
    done
fi
