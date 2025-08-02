{
  description = "A (not so) Good Flake";

  nixConfig = {
    extra-substituters = [ "https://cache.m7.rs" ];
    extra-trusted-public-keys = [ "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nix User Repository: User contributed nix packages
    nur.url = "github:nix-community/nur";

    picom.url = "github:Arian8j2/picom-jonaburg-fix";
    picom.flake = false;

    devenv.url = "github:cachix/devenv/latest";

    sops-nix.url = "github:Mic92/sops-nix/8e873886bbfc32163fe027b8676c75637b7da114";

    # nix-community hardware quirks
    # https://github.com/nix-community
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    hyprland.url = "github:hyprwm/Hyprland";
    hypr-contrib.url = "github:hyprwm/contrib";
    hypr-contrib.inputs.nixpkgs.follows = "nixpkgs";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    nixgl = {
      url = "github:johanneshorner/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # home-manager - Manage user configuration with nix
    # https://github.com/nix-community/home-manager
    home = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-inspect - inspect nix derivations usingn a TUI interface
    # https://github.com/bluskript/nix-inspect
    nix-inspect = {
      url = "github:bluskript/nix-inspect";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # krewfile - Declarative krew plugin management
    krewfile = {
      url = "github:brumhard/krewfile";
      # url = "github:ajgon/krewfile?ref=feat/indexes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # compose2nix - Nixify docker compose
    compose2nix.url = "github:aksiksi/compose2nix/v0.3.1";
    compose2nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, sops-nix, home, hyprland, nix-index-database, krewfile, ... }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
      ];

      # expose overlays as flake outputs
      overlays = import ./overlays { inherit inputs; };

    in
    rec {
      # Use nixpkgs-fmt for 'nix fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".nixpkgs-fmt);

      # setup devshells against shell.nix
      # devShells = forAllSystems (pkgs: import ./shell.nix { inherit pkgs; });

      # expose overlays as flake outputs
      inherit overlays;

      nixosConfigurations =
        let
          inherit inputs;
          # Import overlays for building nixosconfig with them.
          overlays = import ./overlays { inherit inputs; };
          # generate a base nixos configuration with the specified overlays, hardware modules, and any AerModules applied
          mkNixosConfig =
            { hostname
            , system ? "x86_64-linux"
            , nixpkgs ? inputs.nixpkgs
            , hardwareModules ? [ ]
              # basemodules is the base of the entire machine building
              # here we import all the modules and setup home-manager
            , baseModules ? [
                sops-nix.nixosModules.sops
                home.nixosModules.home-manager
                ./hosts/global # all machines get a global profile
                ./hosts/${hostname}   # load this host's config folder for machine-specific config
                {
                  home-manager = {
                    useUserPackages = true;
                    useGlobalPkgs = true;
                    extraSpecialArgs = {
                      inherit inputs hostname system;
                    };
                  };
                }
              ]
            , profileModules ? [ ]
            }:
            nixpkgs.lib.nixosSystem {
              inherit system;
              modules = baseModules ++ hardwareModules ++ profileModules;
              specialArgs = { inherit self inputs nixpkgs; };
              # Add our overlays
              pkgs = import nixpkgs {
                inherit system;
                overlays = builtins.attrValues overlays;
                config = {
                  allowUnfree = true;
                  allowUnfreePredicate = _: true;
                };
              };
            };
        in
        {
          "wayward" = mkNixosConfig {
            # Framework 13 Intel i5-1240P
            hostname = "wayward";
            system = "x86_64-linux";
            hardwareModules = [
              inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
              inputs.nixos-hardware.nixosModules.common-pc-ssd
            ];
            profileModules = [
              { home-manager.users.crutonjohn = ./home/crutonjohn/wayward; }
            ];
          };

          "fabius" = mkNixosConfig {
            # Main gaming Desktop
            hostname = "fabius";
            system = "x86_64-linux";
            hardwareModules = [
              inputs.nixos-hardware.nixosModules.common-gpu-amd
              inputs.nixos-hardware.nixosModules.common-pc-ssd
            ];
            profileModules = [
              { home-manager.users.crutonjohn = ./home/crutonjohn/wayward; }
            ];
          };

          "nord" = mkNixosConfig {
            # VPS
            hostname = "nord";
            system = "x86_64-linux";
            profileModules = [
            ];
          };

          "workbench" = mkNixosConfig {
            # Workbench and Local Volsync Backup Machine
            hostname = "workbench";
            system = "x86_64-linux";
          };

        };

      # Convenience output that aggregates the outputs for home, nixos.
      # Also used in ci to build targets generally.
      top =
        let
          nixtop = nixpkgs.lib.genAttrs
            (builtins.attrNames inputs.self.nixosConfigurations)
            (attr: inputs.self.nixosConfigurations.${attr}.config.system.build.toplevel);
        in
        nixtop;

      # Standalone home-manager configurations
      homeConfigurations =
        let
          inherit inputs;
          overlays = import ./overlays { inherit inputs; };
        in
        {
        # Work
        "bjohn@host" = home.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = builtins.attrValues overlays;
            config = {
              allowUnfree = true;
              allowUnfreePredicate = _: true;
            };
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/crutonjohn/common ];
        };
      };
    };

}
