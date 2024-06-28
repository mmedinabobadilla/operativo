case $1 in
i3)
	echo "instalando dependencias"
	sudo pacman -Sy
	sudo pacman -S --needed git base-devel rofi pavucontrol feh gnome-terminal nautilus blueman lxterminal network-manager-applet xfce4-screenshooter i3blocks volumeicon polkit-gnome awesome-terminal-fonts
	mkdir -p ${HOME}/Imágenes/fondos
	cp i3/fondo.jpg ${HOME}/Imágenes/fondos
	#instalando pamac
	#git clone https://aur.archlinux.org/pamac-all-git.git
	#/bin/bash -c "cd pamac-all-git && makepkg -sic"
	#
	cp -r i3/i3 $HOME/.config/
	cp -r i3/rofi $HOME/.config/
;;
esac


