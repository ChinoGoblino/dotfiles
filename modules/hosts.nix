{ config, pkgs, ... }:

{ 
  networking.extraHosts = ''
    51.161.198.241  devnode1
    51.161.199.191  devnode2
    51.161.162.49   rocketry
  '';
}
