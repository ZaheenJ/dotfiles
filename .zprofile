if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1  ]]; then
	export QT_QPA_PLATFORMTHEME='qt5ct'
	startx -keeptty >~/.xorg.log 2>&1
fi
