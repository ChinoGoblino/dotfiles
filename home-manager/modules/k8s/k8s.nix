{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
		kubectl
		kubectx
		colmena
    spotdl
    kustomize
    helmfile
    (wrapHelm kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
        helm-s3
        helm-git
      ];
    }) 
	];

  imports = [
    ./k9s.nix
  ];
}

