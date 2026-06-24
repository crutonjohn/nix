-----------------------
---- KEYBINDS ---------
-----------------------
-- Brightness
hl.bind("XF86MonBrightnessUp",
        hl.dsp.exec_cmd("brightnessctl -d intel_backlight s +5%"))
hl.bind("XF86MonBrightnessDown",
        hl.dsp.exec_cmd("brightnessctl -d intel_backlight s 5%-"))

-- Lid switch
hl.bind("switch:off:Lid Switch", hl.dsp
            .exec_cmd('hyprctl keyword monitor "eDP-1, preferred, auto, 1.6"'),
        {locked = true})
hl.bind("switch:on:Lid Switch",
        hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, disable"'),
        {locked = true})
