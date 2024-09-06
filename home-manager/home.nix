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

	htop
	neofetch
	mc
	playerctl
	starship

	xarchiver
	libreoffice
	nemo
	obsidian #unfree
	element-desktop
	firefox
	kitty
	gimp
	pwvucontrol
	wireshark
    ];

    imports = [
	./waybar.nix
	./sway.nix
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
	    obsidian = {
		name = "Obsidian";
		exec = "obsidian --ozone-platform-hint=auto";
	    };
	    nemo = {
		name = "Nemo";
		exec = "nemo";
	    };
	    gimp = {
		name = "GIMP";
		exec = "gimp";
	    };
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
    };

    programs = {
	starship = {
	    enable = true;
	    settings = {
		add_newline = true;
		format = "$shlvl$shell$username$sudo$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
		shlvl = {
		    disabled = false;
		    symbol = "ﰬ";
		    style = "bright-red bold";
		};
		username = {
		    show_always = true;
		    style_user = "#b7bdf8 bold";
		    style_root = "bright-red bold";
		    format = "[$user]($style) ";
		};
		hostname = {
		    ssh_only = true;
		    format = "on [$hostname](bold yellow)";
		};
		sudo = {
		    format = "[$symbol]($style)";
		    disabled = false;
		};
	    };
	};
	bash = {
	    enable = true;
	    shellAliases = {
		sshcse = "ssh z5588665@login.cse.unsw.edu.au";
	    };
	};
	neovim = {
	    enable = true;
	    viAlias = true;
	    vimAlias = true;
	    plugins = with pkgs.vimPlugins; [
		nvchad
	    ];
	    extraConfig = "
		set clipboard=unnamedplus
		set shiftwidth=4
			";
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
	};
	tofi = {
	    enable = true;
	    settings = {
		font 	     	 = "Fira Code";
		text-color       = "#cad3f5";
		prompt-color     = "#7dc4e4";
		prompt-text	 = "drun: ";
		selection-color  = "#ed8796";
		background-color = "#1e2030";
		border-width     = 4;
		border-color     = "#c6a0f6";
		hide-cursor      = true;
	    };
	};
    };
}
