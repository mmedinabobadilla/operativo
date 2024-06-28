list:
	@echo "list,install-i3"
install-i3:
	@echo "instalando dependencias"
	@sudo pacman -Sy
	@sudo pacman -S --needed git base-devel rofi pavucontrol feh gnome-terminal nautilus blueman lxterminal network-manager-applet xfce4-screenshooter i3blocks volumeicon polkit-gnome awesome-terminal-fonts
	@mkdir -p ${HOME}/Imágenes/fondos
	@cp i3/fondo.jpg ${HOME}/Imágenes/fondos
	#instalando pamac
	@git clone https://aur.archlinux.org/archlinux-appstream-data-pamac.git
	@cd archlinux-appstream-data-pamac
	@makepkg -si



