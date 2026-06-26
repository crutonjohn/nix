-----------------------
---- WINDOW RULES -----
-----------------------

-- Picture-in-Picture
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, size = "896 504" })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, move = "4158 46" })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, pin = true })

-- Discord Popout
hl.window_rule({ match = { initial_title = "^(Discord Popout)$" }, float = true })
hl.window_rule({ match = { initial_title = "^(Discord Popout)$" }, size = "1085 901" })
hl.window_rule({ match = { initial_title = "^(Discord Popout)$" }, pin = true })

-- xwaylandvideobridge (invisible capture helper)
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, opacity = "0.0 override" })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_anim = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_focus = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, max_size = "1 1" })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_blur = true })
