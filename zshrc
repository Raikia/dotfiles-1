[ -n "$DISPLAY" ] && [ -z "$TMUX" ] && which tmux &> /dev/null && exec tmux

FPATH="$HOME/.zshcomp:$FPATH"
HISTFILE=~/.histfile
HISTSIZE=1000
PROMPT="%F{cyan}%m[%F{white}%1d%F{cyan}]%#%f "
export GPG_TTY=$(tty)

# Add gopath if found
export GOPATH=$HOME/go
stat ${GOPATH}/bin &> /dev/null && PATH=$PATH:${GOPATH}/bin

bindkey -e

autoload -Uz compinit
compinit

alias ls="ls --color=auto"
alias zshreload="source ~/.zshrc"
alias xreload="xrdb ~/.Xresources"
alias home-socks="ssh -D 1701 -C -q -N diffie"
alias exploit-socks="ssh -D 1701 -C -q -N exploit"
alias exploit-vnc="ssh -X aghanim -L 5901:localhost:5901"

# GRC
if [[ "$TERM" != dumb ]] && (( $+commands[grc] )) ; then
  # Prevent grc aliases from overriding zsh completions.
  setopt COMPLETE_ALIASES

  # Supported commands
  cmds=(
    cc \
    configure \
    cvs \
    df \
    du \
    diff \
    dig \
    free \
    gcc \
    gmake \
    ifconfig \
    journalctl \
    last \
    lsblk \
    lspci \
    lsmod \
    lsof \
    ldap \
    make \
    mount \
    mtr \
    netstat \
    nmap \
    ping \
    ping6 \
    ps \
    stat \
    systemctl \
    traceroute \
    traceroute6 \
    uptime \
    vmstat \
    wdiff \
  );

  # Set alias for available commands.
  for cmd in $cmds ; do
    if (( $+commands[$cmd] )) ; then
      alias $cmd="grc --colour=auto $cmd"
    fi
  done

  # Clean up variables
  unset cmds cmd
fi

PATH=/home/kulinacs/.nvm/versions/node/v9.5.0/bin:/home/kulinacs/.local/bin:$PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# opam configuration
test -r /home/kulinacs/.opam/opam-init/init.zsh && . /home/kulinacs/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
