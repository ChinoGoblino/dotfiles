{ config, pkgs, ... }:

{
	programs = {
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        format = "$all$kubernetes$character";
        username = {
          disabled = false;
          style_user = "#b7bdf8 bold";
          style_root = "bright-red bold";
          format = "[$user]($style) ";
        };
        line_break = {
          disabled = true;
        };
        sudo = {
          disabled = true;
        };
        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
        };
        cmd_duration = {
          disabled = true;
        };
        gradle = {
          disabled = true;
        };
        kubernetes = {
          disabled = false;
          format = "[$symbol\(in $namespace \)]($style)";
          contexts = [{
            context_pattern = "homelab";
            symbol = "";
          } {
            context_pattern = "devsoc";
            style = "#8aadf4";
            symbol = "  ";
          } {
            context_pattern = "rocketry";
            style = "#ed8796";
            symbol = "  ";
          }];
        };
      };
    };
  };
}
