# Reattach tmux session, or start a session if one isn't already started
alias atmux='tmux a -d || tmux'
# List detached tmux session
alias ltmux='tmux ls'
# Search installed packages
alias sapt='apt list --installed -qq'
# System update
alias sysup='sudo apt update && sudo apt -y dist-upgrade && sudo apt -y autoremove && sudo apt clean'
# Open app using default application
alias x='xdg-open'
# Start x11vnc
alias x11vnc='x11vnc -usepw -loop'
# Docker
alias d='docker'
