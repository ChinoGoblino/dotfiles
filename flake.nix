{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let 
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
  in {
	nixosConfigurations.gabriel = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs;};
	  modules = [
		  ./hosts/gabriel/configuration.nix
		  ./modules
	  ];
	};

	nixosConfigurations.michael = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs;};
	  modules = [
		  ./hosts/michael/configuration.nix
		  ./modules
	  ];
	};
  };
}
