#!/bin/bash
for conf in tmux.conf inputrc bash_aliases vimrc; do
	cp -v $(dirname $0)/$conf ~/.$conf
done
