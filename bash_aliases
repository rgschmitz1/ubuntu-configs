# Reattach tmux session, or start a session if one isn't already started
alias atmux='tmux a -d || tmux'
# List detached tmux session
alias ltmux='tmux ls'
# Search installed packages
alias sapt='dpkg --get-selections | grep -v deinstall | grep'
# System update
alias sysup='sudo apt update && sudo apt -y dist-upgrade && sudo apt -y autoremove && sudo apt clean; /etc/update-motd.d/98-reboot-required'
# Open app using default application
alias x='xdg-open'
# Start x11vnc
alias x11vnc='x11vnc -usepw -loop'
# Docker
alias d='sudo docker'
