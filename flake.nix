{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: 
  let 
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      gabriel = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/gabriel/configuration.nix
          ./modules
					home-manager.nixosModules.home-manager
          {
            home-manager.users.chino = {
              imports = [
                ./hosts/gabriel/home.nix
                ./home-manager/home.nix
              ];
            };
          }
        ];
      };

      michael = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/michael/configuration.nix
          ./modules
					home-manager.nixosModules.home-manager
          {
            home-manager.users.chino = {
              imports = [
                ./hosts/michael/home.nix
                ./home-manager/home.nix
              ];
            };
          }
        ];
      };
    };
  };
}

