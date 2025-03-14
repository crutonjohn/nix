{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;

  lycheeOverlay = self: super: {
    lychee-slicer = super.callPackage ./lychee-slicer { };
  };
  pogOverlay = self: super: {
    pog = super.callPackage ./pog { };
  };
  omadaExporterOverlay = self: super: {
    omada-exporter = super.callPackage ./omada-exporter { };
  };
  bitwardenOverlay = self: super: {
    bitwarden-gui = super.callPackage ./bitwarden-desktop { };
  };
  baremetalblogOverlay = self: super: {
    baremetalblog = super.callPackage ./baremetalblog { };
  };
in
{
  nur = inputs.nur.overlay;
  lychee-slicer = lycheeOverlay;
  pog = pogOverlay;
  omada-exporter = omadaExporterOverlay;
  bitwarden-gui = bitwardenOverlay;
  baremetalblog = baremetalblogOverlay;

  # The unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

}
