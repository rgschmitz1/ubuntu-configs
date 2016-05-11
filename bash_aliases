# Shorten amazon hyperlinks
alias amzn='sed '\''s/.*dp\(.*\)\/.*/amzn.com\1/'\'' <<<'
# Reattach tmux session, or start a session if one isn't already started
alias atmux='tmux a -d || tmux'
# List detached tmux session
alias ltmux='tmux ls'
# Search installed packages
alias sapt='dpkg --get-selections | grep -v deinstall | grep'
# System update
alias sysupdate='sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get autoclean; /etc/update-motd.d/98-reboot-required'
# Start wpr stations, requires mplayer
alias wpr-ideas='mplayer -playlist http://wpr-ice.streamguys.net/wpr-ideas-mp3-64.m3u &>/dev/null'
alias wpr-news='mplayer -playlist http://wpr-ice.streamguys.net/wpr-music-mp3-96.m3u &>/dev/null'
# Open app using default application
alias x='xdg-open'
# Start x11vnc
alias x11vnc='x11vnc -usepw -loop'
