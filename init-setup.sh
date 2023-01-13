#!/bin/bash
cd $(dirname $0)
for conf in tmux.conf inputrc bash_aliases vimrc; do
	cat $conf >> ~/.$conf
done
[ -f ~/.bashrc ] && sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc
