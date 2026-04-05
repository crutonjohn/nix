{ pkgs, inputs, ... }:
{

  imports = [
  ];

  wayland.windowManager.hyprland = {
    plugins = [
      # https://github.com/KZDKM/Hyprspace
      # disabled due to https://github.com/KZDKM/Hyprspace/issues/184
      #inputs.Hyprspace.packages.${pkgs.stdenv.hostPlatform.system}.Hyprspace
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
      #inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.csgo-vulkan-fix
    ];

  };
}
