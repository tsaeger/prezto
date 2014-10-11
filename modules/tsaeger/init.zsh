TSAEGER_ZSH_INIT="${HOME}/dotfiles/zsh/init.zsh"

if [[ -a "${TSAEGER_ZSH_INIT}" ]] ; then
    source "${TSAEGER_ZSH_INIT}"
fi

TSAEGER_FZF_INIT="${HOME}/.nix-profile/share/fzf/key-bindings.zsh"
if [[ -a "${TSAEGER_FZF_INIT}" ]] ; then
# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
    source "${TSAEGER_FZF_INIT}"
fi

alias ll='lsd -l --group-dirs=first'
alias esk='$EDITOR $(sk -m --ansi -i -c '"'"'rg --color=always --line-number "{}"'"'"' | sd '"'"':.*'"'"' '"'"''"'"' | sd '"'"'\n'"'"' '"'"' '"'"' | sd '"'"'$'"'"' '"'"'\n'"'"')'

ssh-keys-connect () {
        ln -sf $(find /tmp -uid $(id -u) -type s -iname "agent.*" 2>/dev/null -exec ls -tl {} \; | sed -ne '1p' | awk '{print $9}') ${HOME}/.ssh/socket.${HOST}
        export SSH_AUTH_SOCK=${HOME}/.ssh/socket.${HOST}
}

vimdirdiff () {
$EDITOR -f '+next' '+execute "DirDiff" argv(0) argv(1)' $1 $2 '+syntax off'
}

function add_proxy() {
    export {f,ht}tp{,s}_proxy=http://www-proxy.us.oracle.com:80
    export {F,HT}TP{,S}_PROXY=http://www-proxy.us.oracle.com:80
    export CURL_NIX_FLAGS="-x ${http_proxy}"
}

function proxy_add() {
    add_proxy
}

function proxy_remove() {
    unset {f,ht}tp{,s}_proxy
    unset {F,HT}TP{,S}_PROXY
    unset CURL_NIX_FLAGS
}

# pet snippet manager
if hash pet &>/dev/null ; then
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}

zle -N pet-select
stty -ixon
bindkey '^s' pet-select
fi
