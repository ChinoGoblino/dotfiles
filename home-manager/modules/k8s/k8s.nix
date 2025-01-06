{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
		kubectl
		kubectx
		colmena
    spotdl
    kustomize
    kubernetes-helm
    helmfile
	];

  imports = [
    ./k9s.nix
  ];
}

