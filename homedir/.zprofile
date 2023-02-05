##############################################################################
#Import the shell-agnostic (Bash or Zsh) environment config
##############################################################################
source ~/.profile

##############################################################################
# History Configuration
##############################################################################
HISTFILE=~/.zsh_history     #Where to save history to disk
HISTSIZE=10000              #How many lines of history to keep in memory
SAVEHIST=10000              #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed
#setopt    EXTENDED_HISTORY  # add timestamps to history

##############################################################################
# z-zsh setup
##############################################################################
. ~/.dotfiles/z-zsh/z.sh
function precmd () {
  z --add "$(pwd -P)"
}

command -v kubecolor >/dev/null 2>&1 && alias kubectl="kubecolor"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
