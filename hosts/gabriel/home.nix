{ config, pkgs, ... }:

{
	modules-right = [ "pulseaudio" "network" "disk" "cpu" "memory" "temperature" "battery" "clock" "tray" ];

	wayland.windowManager.sway.extraConfig = ''
		workspace 1 output eDP-1
		output * scale 1.5 resolution 2880x1800@90Hz
	    
		input "type:touchpad" {
	    tap enabled
		}
  '';	
}
