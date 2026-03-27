{ pkgs, inputs, ... }:
{

  imports = [
  ];

  wayland.windowManager.hyprland = {
    plugins = [
      # https://github.com/KZDKM/Hyprspace
      # disabled due to https://github.com/KZDKM/Hyprspace/issues/184
      #inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      #inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix
    ];

  };
}
