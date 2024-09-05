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
	settings.PasswordAuthentication = false;
	settings.KbdInteractiveAuthentication = false;
	#settings.PermitRootLogin = "yes";
    };

    users.users.chino.openssh.authorizedKeys.keyFiles = [
	./ssh/authorized_keys
    ];

    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
	extraSpecialArgs = { inherit inputs; };
	users = {
	    chino = import ../home-manager/home.nix;
	};
    };


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
	description = "Ethan Scott";
	extraGroups = [ "networkmanager" "wheel"];
	packages = with pkgs; [];
    };

    environment.variables = {
	EDITOR = "nvim";
	GDK_BACKEND = "wayland,x11";
	MOZ_ENABLE_WAYLAND = "1";
	XDG_CURRENT_DESKTOP = "sway";
	XDG_SESSION_DESKTOP = "sway";
	QT_QPA_PLATFORM = "wayland";
	SDL_VIDEODRIVER = "wayland";
	_JAVA_AWT_WM_NONREPARENTING = "1";
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
	
	# traceroute, telnet
	inetutils
	# nslookup, dig
	dnsutils
	netperf
    ];

    fonts.packages = with pkgs; [
	font-awesome
	fira-code
    ];

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
		command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
		user = "greeter";
	    };
	};
    };

}
