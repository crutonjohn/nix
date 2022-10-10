{
  description = "NixOS configuration and home-manager configurations";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = github:nix-community/nur;
    nixos-hardware.url = github:nixos/nixos-hardware/master;
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, darwin, home-manager, nur, nixos-hardware, ...}:
    let
      homeManagerConfFor = config: { ... }: {
        # nixpkgs.overlays = [ nur.overlay ];
        imports = [ config ];
      };
      darwinSystem = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/macbook/darwin-configuration.nix
          home-manager.darwinModules.home-manager {
            home-manager.users.crutonjohn = homeManagerConfFor ./hosts/macbook/home.nix;
          }
        ];
        specialArgs = { inherit nixpkgs; };
      };
      ubuntuSystem = home-manager.lib.homeManagerConfiguration {
        configuration = homeManagerConfFor ./hosts/xps-ubuntu/home.nix;
        system = "x86_64-linux";
        homeDirectory = "/home/bjohn";
        username = "bjohn";
        stateVersion = "22.05";
      };
    in {
      nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/framework/configuration.nix
          nixos-hardware.nixosModules.framework-12th-gen-intel
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            nixpkgs.overlays = [ nur.overlay ];
            home-manager.users.crutonjohn = homeManagerConfFor ./hosts/framework/home.nix;
          }
        ];
        specialArgs = { inherit nixpkgs; };
      };
      # ubuntu = ubuntuSystem.activationPackage;
      # defaultPackage.x86_64-linux = ubuntuSystem.activationPackage;
      homeConfigurations.xps = {
        system = "x86_64-linux";
        modules = [
          ./hosts/xps-ubuntu/home.nix
        ];
        extraSpecialArgs = { inherit nixpkgs nur home-manager; };
      };
    };
}
