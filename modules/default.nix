{ config, pkgs, inputs, ...}:

{
	# Bootloader.
  boot.loader = {
		efi = {
	    canTouchEfiVariables = true;
	    efiSysMountPoint = "/boot";
		};
		
		grub = {
  	  enable = true;
  	  device = "nodev";
  	  useOSProber = true;
  	  efiSupport = true;
		};
  };

  hardware.graphics = {
		enable = true;
  };

  networking.networkmanager.enable = true;

  # Allow remote ssh / scp
  services.openssh = {
		enable = true;
		settings.PasswordAuthentication = true;
		settings.KbdInteractiveAuthentication = false;
  };

  users.users.chino.openssh.authorizedKeys.keyFiles = [
		./ssh/authorized_keys
  ];

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
		shell = pkgs.zsh;
		description = "Ethan Scott";
		extraGroups = [ "networkmanager" "wheel"];
		packages = with pkgs; [];
  };
	programs.zsh.enable = true;

  environment.variables = {
		EDITOR = "nvim";
		GDK_BACKEND = "wayland,x11";
		MOZ_ENABLE_WAYLAND = "1";
		XDG_CURRENT_DESKTOP = "hyprland";
		XDG_SESSION_DESKTOP = "hyprland";
		QT_QPA_PLATFORM = "wayland";
		_JAVA_AWT_WM_NONREPARENTING = "1";
		NIXOS_OZONE_WL = "1";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
		neovim
		wget
		git
		home-manager
		wl-clipboard
		unzip
		man-pages
	
		traceroute
		netperf
		# nslookup, dig
		dnsutils

		clang
		cargo
		gnumake
		python3
  ];

  fonts.packages = with pkgs; [
		font-awesome
		fira-code
  ];

	# kdeconnect
	programs.kdeconnect.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Greeter
  services.greetd = { 
		enable = true;
		settings = {
	    default_session = {
				command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd hyprland";
				user = "greeter";
	    };
		};
  };

  security.pam.services.greetd.enableGnomeKeyring = true;
	services.gnome.gnome-keyring.enable = true;

  environment.etc.inputrc = {
		text = ''
	    set completion-ignore-case on
		'';
	};
}
