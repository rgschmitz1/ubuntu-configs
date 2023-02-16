# Reattach tmux session, or start a session if one isn't already started
alias atm='tmux a -d || tmux'
# Search installed packages
alias sapt='apt list --installed -qq'
# Open app using default application
alias x='xdg-open'
# Docker
alias d='docker'
# Kubectl
alias k='kubectl'
# Bwb
alias bwb='docker run --rm -d -p 6080:6080 -p 5900:5900 -v /mnt/data:/data -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/.X11-unix:/tmp/.X11-unix --privileged --group-add root --name bwb biodepot/bwb:latest'
