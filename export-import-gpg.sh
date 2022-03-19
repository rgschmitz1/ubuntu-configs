#!/bin/bash
cd $(dirname $0)
if [ -z $1 ]; then
	cat <<-HELP
	usage: $(basename $0) [option]
	options:
	  e|export - Export all gpg keys including trust
	  i|import - Import all gpg keys including trust
	HELP
elif [[ "$1" == 'export' || "$1" == 'e' ]]; then
	gpg -a --export > mypubkeys.asc
	gpg -a --export-secret-keys > myprivatekeys.asc
	gpg --export-ownertrust > otrust.txt
elif [[ "$1" == 'import' || "$1" == 'i' ]]; then
	gpg --import myprivatekeys.asc
	gpg --import mypubkeys.asc
	gpg -K
	gpg -k
	gpg --import-ownertrust otrust.txt
fi
