{ pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
    lightdm
    pantheon.elementary-greeter
  ];

  environment.etc."lightdm/lightdm.conf".text = lib.mkAfter ''
  '
   [Seat:*]
   greeter-session=lightdm-yourgreeter-greeter
  ';

}
