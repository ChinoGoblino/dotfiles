{ inputs, config, lib, pkgs, ... }:

{  
	home.username = "chino";
	home.homeDirectory = "/home/chino";
  
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  # The home.packages option allows you to install Nix packages into your
  # environment.
    
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
		dconf
		syncthingtray
		papirus-icon-theme
		networkmanagerapplet
		waybar
		dunst
		pasystray
		trayer
		tofi
		grim
		slurp
		swaylock
		swappy
		swww

		htop
		neofetch
		mc
		playerctl
		starship

		xarchiver
		libreoffice
		nemo
		obsidian #unfree
		vesktop #unfree-backend
		element-desktop
		firefox
		kitty
		gimp
		pwvucontrol
		wireshark
		thunderbird
		protonmail-bridge
	];

	imports = [
		./waybar.nix
		#./sway.nix
		./hyprland.nix
  ];

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
		# # Building this configuration will create a copy of 'dotfiles/screenrc' in
		# # the Nix store. Activating the configuration will then make '~/.screenrc' a
		# # symlink to the Nix store copy.
		# ".screenrc".source = dotfiles/screenrc;

		# # You can also set the file content immediately.
		# ".gradle/gradle.properties".text = ''
		#   org.gradle.console=verbose
		#   org.gradle.daemon.idletimeout=3600000
		# '';
  };

  services.syncthing = {
		enable = true;
  };

	xdg = {
		enable = true;
		mime.enable = true;
		desktopEntries = {
	    nemo = {
				name = "Nemo";
				exec = "nemo";
	    };
	    gimp = {
				name = "GIMP";
				exec = "gimp";
	    };
		};
		userDirs = {
	    enable = true;
	    desktop = "\$HOME/Desktop";
	    documents = "\$HOME/Documents";
	    download = "\$HOME/Downloads";
	    music = "\$HOME/Music";
	    pictures = "\$HOME/Pictures";
	    templates = "\$HOME/Templates";
	    videos = "\$HOME/Videos";
	    extraConfig = {};
		};
	};

  

	# Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/chino/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
		NIXOS_OZONE_WL = "1";   
  };

  home.activation = {
		# https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
		regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
			tofi_cache=${config.xdg.cacheHome}/tofi-drun
	    [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
	  '';
  };

  gtk = {
		enable = true;
		iconTheme.name = "Papirus";
		iconTheme.package = pkgs.papirus-folders;
		theme.name = "catppuccin-macchiato-lavender-standard";
		theme.package = pkgs.catppuccin-gtk.override {
	    accents = [ "lavender" ];
	    variant = "macchiato";
		};
  };   

  home.pointerCursor = {
		name = "Capitaine Cursors (Nord)";
		package = pkgs.capitaine-cursors-themed;
		gtk.enable = true;
		x11 = {
     enable = true;
     defaultCursor = "Capitaine Cursors (Nord)";
   };
  };

	programs = {
		starship = {
			enable = true;
	    settings = {
				add_newline = true;
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
					success_symbol = "[\\$](bold green)";
					error_symbol = "[\\$](bold red)";
				};
			};
		};
		
		bash = {
			enable = true;
	    shellAliases = {
				sshcse = "ssh z5588665@login.cse.unsw.edu.au";
				# TODO REMOVE:
				mipsy = "~/mipsy/target/debug/mipsy";
	    };
		};

		neovim = 
		let
			# Makes lua specific syntax easier to read below
			toLua = str: "lua << EOF\n${str}\nEOF\n";
			toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
		in
		{
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
				}
				# File icons
				{
					plugin = nvim-web-devicons;
				}
	    ];
			extraLuaConfig = ''
				${builtins.readFile ./nvim/init.lua}
				${builtins.readFile ./nvim/options.lua}
			'';
		};

		git = {
			enable = true;
			userName = "chinoGoblino";
			userEmail = "general@ethonium.com";
			extraConfig = {
				init.defaultBranch = "main";
				safe.directory = "/etc/nixos";
			};
		};

		kitty = {
			enable = true;
			theme = "Catppuccin-Macchiato";
			settings = {
				enable_audio_bell = false;
				scrollback_lines = 10000;
			};
		};

		# If tofi not updating app list delete tofi-drun and tofi-compgen in $XDG_CACHE_HOME
		tofi = {
			enable = true;
			settings = {
				font						 = "Fira Code";
				text-color       = "#cad3f5";
				prompt-color     = "#7dc4e4";
				prompt-text	     = "drun: ";
				selection-color  = "#ed8796";
				background-color = "#1e2030";
				border-width     = 4;
				border-color     = "#c6a0f6";
				hide-cursor      = true;
			};
		};
	};
}
