#!/bin/bash
for conf in tmux.conf inputrc bash_aliases vimrc; do
	[ -f ~/.$conf ] || cp -v $(dirname $0)/$conf ~/.$conf
done
[ -f ~/.bashrc ] && sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc
