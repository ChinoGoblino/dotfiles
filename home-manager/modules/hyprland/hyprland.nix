 { config, pkgs, lib, ... }:

{
  home.file.".config/hypr/shaders/crt.frag".text = builtins.readFile ./shaders/crt.frag;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      "$mod" = "SUPER";

      general = {
        gaps_in = 0;
        gaps_out = 0;
        layout = "dwindle";
      };

      debug = {
        disable_scale_checks = true;
      };

      dwindle = {
        force_split = 2;
        permanent_direction_override = true;
        use_active_for_splits = false;
      };

      # Prevent blur on xwayland
      xwayland = {
        force_zero_scaling = true;
      };

      bind = [
        "$mod, Q, killactive"
        "$mod, B, exec, firefox"
        "$mod, X, exec, ${pkgs.kitty}/bin/kitty"
        "$mod, R, exec, ${pkgs.tofi}/bin/tofi-drun --drun-launch=true"
        "$mod, T, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.swappy}/bin/swappy -f -"
        "$mod, F, fullscreen"
        "$mod CTRL, S, exec, hyprctl keyword decoration:screen_shader ~/.config/hypr/shaders/crt.frag"
        "$mod CTRL_SHIFT, S, exec, hyprctl keyword decoration:screen_shader \"[[EMPTY]]\""

        # Switch focus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Switch workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window around
        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, L, movewindow, r"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, J, movewindow, d" 
        
        # Move active window to a workspace
        "$mod SHIFT, 1, movetoworkspacesilent, 1"
        "$mod SHIFT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT, 3, movetoworkspacesilent, 3"
        "$mod SHIFT, 4, movetoworkspacesilent, 4"
        "$mod SHIFT, 5, movetoworkspacesilent, 5"
        "$mod SHIFT, 6, movetoworkspacesilent, 6"
        "$mod SHIFT, 7, movetoworkspacesilent, 7"
        "$mod SHIFT, 8, movetoworkspacesilent, 8"
        "$mod SHIFT, 9, movetoworkspacesilent, 9"
        "$mod SHIFT, 0, movetoworkspacesilent, 10"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Requires playerctl
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"

        ", XF86MonBrightnessUp, exec, brightnessctl set +35"
        ", XF86MonBrightnessDown, exec, brightnessctl set 35-"
      ];

      # Autostart
      exec-once = [
        "${pkgs.dunst}/bin/dunst"
        "swww-daemon & sleep 2 && swww img /etc/nixos/home-manager/wallpapers/satellite.png"
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.networkmanagerapplet}/bin/nm-applet"
        "${pkgs.pasystray}/bin/pasystray"
        "${pkgs.blueman}/bin/blueman-applet"
        "${pkgs.syncthingtray}/bin/syncthingtray --wait"
      ];

      # Move/resize windows with mod + LMB/RMB and dragging
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Remove border if only one application in a workspace
      windowrulev2 = "noborder, onworkspace:w[t1]";
    };
  };
}
