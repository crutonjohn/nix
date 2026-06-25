{ ... }:
{
  ####################
  # Hyprland Scripts #
  ####################
  home.file.".local/bin/sunshine-start" = {
    source = ./scripts/sunshine-start.sh;
    executable = true;
  };
  home.file.".local/bin/sunshine-stop" = {
    source = ./scripts/sunshine-stop.sh;
    executable = true;
  };
}
