{ pkgs, config, ... }:

{
  programs.k9s = {
    enable = true;
    skins = {
      catppuccin-macchiato = ./catppuccin-macchiato.yaml;
    };
  };
}

