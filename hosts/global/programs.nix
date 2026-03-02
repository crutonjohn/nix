{ ... }:

{

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    fish.enable = true;
    zsh.enable = true;
    wireshark.enable = true;
  };

}
