-- Environment variables for cursor theming, keyring, and X11 app integration.
--
-- PATH is handled by UWSM via xdg.configFile."uwsm/env" in default.nix
-- (sources home-manager's hm-session-vars.sh, which includes
-- home.sessionPath additions like ~/.local/bin).
--------------------
---- ENV VARS ------
--------------------
hl.config({env = {"AQ_DRM_DEVICES,/dev/dri/card1"}})
