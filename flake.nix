{
  description = "My NixOS configuration";

  inputs = {
    # Main nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Nix hardware tweaks
    nixos-hardware.url = "github:nixos/nixos-hardware";
    # TODO: impermanence
    # Nix user repository
    nur.url = github:nix-community/nur;
    # Home manager aka dotfiles and packages
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # for macbooks
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, darwin, home-manager, nur, nixos-hardware, ...}:
    let
      supportedSystems =  [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = forAllSystems (system:
        import nixpkgs { inherit system; config.allowUnfree = true; }
      );
    in
    rec {

      legacyPackages = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = with outputs.overlays; [ additions wallpapers modifications ];
          config.allowUnfree = true;
        }
      );

      packages = forAllSystems (system:
        import ./pkgs { pkgs = legacyPackages.${system}; }
      );
      
      devShells = forAllSystems (system: {
        default = import ./shell.nix { pkgs = legacyPackages.${system}; };
      });

      nixosConfigurations = rec {
        # Desktop
        drebo = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/atlas ];
        };
        # Framework
        endurance = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/pleione ];
        };
        # Macbook
        micky = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/maia ];
        };
      };

      homeConfigurations = {
        # Desktop
        "misterio@atlas" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/misterio/atlas.nix ];
        };
        # Laptop
        "misterio@pleione" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/misterio/pleione.nix ];
        };
        # Secondary Desktop
        "misterio@maia" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/misterio/maia.nix ];
        };
        # Raspi 4
        "misterio@merope" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."aarch64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/misterio/merope.nix ];
        };
        # VPS
        "misterio@electra" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/misterio/electra.nix ];
        };
        # For easy bootstraping from a nixos live usb
        "nixos@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/misterio/generic.nix ];
        };
      };

      nixConfig = {
        extra-substituers = [ "https://cache.m7.rs" ];
        extra-trusted-public-keys = [ "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg=" ];
      };
    };
}
