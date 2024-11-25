{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
		kubectl
		k9s
		kubectx
		colmena
    spotdl
    kustomize
	];

  imports = [
    ./k9s.nix
  ];
}

