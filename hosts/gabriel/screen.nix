{ config, pkgs, ... }:

{
    wayland.windowManager.sway = {
	extraConfig = ''
	    workspace 1 output eDP-1
	    output * scale 1.5
	    
	    input "type:touchpad" {
		tap enabled
	    }
	'';
    };
}
