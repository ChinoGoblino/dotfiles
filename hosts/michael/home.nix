{ config, lib, ... }:

{
	wayland.windowManager.hyprland.settings = {
		monitor = [ "DP-2, highrr, 1920x0, 1" "DP-3, 1920x1080, 0x200, 1" ];
	};
}
