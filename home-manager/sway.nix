{ config, pkgs, lib, ... }:

{
    wayland.windowManager.sway = {
	enable = true;
	#checkConfig = false;
	config.modifier = "Mod4";
	config.floating.modifier = "Mod1";

	config.bars = [{ "command" = "waybar";}];
	config.floating.titlebar = false;
	config.window.titlebar = false;

	config.window.border = 0;
	config.floating.border = 0;

	config.fonts = {
	    names = [ "pango" ];
	    style = "monospace";
	    size = 8.0;
	};

	config.startup = [
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

	#config.output = {
	#    "*" = {
	#	bg = "~/.dotfiles/Wallpapers/nix-wallpaper-nineish-catppuccin-mocha-alt.png fill";
	#    };
	#};

	config.keybindings = let mod = config.wayland.windowManager.sway.config.modifier;
	in {
	    "${mod}+Control+l" = "${pkgs.swaylock}"; 
	    "${mod}+t" = ''exec ${pkgs.grim} -g "$(${pkgs.slurp})" ~/Desktop/screenshot-$(date +%s).png 2> /dev/null'';
	    "${mod}+x" = "exec kitty";
	    "${mod}+m" = "exec mc";
	    "${mod}+b" = "exec firefox";
	    "${mod}+q" = "kill";

	    "${mod}+r" = "exec tofi-drun --drun-launch=true";

	    "${mod}+Shift+c" = "reload";
	    "${mod}+Control+r" = "restart";
	    "${mod}+Shift+r" = "exec reboot";
	    "${mod}+Shift+s" = "exec poweroff";

	    "${mod}+j" = "focus left";
	    "${mod}+k" = "focus down";
	    "${mod}+l" = "focus up";
	    "${mod}+semicolon" = "focus right";

	    "${mod}+Left" = "focus left";
	    "${mod}+Down" = "focus down";
	    "${mod}+Up" = "focus up";
	    "${mod}+Right" = "focus right";

	    "${mod}+Shift+j" = "move left";
	    "${mod}+Shift+k" = "move down";
	    "${mod}+Shift+l" = "move up";
	    "${mod}+Shift+semicolon" = "move right";

	    "${mod}+Shift+Left" = "move left";
	    "${mod}+Shift+Down" = "move down";
	    "${mod}+Shift+Up" = "move up";
	    "${mod}+Shift+Right" = "move right";

	    "${mod}+h" = "split h";
	    "${mod}+v" = "split v";

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
	    #XF86MonBrightnessUp = "exec brightnessctl set +10";
	    #XF86MonBrightnessDown = "exec brightnessctl set -10";
	};
	config.modes.resize = {
	    Escape = "mode default";
	    Return = "mode default";
	    "Down" = "resize grow height 10 px or 10 ppt";
	    "Left" = "resize shrink width 10 px or 10 ppt";
	    "Right" = "resize grow width 10 px or 10 ppt";
	    "Up" = "resize shrink height 10 px or 10 ppt";

	    "k" = "resize grow height 10 px or 10 ppt";
	    "j" = "resize shrink width 10 px or 10 ppt";
	    "semicolon" = "resize grow width 10 px or 10 ppt";
	    "l" = "resize shrink height 10 px or 10 ppt";
	    
	    "${config.wayland.windowManager.sway.config.modifier}+d" = "mode default";
	};
	#extraConfig = ''
	 #   for_window [class="^.*"] border pixel 0# resize window (you can also use the mouse for that)
	#'';
    };
}
# Can remove swaylock, slurp and grim from master config
