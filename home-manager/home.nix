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

	imports = [
		./waybar.nix
		./hyprland.nix
    ./nvim/nvim.nix
    ./firefox.nix
    ./k8s/k8s.nix
  ];
    
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    dconf
		syncthingtray
		papirus-icon-theme
		networkmanagerapplet
		waybar
		pasystray
		trayer
		grim
		slurp
		swaylock
		swappy
		swww

		htop
		neofetch
		playerctl

		ferdium
		xarchiver
		libreoffice
		nemo
		obsidian #unfree
		vesktop #unfree-backend
		element-desktop
		gimp
		pwvucontrol
		wireshark
		thunderbird
		protonmail-bridge
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
    settings = {
      devices = {
        "raphael" = { id = "Z2CU7Q6-PSHUE4T-LVRDYH4-KDADA43-TIGQ6QJ-LGX36Q3-EUML2MI-3GQ35AD"; };
        "gabriel" = { id = "ABMFAT3-IPNNMZP-W2BUFHC-GSQPPBJ-AG7BPJV-YJZBGWN-6USI2YW-3VUKLAB"; };
        "michael" = { id = "VUTC7AY-PAPVSOQ-KRZQGX6-K537K7M-FWJGI7C-TCPFZMF-WANMFPU-QDRJMAG"; };
      };
      folders = {
        "Obsidian" = {
          path = "${config.home.homeDirectory}/unsw";
          devices = [ "gabriel" "michael" ];
        };
        "UNSW" = {
          path = "${config.home.homeDirectory}/Documents/Obsidian";
          devices = [ "gabriel" "raphael" "michael" ];
        };
      };
    };
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
  # shell provided by Home Manager.
  home.sessionVariables = {
		NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  home.activation = {
		# https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
		regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
			tofi_cache=${config.xdg.cacheHome}/tofi-drun
	    [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
	  '';
		customCommands = lib.mkAfter ''
			mkdir -p ${config.home.homeDirectory}/.kube
			cp /etc/nixos/home-manager/kube/config.yml ${config.home.homeDirectory}/.kube/config
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

  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
    settings = {
      global = {
        follow = "mouse";
        frame_color = "#8aadf4";
        separator_color= "frame";
      };
      urgency_low = {
        background = "#24273a";
        foreground = "#cad3f5";
      };
      urgency_normal = {
        background = "#24273a";
        foreground = "#cad3f5";
      };
      urgency_critical = {
        background = "#24273a";
        foreground = "#cad3f5";
        frame_color = "#f5a97f";
      };
    };
  };

	programs = {
		zsh = {
			enable = true;
			defaultKeymap = "viins";
			enableCompletion = true;
			autosuggestion.enable = true;
			syntaxHighlighting.enable = true;

			shellAliases = {
				update = "sudo nixos-rebuild switch --flake /etc/nixos";
				k = "kubectl";
				kns = "kubens";
				ktx = "kubectx";
				nix-shell = "nix-shell --command zsh";
        ssh = "kitten ssh";

				# TODO REMOVE:
				mipsy = "~/mipsy/target/debug/mipsy";
				sshcse = "ssh z5588665@login.cse.unsw.edu.au";
			};
			initExtra = ''
				# Case Insensitive autocomplete
				autoload -Uz compinit && compinit
				zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
				zstyle ':completion:*' menu select

				bindkey '^F' autosuggest-accept

				# Fix backspacing non-inserted characters in vim insert mode
				bindkey "^H" backward-delete-char
				bindkey "^?" backward-delete-char

				zmodload zsh/complist
				bindkey -M menuselect 'h' vi-backward-char
				bindkey -M menuselect 'k' vi-up-line-or-history
				bindkey -M menuselect 'l' vi-forward-char
				bindkey -M menuselect 'j' vi-down-line-or-history
			'';
		};

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
					success_symbol = "[❯](bold green)";
					error_symbol = "[❯](bold red)";
				};
			};
		};

		git = {
			enable = true;
			userName = "ChinoGoblino";
			userEmail = "general@ethonium.com";
			extraConfig = {
				init.defaultBranch = "main";
				safe.directory = "/etc/nixos";
			};
		};

		kitty = {
			enable = true;
			shellIntegration.enableZshIntegration = true;
			themeFile = "Catppuccin-Macchiato";
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
