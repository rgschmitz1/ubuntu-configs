#!/bin/bash
for conf in tmux.conf inputrc bash_aliases vimrc; do
	cp -v $(dirname $0)/$conf ~/.$conf
done
if [ -f ~/.bashrc ]; then
	sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc
fi
