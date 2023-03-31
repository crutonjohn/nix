{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    # Nix hardware tweaks
    nixos-hardware.url = "github:nixos/nixos-hardware";
    # TODO: impermanence
    # Nix user repository
    nur.url = "github:nix-community/nur";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # macbook stuff
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # FIXME: switch back to a versioned branch once the fix for building on recent nix-darwin
    # lands there.
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, utils, nixpkgs, nixpkgs-unstable, firefox-addons, darwin, home-manager, nixos-hardware, nur, ... }:
    let
      inherit (nixpkgs.lib) recursiveUpdate;

      lib = import ./lib;
      overlays = import ./overlays { inherit lib; };
      packages = import ./pkgs;
    in
    utils.lib.mkFlake rec {
      inherit self inputs lib;

      channelsConfig.allowUnfree = true;

      sharedOverlays = [
        overlays
        nur.overlay
      ];

      hostDefaults.modules = [
        nur.nixosModules.nur
        home-manager.nixosModules.home-manager
        ./common/configuration.nix
      ];

      hosts = lib.mkHosts {
        inherit self;
        hostsPath = ./hosts;
      };

      outputsBuilder = channels: {
        packages =
          let
            inherit (channels.nixpkgs.stdenv.hostPlatform) system;
          in
          packages { inherit lib channels; } // {
          };
      };
    };
}
