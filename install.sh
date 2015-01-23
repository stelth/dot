#!/bin/zsh

output_on_error() {
	log=$(mktemp ${0##*/}_log.XXXXXXXX) || exit 1
	trap 'rm "$log"' EXIT INT QUIT TERM

	$* >$log 2>$log || {
		echo "ERROR:"
		[[ -f $log ]] && cat $log
	}
}



ZPREZTO_PATH="zsh/.zprezto"

vim +PlugInstall +qall

if [ ! -d "$ZPREZTO_PATH" ]; then
	git clone --recursive https://github.com/sorin-ionescu/prezto.git ${ZPREZTO_PATH}
fi

CASK_PATH="emacs/.emacs.d/extern/cask"

if [ ! -d "$CASK_PATH" ]; then
	git clone --recursive https://github.com/cask/cask ${CASK_PATH}
	${CASK_PATH}/go
fi

CEDET_PATH="emacs/.emacs.d/extern/cedet"
(
	cd ${CEDET_PATH}
	output_on_error make
)

CEDET_CONTRIB_PATH="${CEDET_PATH}/contrib"
(
	cd ${CEDET_CONTRIB_PATH}
	output_on_error make
)
