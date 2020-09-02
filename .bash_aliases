## Tim's custom .bash_aliases file.
## Might be save to bash_custom
## 2020 - CC-0

# functions
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/─[\o033[94m\1\x1b[31m]/' 
}

directory_up() {
    if [ ! $1 ]; 
        then count=1;
        else count="$1";
    fi

    for((i=0; i < $count; i++));
      do cd ..;
    done
}

add_alias() {
    name="$1"
    shift 1;
    echo alias $name=\"$*\" >> ~/.bash_aliases
}

save_bash_aliases() {
    if [ -d ~/git/linux-config/ ]; 
        then cp ~/.bash_aliases ~/git/linux-config/.bash_aliases;
        else cp ~/.bash_aliases ~/bash_custom;
    fi
}

# parrot-like PS1
export PS1="\e[0;31m┌─\$([[ \$? != 0 ]] && echo \"[\e[01;31m\342\234\227\e[0;31m]─\")[$(if [[ ${EUID} == 0 ]]; then echo '\e[01;31mroot\e[01;33m@\e[01;96m\h'; else echo '\e[0;39m\u\e[01;33m@\e[01;96m\h'; fi)\e[0;31m]─[\e[0;32m\w\e[0;31m]\$(parse_git_branch)\n\e[0;31m└──╼ \e[0m\e[01;33m\\$\e[0m "

#export PS1="\e[0;31m┌─\$([[ \$? != 0 ]] && echo \"[\342\234\227]─\")[$(if [[ ${EUID} == 0 ]]; then echo '\e[31mroot\e[33m@\e[96m\h'; else echo '\e[39m\u\e[33m@\e[96m\h'; fi)\e[31m]─[\e[32m\w\e[31m]\$(parse_git_branch)\n\e[31m└──╼ \e[0m\e[33m\\$\e[0m "

# aliases
## system
alias ll='ls -laF'
alias la='ls -lha'
alias dd='dd status=progress'
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias _='sudo'
alias _i='sudo -i'
alias fuck='sudo $(history -p \!\!)'
alias upgrade="sudo apt update && sudo apt upgrade -y"
alias update="sudo apt update && apt list --upgradeable"

## useful
alias reload_bash="source ~/.bashrc"
alias ..="directory_up"
alias cip="ip addr | grep -E 'inet [0-9\.]*' -o | sed -e 's/inet //' -e '/^127/d'"
alias up="cip; python3 -m http.server 8000"
alias clear-trash="rm -rf ~/.local/share/Trash/files && rm -rf ~/.local/share/Trash/info && echo -e '\e[31mTrash cleared!\e[39m'"
alias update_locate="sudo updatedb"

## docker
alias dcup="docker-compose up -d"
alias dcdw="docker-compose down"
alias dcre="dcdw && echo -e '\e[31mRESTART!\e[39m' && dcup"

##fun
alias parrot="terminal-parrot"

## sensitive
if [ -f ~/Nextcloud/Security/.bash_sensitive ]; then
    . ~/Nextcloud/Security/.bash_sensitive
fi

## additional
alias code="code ."
