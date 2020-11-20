#!/bin/sh
# username and email
git config --global user.name "Bob Schmitz III"
git config --global user.email 14095796+rgschmitz1@users.noreply.github.com
# preferred editor is vim
git config --global core.editor vim
# git command aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.di diff
git config --global alias.pu pull
git config --global alias.up 'fetch upstream'
# setup credential store to manage access tokens
git config --global credential.helper store
