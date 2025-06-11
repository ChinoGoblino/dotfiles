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
    ./modules/syncthing.nix
    ./modules/waybar.nix
    ./modules/hyprland.nix
    ./modules/dunst.nix

    ./modules/nvim/nvim.nix
    ./modules/firefox/firefox.nix
    ./modules/starship.nix
    ./modules/k8s/k8s.nix
    ./modules/zsh.nix

    ./modules/email.nix
    ./modules/zed.nix
  ];
    
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    dconf
    syncthing
    papirus-icon-theme
    trayer
    swaylock
    swww

    neofetch
    btop

    ferdium
    mpv
    xarchiver
    libreoffice
    nemo
    signal-desktop
    obsidian #unfree
    vesktop #unfree-backend
    element-desktop
    gimp3
    #sdrangel
    pwvucontrol
    termshark
    thunderbird
    localsend
    
    tradingview
    prismlauncher
  ];

  programs.mise = {
    enable = true;
    globalConfig = {
      tools = {
      #  java = "openjdk-17";
        gradle = "8.8";
      };
    };
  };

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

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
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
      cp /etc/nixos/home-manager/modules/k8s/config.yml ${config.home.homeDirectory}/.kube/config
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
        font             = "Fira Code";
        text-color       = "#cad3f5";
        prompt-color     = "#7dc4e4";
        prompt-text      = "drun: ";
        selection-color  = "#ed8796";
        background-color = "#1e2030";
        border-width     = 4;
        border-color     = "#c6a0f6";
        hide-cursor      = true;
      };
    };
  };
}
