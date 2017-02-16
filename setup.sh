git_config(){
	echo enter your name,email:
	read name
	read email
	git config --global user.name $name
	git config --global user.email $email
	git config --list
}

dotfiles(){
	echo dotfiles
	cp ./dotfiles/.vimrc ~
	cp ./dotfiles/.zshrc ~
}

installPackage(){
	echo installPackage
	pacman -S zsh
	chsh -s /usr/bin/zsh
}

rmPackage(){
	echo rmPackage
	pacman -Rns libreoffice
	pacman -Rns nano
	pacman -Rns mousepad
}

lang(){
	echo lang
	sudo pacman -S fcitx-mozc fcitx-gtk2 fcitx-gtk3
	sudo pacman -S fcitx-im
	sudo pacman -S fcitx-configtool
	if  [ "grep "LANG" /etc/locale.conf" ]; then
		echo found LANG
#		sudo cat /etc/locale.conf |sed "/LANG/d" >> /etc/locale.conf
		sudo echo 'LANG="ja_JP.UTF-8"' >> /etc/locale.conf
	else 
		echo not found
	fi
	cat ./dotfiles/.xprofile >> ~/.xprofile
	cat ./dotfiles/.zshrc_fcitx	>> ~/.zshrc
}

echo setup.sh
main(){
	lang
	touch log
#sh log.sh
#installPackage
#rmPackage
#dotfiles
#git_config
#reboot



}
