{ config, pkgs, ... }:

{

# Packages
environment.systemPackages = with pkgs; [ tdesktop slack audacity libsForQt5.kdenlive sublime4 audacity gnome.geary wezterm onlyoffice-bin vim vscodium gimp element-desktop spotify libreoffice-fresh obsidian obs-studio discord marktext gparted krita gimp mpv alacritty aria2 tmate wget rustup go git python310 vte gcc btop ifuse bat exa cmake gnumake fzf yt-dlp tmux hyfetch tilix gzip pfetch figlet virt-manager distrobox nushell libreoffice-fresh codeblocks gnome.geary amberol gcolor3 fragments apostrophe blanket wike gnome-builder flatpak-builder jetbrains.pycharm-community gnome.gnome-terminal gnome.gnome-tweaks papirus-icon-theme neovide xfce.xfce4-settings bitwarden-cli chezmoi kubectl krew 
];

 # Blueman
 services.blueman.enable = true; 
 

 # Virt-Manager
 virtualisation.libvirtd.enable = true;
 programs.dconf.enable = true;

 # Flatpak
 services.flatpak.enable = true;
 xdg.portal.enable = true;
 # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

 # Non-free
 nixpkgs.config.allowUnfree = true;

 # Podman
 virtualisation.podman.enable = true;

 # ZSH
 programs.zsh.enable = true;
 programs.zsh.ohMyZsh.enable = true;
 programs.zsh.autosuggestions.enable = true;
 programs.zsh.syntaxHighlighting.enable = true;
 #programs.zsh.ohMyZsh.plugins = [ git ]

 # Usbmuxd
 services.usbmuxd.enable = true;

 # Java
 programs.java.enable = true;

 # Starship
 programs.starship.enable = true;

 # Alacritty
 programs.alacritty.enable = true;

 # KDE Connect
 programs.kdeconnect.enable = true;

}



