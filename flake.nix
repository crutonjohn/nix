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

  outputs = {self, nixpkgs, darwin, home-manager, nur, nixos-hardware, ...}@inputs:
    let
      inherit (nixpkgs.lib) filterAttrs traceVal;
      inherit (builtins) mapAttrs elem;
      inherit (self) outputs;
      notBroken = x: !(x.meta.broken or false);
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    rec {

      legacyPackages = forAllSystems (system:
        import nixpkgs {
          inherit system;
          # overlays = with outputs.overlays; [ additions wallpapers modifications ];
          config.allowUnfree = true;
        }
      );

      # packages = forAllSystems (system:
      #   import ./pkgs { pkgs = legacyPackages.${system}; }
      # );
      
      devShells = forAllSystems (system: {
        default = import ./shell.nix { pkgs = legacyPackages.${system}; };
      });

      nixosConfigurations = rec {
        # Desktop
        galactica = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/galactica ];
        };
        # Framework
        endurance = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/framework ];
        };
        # Work
        hana = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/hana ];
        };
      };

      homeConfigurations = {
        # Desktop
        "crutonjohn@galactica" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/crutonjohn/galactica.nix ];
        };
        # Framework
        "crutonjohn@endurance" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/crutonjohn/endurance.nix ];
        };
        # Work
        "bjohn@hana" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/bjohn/hana.nix ];
        };
        # For easy bootstraping from a nixos live usb
        "nixos@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/crutonjohn/generic.nix ];
        };
      };

      nixConfig = {
        extra-substituers = [ "https://cache.m7.rs" ];
        extra-trusted-public-keys = [ "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg=" ];
      };
    };
}
