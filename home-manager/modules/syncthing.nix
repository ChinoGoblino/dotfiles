{ config, pkgs, ... }:

{
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
          path = "${config.home.homeDirectory}/Documents/Obsidian";
          devices = [ "gabriel" "raphael" "michael" ];
        };
        "UNSW" = {
          path = "${config.home.homeDirectory}/unsw";
          devices = [ "gabriel" "michael" ];
        };
      };
    };
  };
}
