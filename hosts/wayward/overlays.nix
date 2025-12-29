# overlays/overrides for packages

{ inputs, ... }:

{
  # Create the nur overlay inside nixpkgs
  nixpkgs.overlays = [
    inputs.nur.overlays.default
    (final: prev: {
      floorp-bin-unwrapped = prev.floorp-bin-unwrapped.overrideAttrs (old: {
        src = final.fetchurl {
          url =
            "https://github.com/Floorp-Projects/Floorp/releases/download/v12.7.0/floorp-linux-x86_64.tar.xz";
          hash = "sha256-feIRCZuyB8xwUoI1FMWJQ6yupgC2aAavADQ9mrk0zMM=";
        };
      });
    })
  ];
}
