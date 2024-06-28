list:
	@echo "list,install-i3"
install-i3:
	@echo "instalando dependencias"
	@sudo pacman -Sy
	@sudo pacman -S rofi pavucontrol feh gnome-terminal nautilus blueman lxterminal network-manager-applet\
     xfce4-screenshooter i3blocks volumeicon pamac polkit-gnome awesome-terminal-fonts
    @mkdir -p ./i3/fondo.jpg ${HOME}/Imágenes/fondos


