{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;

  lycheeOverlay = self: super: {
    lychee-slicer = super.callPackage ./lychee-slicer { };
  };
  omadaExporterOverlay = self: super: {
    omada-exporter = super.callPackage ./omada-exporter { };
  };
in
{
  nur = inputs.nur.overlay;
  lychee-slicer = lycheeOverlay;
  omada-exporter = omadaExporterOverlay;

  # The unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

}