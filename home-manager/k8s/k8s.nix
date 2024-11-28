{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
		kubectl
		kubectx
		colmena
    spotdl
    kustomize
	];

  imports = [
    ./k9s.nix
  ];
}

