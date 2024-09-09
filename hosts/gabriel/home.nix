{ config, pkgs, ... }:

{
	wayland.windowManager.sway.extraConfig = ''
		workspace 1 output eDP-1
		output * scale 1.5 resolution 2880x1800@90Hz
	    
		input "type:touchpad" {
	    tap enabled
		}

		default_orientation vertical
  '';	
}
