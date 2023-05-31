{ pkgs ? import <nixpkgs> { } }: {

  # Packages with an actual source
  kns = pkgs.callPackage ./kns { };
}
