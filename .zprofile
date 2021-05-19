if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1  ]]; then
	startx -keeptty &> ~/.xorg.log
fi
