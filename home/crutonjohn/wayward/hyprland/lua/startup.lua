-- Run on every reload
hl.exec_cmd("kanshictl reload")
hl.exec_cmd("systemctl restart --user waybar")
hl.exec_cmd("systemctl restart --user hyprpaper")
