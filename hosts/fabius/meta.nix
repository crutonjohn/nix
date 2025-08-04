{ config, lib, nixpkgs, pkgs, inputs, ... }:

{

  nix = {
    settings = {
      download-buffer-size = 524288000;
    };
  };

}
