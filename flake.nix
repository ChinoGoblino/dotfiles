{
    description = "A very basic flake";

    inputs = {
	nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

	home-manager = {
	    url = "github:nix-community/home-manager";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
    };

    outputs = { nixpkgs, home-manager, ... }@inputs: 
    let 
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
	profiles = [ "gabriel" "michael" ];
    in {
	nixosConfigurations = {
	    gabriel = nixpkgs.lib.nixosSystem {
		specialArgs = {inherit inputs;};
		modules = [
		    ./hosts/gabriel/configuration.nix
		    ./modules
		];
	    };

	    michael = nixpkgs.lib.nixosSystem {
		specialArgs = {inherit inputs;};
		modules = [
		    ./hosts/michael/configuration.nix
		    ./modules
		];
	    };
	};

	homeManagerConfigurations = {
	    michael = home-manager.lib.homeManagerConfiguration {
		modules = [ ./hosts/michael/home.nix ];
	    };
	    gabriel = home-manager.lib.homeManagerConfiguration {
		modules = [ ./hosts/gabriel/home.nix ];
	    };
	};
    };
}
