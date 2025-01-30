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

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let 
    system = "x86_64-linux";  
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # TODO: tastytrade
    packages.${system}.tastytrade = pkgs.callPackage ./tastytrade.nix { };
    defaultPackage.${system} = self.packages.${system}.tastytrade;

    nixosConfigurations = {
      gabriel = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/gabriel/configuration.nix
          ./modules

					home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = { inherit inputs; };
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
					home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = { inherit inputs; };
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

