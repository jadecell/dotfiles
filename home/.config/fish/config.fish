set -U fish_user_paths $fish_user_paths $HOME/.local/bin/
set fish_greeting                      # Supresses fish's intro message
set TERM "xterm-256color"              # Sets the terminal type
set TERMINAL "alacritty"               # Sets the terminal type
set EDITOR "nvim"                      # $EDITOR use neovim
set TERMINAL "alacritty"               # $EDITOR use alacritty
set BROWSER "brave"                    # $BROWSER use firefox
# set JDK (java-config -o)
set QT_QPA_PLATFORMTHEME "qt5ct"

### DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  fish_default_key_bindings
  # fish_vi_key_bindings
end
### END OF VI MODE ###

# Functions needed for !! and !$
# Will only work in default (emacs) mode.
# Will NOT work in vi mode.
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
bind ! __history_previous_command
bind '$' __history_previous_command_arguments

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
    set from (echo $argv[1] | trim-right /)
    set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
function rown --argument index
    sed -n "$index p"
end

# Function for ignoring the first 'n' lines
# ex: seq 10 | skip 5
# results: prints everything but the first 5 lines
function skip --argument n
    tail +(math 1 + $n)
end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
function take --argument number
    head -$number
end
### END OF FUNCTIONS ###

### Aliases

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../..'
alias .5='cd ../../../..'
alias .6='cd ../../../../..'

# vim and emacs
#alias vim="nvim"
#alias vi="nvim"
alias v="nvim"
alias sv="sudo vim"
alias em="/usr/bin/emacs -nw"
alias emacs="emacsclient -c -a 'emacs'"

# pacman and yay
# alias pacsyu='sudo pacman -Syyu'                 # update only standard pkgs
# alias yaysua="yay -Sua --noconfirm"              # update only AUR pkgs
# alias yaysyu="yay -Syu --noconfirm"              # update standard pkgs and AUR pkgs
alias unlock="sudo rm /var/lib/pacman/db.lck"    # remove pacman lock
alias p="sudo pacman"

# Changing "ls" to "exa"
alias ls='lsd -al --color=always --group-dirs first' # my preferred listing
alias la='lsd -a --color=always --group-dirs first'  # all files and dirs
alias ll='lsd -l --color=always --group-dirs first'  # long format
alias lt='lsd -aT --color=always --group-dirs first' # tree listing
alias l.='lsd -a | egrep "^\."'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# adding flags
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# git
alias dgit='/usr/bin/git --git-dir=$HOME/.local/repos/dotfiles --work-tree=$HOME'
alias dgitp='/usr/bin/git --git-dir=$HOME/.local/repos/dotfiles --work-tree=$HOME push git@gitlab.com:jadecell/dotfiles.git'
alias dgita='/usr/bin/git --git-dir=$HOME/.local/repos/dotfiles --work-tree=$HOME add -u'
alias dgits='/usr/bin/git --git-dir=$HOME/.local/repos/dotfiles --work-tree=$HOME status'
alias dgitc='/usr/bin/git --git-dir=$HOME/.local/repos/dotfiles --work-tree=$HOME commit -m'
alias g='/usr/bin/git'
alias gs='/usr/bin/git status'
alias ga='/usr/bin/git add -u'
alias gc='/usr/bin/git commit -m'

function gp
    set repoName (pwd | cut -d'/' -f6)
    /usr/bin/git push git@gitlab.com:jadecell/$repoName.git
end

# Open-RC
# alias rcs="sudo rc-service"
# alias rcu="sudo rc-update"

# Emerge
# alias es="sudo eix-sync"
# alias eu="sudo emerge -uDU --with-bdeps=y --keep-going @world"
# alias eum="sudo emerge -uDU --with-bdeps=y --autounmask-continue --keep-going @world"
# alias e="sudo emerge"
# alias em="sudo emerge --autounmask-continue"

# Classes
alias m1140="cd /home/jackson/Nextcloud/School/KPU/Year-1/Term-1/MATH-1140/"
alias m1115="cd /home/jackson/Nextcloud/School/KPU/Year-1/Term-1/MATH-1115/"
alias i1113="cd /home/jackson/Nextcloud/School/KPU/Year-1/Term-1/INFO-1113/"
alias i1213="cd /home/jackson/Nextcloud/School/KPU/Year-1/Term-1/INFO-1213/"
alias i1214="cd /home/jackson/Nextcloud/School/KPU/Year-1/Term-1/INFO-1214/"

# Misc
# alias ideace="flatpak run --filesystem=/usr/bin com.jetbrains.IntelliJ-IDEA-Community"
# alias f="sudo flaggie"
alias smi="sudo make install"
alias msmi="make && sudo make install"

starship init fish | source
