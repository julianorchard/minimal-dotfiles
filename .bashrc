# ~/.bashrc

# A lot of this is edited from the default .bashrc on Ubuntu machines,
# but I've only left in the bits I really want.

# Not running interactively catch
case $- in
    *i*) ;;
      *) return;;
esac

# Hist file settings
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# Lesspipe (https://github.com/wofr06/lesspipe)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colour prompt stuff (I do want colour)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
else
	color_prompt=
fi
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt

# Colourful ls output and others (grep)
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Grep for everything in a folder with grepa
# Usage: `grepa example string`
function grepa() {
  grep -rni "$*" *
}

# Add aliases
function aa() {
  [ -z $1 ] && echo "Please provide an alias." || echo "alias $1=\"cd $PWD\"" >> ~/.bash_aliases
}
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# fzf+tmux Goodness
function t() {
  if [ ! -x /usr/bin/fzf ] ; then
    echo "You do not have fzf installed."
  else
    [ $# -gt 1 ] && selected=$1 || selected=$(find /var/www/html/ /var/www/ ~/ -mindepth 1 -maxdepth 1 -type d | fzf)
    selected_name=$(basename "$selected" | tr . _)
    tmux_running=$(ps aux | grep tmux)
    if [ -z $TMUX ] && [ -z $tmux_running ] ; then
      tmux new-session -s $selected_name -c $selected
    elif ! tmux has-session -t=$selected_name 2> /dev/null; then
      tmux new-session -ds $selected_name -c $selected
    fi
    tmux switch-client -t $selected_name
  fi
}

# General Aliases
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias cls="clear"
alias mindots-install="[ ! -x /usr/bin/ansible-playbook ] && \
                       echo \"You need ansible installed.\" || \
                       /usr/bin/ansible-playbook ${HOME}/install_packages/site.yml"

# Useful
alias ports="sudo netstat -plnt"

# Systemd
alias ssen="sudo systemctl enable"
alias ssenn="sudo systemctl enable --now"
alias ssdi="sudo systemctl disable"
alias ssdin="sudo systemctl disable --now"
alias ssre="sudo systemctl restart"
alias ssss="sudo systemctl status"

# Git
alias g="git"
alias g="g add"
alias mindots="git --git-dir=$HOME/.minimal-dotfiles/ --work-tree=$HOME"
alias mda="mindots add"
alias mdc="mindots commit -m"
alias mdb="mindots branch $HOSTNAME && mindots checkout $HOSTNAME"
alias mdp="mindots push origin $HOSTNAME"

# Tmux
alias tn="tmux new -s"
alias tc="tmux rename-session"
function ta() {
  n=$(tmux ls | fzf) && tmux -q attach-session -t ${n%%:*}
}

