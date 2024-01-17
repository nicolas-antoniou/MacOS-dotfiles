# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	

#some useful options (man zshoptions)
setopt autocd extendedglob menucomplete
unsetopt nomatch
stty stop undef

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

#alias ls='ls -hN --color=auto --group-directories-first'
alias ls='ls -G'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias ssh="kitty +kitten ssh"
alias upgrade='brew upgrade'
alias cp="cp -iv"                          # confirm before overwriting something
alias mv="mv -iv"
alias rm="rm -vI"
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias vim='nvim'
alias v="nvim"
alias la="ls -AG"

#user defined functions
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

mcd () { mkdir -p "$1" && cd "$1"; }

rcd () {
    ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"
}

cdf() {
    cd $HOME/$(fd --base-directory $HOME --type d --hidden --exclude '.git' --exclude 'node_modules' | fzf)  
}

vif() {
    local fname
    fname=$HOME/$(fd --base-directory $HOME --type f --hidden -E '*.jpg' -E '*.jpeg' -E '.git' -E 'node_modules' -E '.nvim' -E '*.mp4' -E '*.png' | fzf) || return
    nvim "$fname"
}

idrive() {
	cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/
}

yt () {
    yt-dlp -o ~/Videos/%(title)s.%(ext)s -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" $1
}

DISABLE_AUTO_TITLE="true"

function set_terminal_title() {
  echo -en "\e]2;$@\a"
}

set_terminal_title Terminal

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

zle -N autosuggest-accept
#user defined keybinds
bindkey -s '^o' 'rcd\n'
bindkey '`' autosuggest-accept
bindkey -s '^f' 'cdf^M'
bindkey -s '^n' 'vif^M'
bindkey '^[[P' delete-char

export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=20%
--multi
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
"
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Environment variables set everywhere
export TERMINAL="kitty"
export BROWSER="firefox"

export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
