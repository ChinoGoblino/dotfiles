{ config, pkgs, lib, ... }:

{
	options = {
		wallpaper = lib.mkOption {
			default = /etc/nixos/home-manager/wallpapers/nix-wallpaper-nineish-catppuccin-mocha-alt.png;
			type = lib.types.path;
		};
  };
    
  config = {
		wayland.windowManager.sway = {
			enable = true;
			config = {
				modifier = "Mod4";
				floating.modifier = "Mod1";

				bars = [{ "command" = "waybar";}];
				floating.titlebar = false;
				window.titlebar = false;

				window.border = 0;
				floating.border = 0;

				fonts = {
					names = [ "pango" ];
					style = "monospace";
					size = 8.0;
				};

				startup = [
					{ command = "nm-applet"; }
					{ command = "pasystray"; }
					{ command = "/usr/bin/dunst"; }
					{ command = "blueman-applet"; }
					{ command = "syncthingtray"; }
					{ command = "streamdeck -n"; }
					{ command = "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK"; }
				 #{ command = "hash dbus-update-activation-environment 2>/dev/null && \
						#dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK"; }
				];

				output = {
					"*" = {
						bg = "${config.wallpaper} fill";
					};
				};

				keybindings = let mod = config.wayland.windowManager.sway.config.modifier;
				in {
					"${mod}+Control+l" = "swaylock"; 
					"${mod}+t" = ''exec grim -g "$(slurp)" - | swappy -f -'';
					"${mod}+x" = "exec kitty";
					"${mod}+m" = "exec mc";
					"${mod}+b" = "exec firefox";
					"${mod}+q" = "kill";

					"${mod}+r" = "exec tofi-drun --drun-launch=true";

					"${mod}+Shift+c" = "reload";
					"${mod}+Control+r" = "restart";
					"${mod}+Tab+r" = "exec reboot";
					"${mod}+Tab+s" = "exec poweroff";

					"${mod}+h" = "focus left";
					"${mod}+j" = "focus down";
					"${mod}+k" = "focus up";
					"${mod}+l" = "focus right";

					"${mod}+Left" = "focus left";
					"${mod}+Down" = "focus down";
					"${mod}+Up" = "focus up";
					"${mod}+Right" = "focus right";

					"${mod}+Shift+h" = "move left";
					"${mod}+Shift+j" = "move down";
					"${mod}+Shift+k" = "move up";
					"${mod}+Shift+l" = "move right";

					"${mod}+Shift+Left" = "move left";
					"${mod}+Shift+Down" = "move down";
					"${mod}+Shift+Up" = "move up";
					"${mod}+Shift+Right" = "move right";

					"${mod}+bracketleft" = "split h";
					"${mod}+bracketright" = "split v";

					"${mod}+f" = "fullscreen toggle";

					"${mod}+s" = "layout stacking";
					"${mod}+w" = "layout tabbed";
					"${mod}+e" = "layout toggle split";

					"${mod}+Shift+space" = "floating toggle";
					"${mod}+space" = "focus mode_toggle";
					"${mod}+a" = "focus parent";

					"${mod}+1" = "workspace number 1";
					"${mod}+2" = "workspace number 2";
					"${mod}+3" = "workspace number 3";
					"${mod}+4" = "workspace number 4";
					"${mod}+5" = "workspace number 5";
					"${mod}+6" = "workspace number 6";
					"${mod}+7" = "workspace number 7";
					"${mod}+8" = "workspace number 8";
					"${mod}+9" = "workspace number 9";
					"${mod}+0" = "workspace number 10";

					"${mod}+Shift+1" = "move container to workspace number 1";
					"${mod}+Shift+2" = "move container to workspace number 2";
					"${mod}+Shift+3" = "move container to workspace number 3";
					"${mod}+Shift+4" = "move container to workspace number 4";
					"${mod}+Shift+5" = "move container to workspace number 5";
					"${mod}+Shift+6" = "move container to workspace number 6";
					"${mod}+Shift+7" = "move container to workspace number 7";
					"${mod}+Shift+8" = "move container to workspace number 8";
					"${mod}+Shift+9" = "move container to workspace number 9";
					"${mod}+Shift+0" = "move container to workspace number 10";

					"${mod}+d" = "mode resize";

					XF86AudioMute = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
					XF86AudioPlay = "exec playerctl play";
					XF86AudioPause = "exec playerctl pause";
					XF86AudioNext = "exec playerctl next";
					XF86AudioPrev = "exec playerctl prev";
					XF86AudioRaiseVolume = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1";
					XF86AudioLowerVolume = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
					XF86MonBrightnessUp = "exec brightnessctl set +10";
					XF86MonBrightnessDown = "exec brightnessctl set 10-";
				};
	
				modes.resize = {
					Escape = "mode default";
					Return = "mode default";
					"Down" = "resize grow height 10 px or 10 ppt";
					"Left" = "resize shrink width 10 px or 10 ppt";
					"Right" = "resize grow width 10 px or 10 ppt";
					"Up" = "resize shrink height 10 px or 10 ppt";

					"j" = "resize grow height 10 px or 10 ppt";
					"h" = "resize shrink width 10 px or 10 ppt";
					"l" = "resize grow width 10 px or 10 ppt";
					"k" = "resize shrink height 10 px or 10 ppt";
	    
					"${config.wayland.windowManager.sway.config.modifier}+d" = "mode default";
				};
			};
		};
	};
}
