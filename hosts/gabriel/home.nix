{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = "eDP-1, highrr, 0x0, 1.5";
  };
}
