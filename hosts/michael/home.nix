{ config, lib, ... }:

{
    wayland.windowManager.sway.extraConfig = ''
	output DP-2 resolution 2560x1440@165Hz position 1920,0
	output DP-3 resolution 1920x1080 position 0,200

	workspace 1 output DP-2
	workspace 2 output DP-3
    '';
}
