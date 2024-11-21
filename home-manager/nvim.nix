{ pkgs, config, ... }:

let
  # Makes lua specific syntax easier to read below
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = catppuccin-nvim;
        config = "colorscheme catppuccin-macchiato";
      }
      # Pretty bottom status bar
      {
        plugin = lualine-nvim;
        config = toLuaFile ./nvim/lualine.lua;
      }
      # Tree sidebar
      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./nvim/nvimtree.lua;
      }
      # File icons
      {
        plugin = nvim-web-devicons;
      }
      # Better syntax highlighting. E.g. C #defines
      {
        plugin = nvim-treesitter.withPlugins (ps: with ps; [
          c
          nix
          yaml
          comment
        ]);
        config = toLuaFile ./nvim/treesitter.lua;
      }
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/init.lua}
      ${builtins.readFile ./nvim/options.lua}
    '';
	};
}

