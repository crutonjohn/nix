-----------------------
---- WINDOW RULES -----
-----------------------

-- Picture-in-Picture
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, size = "896 504" })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, move = "4158 46" })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, pin = true })

-- Discord Popout
hl.window_rule({ match = { initialTitle = "^(Discord Popout)$" }, float = true })
hl.window_rule({ match = { initialTitle = "^(Discord Popout)$" }, size = "1085 901" })
hl.window_rule({ match = { initialTitle = "^(Discord Popout)$" }, pin = true })

-- xwaylandvideobridge (invisible capture helper)
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, opacity = "0.0 override" })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, noanim = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, noinitialfocus = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, maxsize = "1 1" })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, noblur = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, nofocus = true })
