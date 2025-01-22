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

	# STM32CubeIDE udev rule
	services.udev.packages = [
		(pkgs.writeTextFile {
			name = "stm32_udev";
			text = ''
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", GROUP="users", MODE="0666"
			'';
			destination = "/etc/udev/rules.d/50-stm32.rules";
		})
		(pkgs.writeTextFile {
			name = "hackrf_udev";
			text = ''
# HackRF Jawbreaker
ATTR{idVendor}=="1d50", ATTR{idProduct}=="604b", SYMLINK+="hackrf-jawbreaker-%k", MODE="666", GROUP="plugdev"
# HackRF One
ATTR{idVendor}=="1d50", ATTR{idProduct}=="6089", SYMLINK+="hackrf-one-%k", MODE="666", GROUP="plugdev"
# rad1o
ATTR{idVendor}=="1d50", ATTR{idProduct}=="cc15", SYMLINK+="rad1o-%k", MODE="666", GROUP="plugdev"
# NXP Semiconductors DFU mode (HackRF and rad1o)
ATTR{idVendor}=="1fc9", ATTR{idProduct}=="000c", SYMLINK+="nxp-dfu-%k", MODE="666", GROUP="plugdev"
# rad1o "full flash" mode
KERNEL=="sd?", SUBSYSTEM=="block", ENV{ID_VENDOR_ID}=="1fc9", ENV{ID_MODEL_ID}=="0042", SYMLINK+="rad1o-flash-%k", MODE="666", GROUP="plugdev"
# rad1o flash disk
KERNEL=="sd?", SUBSYSTEM=="block", ENV{ID_VENDOR_ID}=="1fc9", ENV{ID_MODEL_ID}=="0082", SYMLINK+="rad1o-msc-%k", MODE="666", GROUP="plugdev"
#
			'';
			destination = "/etc/udev/rules.d/53-hackrf.rules";
		})
	];

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
	
		traceroute
		netperf
		dnsutils
    xh

		clang
		cargo
		gnumake
		python3
  ];

	system.autoUpgrade = {
		enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update=input"
      "nixpkgs"
      "-L"
    ];
	};

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

	# Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Greeter
  services.greetd = { 
		enable = true;
		settings = {
	    default_session = {
				command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
				user = "chino";
	    };
		};
  };

	# Unlock keyring
  security.pam.services.greetd.enableGnomeKeyring = true;
	services.gnome.gnome-keyring.enable = true;

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
