case $1 in
archlinux-i3)
	echo "instalando dependencias"
	sudo pacman -Sy
	sudo pacman -S --needed git curl base-devel rofi pavucontrol feh nautilus tmux blueman lxterminal network-manager-applet flameshot i3blocks polkit-gnome awesome-terminal-fonts noto-fonts-emoji
	mkdir -p ${HOME}/Imágenes/fondos
	cp i3/fondo.jpg ${HOME}/Imágenes/fondos
	#instalando pamac
	#git clone https://aur.archlinux.org/pamac-all-git.git
	#/bin/bash -c "cd pamac-all-git && makepkg -sic"
	#
	cp -r i3/i3 $HOME/.config/
	cp -r i3/rofi $HOME/.config/
	cp i3/i3blocks.conf $HOME/.i3blocks.conf
;;
*)
	echo "./install.sh archlinux-i3"
;;
esac


