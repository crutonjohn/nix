{
  description = "A (not so) Good Flake";

  nixConfig = {
    accept-flake-config = true;
    auto-optimise-store = true;
    builders-use-substitutes = true;
    cores = 0;
    max-jobs = 1;
    extra-experimental-features = "nix-command flakes impure-derivations recursive-nix";
    fallback = true;
    keep-derivations = true;
    keep-outputs = true;
    max-free = 1073741824;
    min-free = 262144000;
    show-trace = true;
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
    ];
    trusted-substituters = [
      "https://cache.nixos.org/"
      "https://cuda-maintainers.cachix.org"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      "https://nixpkgs-unfree.cachix.org"
    ];
    warn-dirty = false;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/2f5a153c270b70cb0f8c11f46d96d6d3bc39f4e3";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-hugopin.url = "github:nixos/nixpkgs/29dcf702b10d258b9bcd56bd38667c329614e128";

    # Nix User Repository: User contributed nix packages
    nur.url = "github:nix-community/nur";

    picom.url = "github:Arian8j2/picom-jonaburg-fix";
    picom.flake = false;

    devenv.url = "github:cachix/devenv/latest";

    sops-nix.url = "github:Mic92/sops-nix/8e873886bbfc32163fe027b8676c75637b7da114";

    # nix-community hardware quirks
    # https://github.com/nix-community
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Hyprland related stuff
    hyprland.url = "github:hyprwm/Hyprland/v0.55.4";
    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins/v0.55.0";
      inputs.hyprland.follows = "hyprland";
    };
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # Bleeding edge packages from Chaotic-AUR
    play-nix = {
      url = "github:tophc7/play.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        # chaotic.follows = "chaotic";
      };
    };
    mix-nix = {
      url = "github:tophc7/mix.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # home-manager - Manage user configuration with nix
    # https://github.com/nix-community/home-manager
    home = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-inspect - inspect nix derivations usingn a TUI interface
    # https://github.com/bluskript/nix-inspect
    nix-inspect = {
      url = "github:bluskript/nix-inspect";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil.url = "github:oxalica/nil";

    utils.url = "github:numtide/flake-utils";

    # krewfile - Declarative krew plugin management
    krewfile = {
      url = "github:brumhard/krewfile";
      # url = "github:ajgon/krewfile?ref=feat/indexes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # compose2nix - Nixify docker compose
    compose2nix.url = "github:aksiksi/compose2nix/v0.3.1";
    compose2nix.inputs.nixpkgs.follows = "nixpkgs";

    subtui.url = "github:MattiaPun/SubTUI/v2.13.1";

  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      home,
      hyprland,
      nix-index-database,
      krewfile,
      nil,
      play-nix,
      chaotic,
      utils,
      ...
    }@inputs:
    let
      # forAllSystems = nixpkgs.lib.genAttrs [
      #   "aarch64-linux"
      #   "x86_64-linux"
      # ];

      # expose overlays as flake outputs
      overlays = import ./overlays { inherit inputs; };

    in
    {
      # Use nixpkgs-fmt for 'nix fmt'
      # formatter = forAllSystems (
      #   system: nixpkgs.legacyPackages."${stdenv.hostPlatform.system}".nixpkgs-fmt
      # );

      # setup devshells against shell.nix
      # devShells = forAllSystems (pkgs: import ./shell.nix { inherit pkgs; });

      # expose overlays as flake outputs
      inherit overlays;

      nixosConfigurations =
        let
          inherit inputs;
          # Import overlays for building nixosconfig with them.
          overlays = import ./overlays { inherit inputs; };
          # generate a base nixos configuration with the specified overlays, hardware modules, and any other Modules applied
          mkNixosConfig =
            {
              hostname,
              system ? "x86_64-linux",
              nixpkgs ? inputs.nixpkgs,
              hardwareModules ? [ ],
              # basemodules is the base of the entire machine building
              # here we import all the modules and setup home-manager
              baseModules ? [
                sops-nix.nixosModules.sops
                home.nixosModules.home-manager
                ./hosts/global # all machines get a global profile
                ./hosts/${hostname} # load this host's config folder for machine-specific config
                {
                  home-manager = {
                    useUserPackages = true;
                    useGlobalPkgs = true;
                    sharedModules = [
                      inputs.sops-nix.homeManagerModules.sops
                    ];
                    extraSpecialArgs = { inherit inputs hostname system; };
                  };
                }
              ],
              profileModules ? [ ],
              bonusModules ? [ ],
            }:
            nixpkgs.lib.nixosSystem {
              inherit system;
              modules = baseModules ++ hardwareModules ++ profileModules ++ bonusModules;
              specialArgs = { inherit self inputs nixpkgs; };
              # Add our overlays
              pkgs = import nixpkgs {
                inherit system;
                overlays = builtins.attrValues overlays;
                config = {
                  allowUnfree = true;
                  allowUnfreePredicate = _: true;
                  permittedInsecurePackages = [
                    "electron-39.8.10"
                  ];
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
            profileModules = [ { home-manager.users.crutonjohn = ./home/crutonjohn/wayward; } ];
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
              {
                home-manager.users.crutonjohn = ./home/crutonjohn/fabius;
                home-manager.backupFileExtension = "bix";
              }
            ];
          };
          "cawl" = mkNixosConfig {
            # Main gaming Desktop
            hostname = "cawl";
            system = "x86_64-linux";
            hardwareModules = [
              # inputs.nixos-hardware.nixosModules.common-gpu-nvidia.ada-lovelace
              inputs.nixos-hardware.nixosModules.common-pc-ssd
            ];
            profileModules = [
              {
                home-manager.users.crutonjohn = ./home/crutonjohn/cawl;
                home-manager.backupFileExtension = "bix";
                home-manager.users.kat = ./home/kat/cawl;
              }
            ];
          };

          "servitor" = mkNixosConfig {
            # Local AI and Gaming Desktop
            hostname = "servitor";
            system = "x86_64-linux";
            hardwareModules = [
              inputs.nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
              inputs.nixos-hardware.nixosModules.common-pc-ssd
              inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
            ];
            profileModules = [ { home-manager.users.crutonjohn = ./home/crutonjohn/servitor; } ];
            bonusModules = [
              play-nix.nixosModules.play
              chaotic.nixosModules.default
            ];
          };

          "nord" = mkNixosConfig {
            # VPS
            hostname = "nord";
            system = "x86_64-linux";
            profileModules = [ { home-manager.users.crutonjohn = ./home/crutonjohn/nord; } ];
          };

          "workbench" = mkNixosConfig {
            # Workbench
            hostname = "workbench";
            system = "x86_64-linux";
            profileModules = [ { home-manager.users.crutonjohn = ./home/crutonjohn/nord; } ];

          };

          "perturabo" = mkNixosConfig {
            # NAS and Archival Storage
            hostname = "perturabo";
            system = "x86_64-linux";
            profileModules = [ { home-manager.users.crutonjohn = ./home/crutonjohn/nord; } ];

          };

        };

      # Convenience output that aggregates the outputs for home, nixos.
      # Also used in ci to build targets generally.
      top =
        let
          nixtop = nixpkgs.lib.genAttrs (builtins.attrNames inputs.self.nixosConfigurations) (
            attr: inputs.self.nixosConfigurations.${attr}.config.system.build.toplevel
          );
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

      packages =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs { inherit system; };
        in
        utils.lib.eachDefaultSystemMap (system: {
          teamspeak6-server = pkgs.callPackage ./pkgs/teamspeak6-server { };
        });

    };

}
