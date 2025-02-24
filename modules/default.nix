{ config, pkgs, inputs, ...}:

{
	# Bootloader.
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      
      grub = {
        enable = true;
        device = "nodev";
        # useOSProber = true;       # Enable when needed. Slows things down
        efiSupport = true;
      };
    };
  };

  fileSystems."/media/music" = {
    device = "exodus:/volumes/media/music/music";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };

  fileSystems."/media/drive" = {
    device = "exodus:/volumes/payload/backups";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };

  imports = [
    ./udev.nix
    ./hosts.nix
  ];

  hardware.graphics = {
		enable = true;
  };

  # Allow remote ssh / scp
  services.openssh = {
		enable = true;
		settings = {
			PermitRootLogin = "no";
			PasswordAuthentication = true;
			KbdInteractiveAuthentication = false;
			AuthenticationMethods = "publickey,password";
		};
  };

  users.users.chino.openssh.authorizedKeys.keyFiles = [
		./ssh/authorized_keys
  ];

	services.flatpak.enable = true;
	xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
	systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
			flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  services.tailscale.enable = true;

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["chino"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Experimental (but largely stable) features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_AU.UTF-8";
		LC_IDENTIFICATION = "en_AU.UTF-8";
		LC_MEASUREMENT = "en_AU.UTF-8";
		LC_MONETARY = "en_AU.UTF-8";
		LC_NAME = "en_AU.UTF-8";
		LC_NUMERIC = "en_AU.UTF-8";
		LC_PAPER = "en_AU.UTF-8";
		LC_TELEPHONE = "en_AU.UTF-8";
		LC_TIME = "en_AU.UTF-8";
  };

	# Configure keymap in X11
  services.xserver.xkb = {
		layout = "au";
		variant = "";
  };

	# Define a user account. Don't forget to set a password with ‘passwd’
  users.groups.storage = {};
  users.users.chino = {
		isNormalUser = true;
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
  };
	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

  environment.variables = {
		EDITOR = "nvim";
		GDK_BACKEND = "wayland,x11";
		MOZ_ENABLE_WAYLAND = "1";
		XDG_SESSION_DESKTOP = "hyprland";
		QT_QPA_PLATFORM = "wayland";
		_JAVA_AWT_WM_NONREPARENTING = "1";
		NIXOS_OZONE_WL = "1";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
		neovim
		wget
		home-manager
		wl-clipboard
		unzip
		man-pages
		powertop
    ffmpeg
	
		traceroute
		netperf
		dnsutils
    xh
    nmap

    host-spawn #use terminal in vscode with flatpak
    # C
		clang
		gnumake
    # Rust
    rustup
    cargo-workspaces
    # Python
		python3
    pyright
    # Nix
    nil
    # Docker
    docker-compose
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  fonts.packages = with pkgs; [
		font-awesome
		fira-code
  ];

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
  };

	# Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Greeter
  services.greetd = { 
		enable = true;
		settings = rec {
	    initial_session = {
				#command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
				command = "Hyprland";
				user = "chino";
	    };
      default_session = initial_session;
		};
  };

  # Podman as drop in replacement for docker
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      # 'docker' alias for podman
      dockerCompat = true;
    };
  };
}
