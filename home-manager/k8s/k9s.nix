{ pkgs, config, ... }:

{
  programs.k9s = {
    enable = true;
    settings.k9s = {
      ui = {
        skin = "catppuccin-macchiato";
      };
    };
  };

  home.file = {
    ".config/k9s/skins/catppuccin-macchiato.yaml".text = builtins.readFile ./catppuccin-macchiato.yaml;
  };
}

