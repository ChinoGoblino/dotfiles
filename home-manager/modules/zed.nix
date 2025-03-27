{ config, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [ "java" "catppuccin" ];
    userSettings = {
      vim_mode = true;
      theme = {
        mode = "dark";
        dark = "Catppuccin Macchiato";
        light = "Catppuccin Latte";
      };
    };
  };
}
