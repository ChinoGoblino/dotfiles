# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "michael";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  environment.systemPackages = with pkgs; [
    steam
  ];

	fileSystems."/mnt/games" = { 
			device = "/dev/disk/by-uuid/956c562f-aa38-4fa3-b042-020552d5bbd6";
			fsType = "ext4";
	};

  fileSystems."/media/media" = {
    device = "192.168.1.129:/volumes/media";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };

  fileSystems."/media/backup" = {
    device = "192.168.1.129:/volumes/payload";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };

  # Steam requires 32 bit
  hardware.graphics.enable32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
