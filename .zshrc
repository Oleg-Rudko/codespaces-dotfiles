# If you come from bash you might have to change your $PATH.
export ZSH="/${HOME}/.oh-my-zsh"

ZSH_DISABLE_COMPFIX=true
ZSH_THEME="robbyrussell"
plugins=(
 zsh-syntax-highlighting
 zsh-autosuggestions
 autojump
)

bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# aliases
alias vi="nvim"
alias vim="nvim"

# sources
[[ -s /home/codespace/.autojump/etc/profile.d/autojump.sh ]] && source /home/codespace/.autojump/etc/profile.d/autojump.sh
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/oh-my-zsh.sh
