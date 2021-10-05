# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Supports 256 colors
export TERM="xterm-256color"
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/oh-my-zsh

source $HOME/.dotfiles/powerlevel10k/powerlevel10k.zsh-theme
# export ZSH_THEME="powerlevel10k/powerlevel9k"
POWERLEVEL10K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL10K_RIGHT_PROMPT_ELEMENTS=(root_indicator background_jobs)

# source $HOME/.dotfiles/oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme
# export ZSH_THEME="spaceship"

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
# https://github.com/bhilburn/powerlevel9k#customizing-prompt-segments
# https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir nvm vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time)
# colorcode test
# for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
POWERLEVEL9K_NVM_FOREGROUND='000'
POWERLEVEL9K_NVM_BACKGROUND='072'
POWERLEVEL9K_SHOW_CHANGESET=true
#export ZSH_THEME="random"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

source /usr/local/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/opt/zsh-git-prompt/zshrc.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# disable colors in ls
# export DISABLE_LS_COLORS="true"

# disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.dotfiles/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(aws colorize compleat dirhistory docker docker-compose dirpersist autojump git gulp helm history cp npm nvm terraform kubectl)

#Ignore permissions and load teh completion normallly
ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

source /usr/local/opt/nvm/nvm.sh --no-use

autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use &> /dev/null
  else
    nvm use stable
  fi
}
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# Customize to your needs...
unsetopt correct

# run fortune on new terminal :)
#fortune

#import work related stuff
test -e "$HOME/bin/.workrc" && source "$HOME/bin/.workrc"

#python
#export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
