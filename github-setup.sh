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
sudo chmod 544 $pass_helper
sudo chown $(whoami):$(whoami) $pass_helper
unset pass_helper
grep -q GPG_TTY ~/.bashrc || echo 'export GPG_TTY=$(tty)' >> ~/.bashrc
which pass > /dev/null || sudo apt install -y pass
echo enter password on first line and username on second line
pass insert -m dev/github
