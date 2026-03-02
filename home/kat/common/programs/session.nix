{ ... }:

{
  home = {
    sessionVariables = {
      EDITOR = "vim";
      TERMINAL = "alacritty";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      NIXOS_OZONE_WL = "1";
    };
    sessionPath = [
      "$HOME/.npm-global/bin"
      "$HOME/.local/bin"
      "$HOME/go/bin"
      "$HOME/.krew/bin"
    ];
  };
}
