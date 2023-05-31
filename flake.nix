{
  description = "A (not so) Good Flake";

  nixConfig = {
    extra-substituters = [ "https://cache.m7.rs" ];
    extra-trusted-public-keys = [ "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";

    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nur.url = "github:nix-community/nur";

    picom.url = "github:Arian8j2/picom-jonaburg-fix";
    picom.flake = false;

    devenv.url = "github:cachix/devenv/latest";

    hyprland.url = "github:hyprwm/Hyprland";
    hypr-contrib.url = "github:hyprwm/contrib";
    hypr-contrib.inputs.nixpkgs.follows = "nixpkgs";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixGL.url = "github:guibou/nixGL";
    nixGL.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home, hyprland, nix-index-database, nixGL, nur, ... }@inputs:
    let
      overlays = ({ pkgs, ... }: {
        nixpkgs.overlays = [
          nixGL.overlay
          nur.overlay
        ];
      });

      mkMachine = name: system: nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          overlays
          ./hosts/${name}

          home.nixosModules.home-manager
          {
            home-manager.users.crutonjohn = ./home/crutonjohn/${name}/default.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              hostname = name;
            };
            home-manager.sharedModules = [ overlays ];
          }
        ];

        specialArgs = {
          inherit inputs;
          hostname = name;
        };
      };
    in
    {
      nixosConfigurations = {
        wayward = mkMachine "wayward" "x86_64-linux";
        endurance = mkMachine "endurance" "x86_64-linux";
      };
    };
}
