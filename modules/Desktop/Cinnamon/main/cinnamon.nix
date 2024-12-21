# Gnome Configuration
#- <https://wiki.nixos.org/wiki/GNOME>
_: {
	services.xserver = {
		displayManager.lightdm.enable = true;
		desktopManager.cinnamon.enable = true;
	};  
}
