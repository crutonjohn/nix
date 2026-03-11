{
  pkgs,
  ...
}:

{

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      sdl3
      SDL2
    ];
  };
}
