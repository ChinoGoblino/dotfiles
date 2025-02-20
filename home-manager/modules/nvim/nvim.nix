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
        plugin = nvim-lspconfig;
        config = toLuaFile ./lspconfig.lua;
      }
      # Catppuccin theme
      {
        plugin = catppuccin-nvim;
        config = "colorscheme catppuccin-macchiato";
      }
      # Autocomplete
      {
        plugin = nvim-cmp;
        config = toLuaFile ./cmp.lua;
      }
      # Pretty bottom status bar
      {
        plugin = lualine-nvim;
        config = toLuaFile ./lualine.lua;
      }
      # Tree sidebar
      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./nvimtree.lua;
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
          go
          comment
          java
          rust
          python
        ]);
        config = toLuaFile ./treesitter.lua;
      }
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
    '';
	};
}

