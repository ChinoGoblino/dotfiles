 { config, pkgs, lib, ... }:

{
	wayland.windowManager.hyprland = {
		enable = true;
		systemd.enable = true;
		extraConfig = ''
			general {
				gaps_in = 0
				gaps_out = 0
			}
	
			# Autostart
			exec-once = dunst
			exec = pkill waybar & sleep 0.5 && waybar
			exec = pkill nm-applet & sleep 0.5 && nm-applet
			exec = pkill pasystray & sleep 0.5 && pasystray
			exec = pkill blueman-applet & sleep 0.5 && blueman-applet
			exec = pkill syncthingtray & sleep 0.5 && syncthingtray --wait

			# Input config
			$mod = SUPER
			bind = $mod, Q, killactive,
			bind = $mod, B, exec, firefox
			bind = $mod, X, exec, kitty
			bind = $mod, R, exec, tofi-drun --drun-launch=true
			bind = $mod, T, exec, grim -g "$(slurp)" - | swappy -f -

			bind = $mod, F, fullscreen

			bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
			bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
			bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
			# Requires playerctl
			bindl = , XF86AudioPlay, exec, playerctl play-pause
			bindl = , XF86AudioPrev, exec, playerctl previous
	
			bindl = , XF86MonBrightnessUp, exec, brightnessctl set +35
			bindl = , XF86MonBrightnessDown, exec, brightnessctl set 35-

			# Switch focus
			bind = $mod, H, movefocus, l
			bind = $mod, L, movefocus, r
			bind = $mod, K, movefocus, u
			bind = $mod, J, movefocus, d

			# Switch workspaces
			bind = $mod, 1, workspace, 1
			bind = $mod, 2, workspace, 2
			bind = $mod, 3, workspace, 3
			bind = $mod, 4, workspace, 4
			bind = $mod, 5, workspace, 5
			bind = $mod, 6, workspace, 6
			bind = $mod, 7, workspace, 7
			bind = $mod, 8, workspace, 8
			bind = $mod, 9, workspace, 9
			bind = $mod, 0, workspace, 10

			# Move active window around
			bind = SUPER SHIFT, H, movewindow, l
			bind = SUPER SHIFT, L, movewindow, r
			bind = SUPER SHIFT, K, movewindow, u
			bind = SUPER SHIFT, J, movewindow, d 
			
			# Move active window to a workspace
			bind = $mod SHIFT, 1, movetoworkspace, 1
			bind = $mod SHIFT, 2, movetoworkspace, 2
			bind = $mod SHIFT, 3, movetoworkspace, 3
			bind = $mod SHIFT, 4, movetoworkspace, 4
			bind = $mod SHIFT, 5, movetoworkspace, 5
			bind = $mod SHIFT, 6, movetoworkspace, 6
			bind = $mod SHIFT, 7, movetoworkspace, 7
			bind = $mod SHIFT, 8, movetoworkspace, 8
			bind = $mod SHIFT, 9, movetoworkspace, 9
			bind = $mod SHIFT, 0, movetoworkspace, 10

			# Move/resize windows with mod + LMB/RMB and dragging
			bindm = $mod, mouse:272, movewindow
			bindm = $mod, mouse:273, resizewindow

			# Remove border if only one application in a workspace
			windowrulev2 = noborder, onworkspace:w[t1]
		'';
	};
}
