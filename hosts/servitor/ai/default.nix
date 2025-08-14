{ config, lib, nixpkgs, pkgs, inputs, ... }:

{
  imports = [
    ./ollama.nix
    ./mcp-server.nix
  ];

}
