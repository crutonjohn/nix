{ config, lib, pkgs, outputs, ... }: {

  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        "notify-i3" = "/usr/bin/i3-msg restart";
        "notify-sys" = ''
          notify-send -i display "Display profile" "$AUTORANDR_CURRENT_PROFILE"
        '';
        "change-dpi" = ''
          case "$AUTORANDR_CURRENT_PROFILE" in
            docked-*)
              DPI=108
              ;;
            mobile)
              DPI=192
              ;;
            *)
              echo "Unknown profile: $AUTORANDR_CURRENT_PROFILE"
              exit 1
          esac
          echo "Xft.dpi: $DPI" | /usr/bin/xrdb -merge
        '';
      };
    };
    profiles = {
      "docked-DP2" = {
        #        hooks = {
        #          preswitch = {
        #            "block" = "grep -q open /proc/acpi/button/lid/LID0/state";
        #            "notify-i3" = "${pkgs.i3}/bin/i3-msg restart";
        #          };
        #        };
        fingerprint = {
          DP-2 =
            "00ffffffffffff004c2d537000000000011e0104b57722783ac725b14b46a8260e5054bfef80714f810081c08180a9c0b3009500d1c0565e00a0a0a0295030203500a9504100001a000000fd00324b1e5a19000a202020202020000000fc004c433439473935540a20202020000000ff004831414b3530303030300a2020014b020313f146905a591f04132309070783010000023a801871382d40582c4500a9504100001e584d00b8a1381440f82c4500a9504100001e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024";
        };
        config = {
          DP-2 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "5120x1440_59.99";
            rate = "59.94";
            dpi = 108;
          };
          DP-1.enable = false;
          HDMI-1.enable = false;
          DP-3.enable = false;
          eDP-1.enable = false;
          DP-4.enable = false;
        };
      };
      "docked-DP4" = {
#        hooks = {
#          preswitch = {
#            "block" = "grep -q open /proc/acpi/button/lid/LID0/state";
#            "notify-i3" = "${pkgs.i3}/bin/i3-msg restart";
#          };
#        };
        fingerprint = {
          DP-4 = "00ffffffffffff004c2d537000000000011e0104b57722783ac725b14b46a8260e5054bfef80714f810081c08180a9c0b3009500d1c0565e00a0a0a0295030203500a9504100001a000000fd00324b1e5a19000a202020202020000000fc004c433439473935540a20202020000000ff004831414b3530303030300a2020014b020313f146905a591f04132309070783010000023a801871382d40582c4500a9504100001e584d00b8a1381440f82c4500a9504100001e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024";
        };
        config = {
          DP-4 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "5120x1440_60.00";
            rate = "59.94";
            dpi = 108;
          };
          DP-1.enable = false;
          HDMI-1.enable = false;
          DP-3.enable = false;
          eDP-1.enable = false;
        };
      };
      "docked-DP3" = {
        #        hooks = {
        #          preswitch = {
        #            "block" = ''
        #               exec grep -q open /proc/acpi/button/lid/LID0/state
        #            '';
        #          };
        #        };
        fingerprint = {
          DP-3 =
            "00ffffffffffff004c2d537000000000011e0104b57722783ac725b14b46a8260e5054bfef80714f810081c08180a9c0b3009500d1c0565e00a0a0a0295030203500a9504100001a000000fd00324b1e5a19000a202020202020000000fc004c433439473935540a20202020000000ff004831414b3530303030300a2020014b020313f146905a591f04132309070783010000023a801871382d40582c4500a9504100001e584d00b8a1381440f82c4500a9504100001e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024";
        };
        config = {
          DP-3 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "5120x1440_59.99";
            rate = "59.94";
            dpi = 108;
          };
          DP-1.enable = false;
          HDMI-1.enable = false;
          DP-2.enable = false;
          eDP-1.enable = false;
          DP-4.enable = false;
        };
      };
      "mobile" = {
        #        hooks = {
        #          preswitch = {
        #            "block" = ''
        #               exec grep -q closed /proc/acpi/button/lid/LID0/state
        #            '';
        #          };
        #        };
        fingerprint = {
          eDP-1 =
            "00ffffffffffff004d101615000000000a1f0104b52215780ad697af5033bb240b52540000000101010101010101010101010101010172e700a0f06045903020360050d21000001828b900a0f06045903020360050d210000018000000fe004a4e4a5939804c513135365231000000000002410332011200000b010a202001af02030f00e3058000e606050160602800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa";
        };
        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "3840x2400";
            rate = "59.99";
            dpi = 192;
          };
          DP-1.enable = false;
          HDMI-1.enable = false;
          DP-2.enable = false;
          DP-3.enable = false;
          DP-4.enable = false;
        };
      };
    };

  };
}
