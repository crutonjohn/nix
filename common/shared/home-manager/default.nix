{ ... }:

{
  imports = [
    ./bash.nix
    ./gnupg.nix
    ./less.nix
    ./vim.nix
    ./vscode.nix
    ./xdg.nix
  ];

  home.stateVersion = "22.11";
}
