{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;

  lycheeOverlay = self: super: {
    lychee-slicer = super.callPackage ./lychee-slicer { };
  };
  pogOverlay = self: super: {
    pog = super.callPackage ./pog { };
  };
  bewcloudClientOverlay = self: super: {
    bewcloud-client = super.callPackage ./bewcloud { };
  };
  bambuStudioOverlay = self: super: {
    bambu-studio-local = super.callPackage ./bambu-studio { };
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
  otelcolOverlay = self: super: {
    otelcol = super.callPackage ./otelcol { };
  };
  newrecruitBuilderOverlay = self: super: {
    newrecruit-builder = super.callPackage ./newrecruit/builder.nix { };
  };
  newrecruitEditorOverlay = self: super: {
    newrecruit-editor = super.callPackage ./newrecruit/editor.nix { };
  };
in
{
  nur = inputs.nur.overlays.default;
  lychee-slicer = lycheeOverlay;
  pog = pogOverlay;
  bewcloud-client = bewcloudClientOverlay;
  bambu-studio-local = bambuStudioOverlay;
  omada-exporter = omadaExporterOverlay;
  bitwarden-gui = bitwardenOverlay;
  baremetalblog = baremetalblogOverlay;
  otelcol = otelcolOverlay;
  newrecruit-builder = newrecruitBuilderOverlay;
  newrecruit-editor = newrecruitEditorOverlay;

  # The unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  # Pinned package set (declared in the flake inputs)
  # will be accessible through 'pkgs.hugopin'
  hugopin-packages = final: _prev: {
    hugopin = import inputs.nixpkgs-hugopin {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

}
