#!/bin/sh

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

git config --global user.name $USERNAME
git config --global user.email $EMAIL
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
pass_helper=/usr/local/bin/git-pass-helper
git config --global credential.helper $pass_helper
cat << 'PASS-HELPER' > /tmp/git-pass-helper
#!/bin/bash
if [[ -n "$1" && $1 = 'get' ]]; then
	credentials=($(pass dev/github))
	echo "username=${credentials[1]}"
	echo "password=${credentials[0]}"
fi
PASS-HELPER
sudo mv /tmp/git-pass-helper $pass_helper
sudo chmod 755 $pass_helper
unset pass_helper
grep -q GPG_TTY ~/.bashrc || echo 'export GPG_TTY=$(tty)' >> ~/.bashrc
if ! which pass > /dev/null; then
	sudo apt update && \
	sudo apt install -y pass && \
	create_passphrase
	gpg --batch --passphrase "$passphrase" --quick-gen-key "$USERNAME <$EMAIL>" rsa4096 default 0 && \
	key=$(gpg --list-key "$USERNAME" 2> /dev/null | awk '/^pub/{getline;print}' | xargs)
	if [ -z "$key" ]; then
		echo "ERROR: gpg key is empty, check setup and try again."
		exit 1
	fi
	gpg --batch --passphrase "$passphrase" --quick-add-key $key rsa4096 default 0
	pass init $key
	unset key
fi
echo enter password on first line and username on second line
pass insert -m dev/github
