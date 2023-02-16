#!/bin/bash

# username and email
USERNAME='Bob Schmitz III'
EMAIL='14095796+rgschmitz1@users.noreply.github.com'

create_passphrase() {
	unset passphrase
	read -rsp "Enter a passphrase: " passphrase
	echo
	read -rsp "Re-enter passphrase: "
	echo
	if [ "$passphrase" != "$REPLY" ]; then
		create_passphrase
	fi
}

# Create pass helper for git
git_pass_helper() {
	# Verify pass is installed
	if ! which pass > /dev/null; then
		sudo apt update && \
		sudo apt install -y pass
	fi
	pass init $key
	# Check if dev/github is valid
	if ! pass dev/github > /dev/null; then
		echo enter password on first line and username on second line
		pass insert -m dev/github
	fi
	# setup credential store to manage access tokens
	local pass_helper=/usr/local/bin/git-pass-helper
	git config --global credential.helper $pass_helper
	local temp=$(mktemp)
	cat <<-'PASS-HELPER' > $temp
	#!/bin/sh
	if [ -n "$1" ] && [ $1 = 'get' ]
	then
		credentials=($(pass dev/github))
		echo "username=${credentials[1]}"
		echo "password=${credentials[0]}"
	fi
	PASS-HELPER
	sudo mv $temp $pass_helper
	sudo chmod 755 $pass_helper
}

# Configure global defaults for git
git_global_defaults() {
	git config --global user.name "$USERNAME"
	git config --global user.email "$EMAIL"
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
	git config --global init.defaultBranch main
}

git_gpg_setup() {
	# GPG_TTY needs to be set or the passphrase prompt will not appear in terminal
	if ! grep -q GPG_TTY ~/.bashrc; then
		echo 'export GPG_TTY=$(tty)' >> ~/.bashrc
		export GPG_TTY=$(tty)
	fi
	# Verify we a gpg key has been initialized
	key='gpg --list-key "$USERNAME" 2> /dev/null | awk "/^pub/{getline;print}" | xargs'
	if ! gpg --list-key "$USERNAME" &> /dev/null; then
		create_passphrase
		gpg --batch --passphrase "$passphrase" --quick-gen-key "$USERNAME <$EMAIL>" rsa4096 default 0 && \
		key=$(eval $key)
		if [ -z "$key" ]; then
			echo "ERROR: gpg key is empty, check setup and try again."
			exit 1
		fi
		gpg --batch --passphrase "$passphrase" --quick-add-key $key rsa4096 default 0
	else
		key=$(eval $key)
	fi
	git config --global user.signingkey $key
	git config --global commit.gpgsign true
	git config --global gpg.program gpg
}

git_global_defaults

git_gpg_setup

git_pass_helper
