-- ~/.config/hypr/looknfeel.lua (Omarchy 4 configures Hyprland in Lua).
-- Machine-level, theme-independent geometry. Border colours come from the
-- active theme; only width and rounding live here, so switching Day <-> Night
-- never moves them. Add this block to your existing hl.config({...}) call or
-- drop the file in as-is if you have no looknfeel.lua overrides yet.
hl.config({
  general = {
    border_size = 3,   -- 2 -> 3: the focused window is unmistakable at a glance
  },
  decoration = {
    rounding = 0,      -- square corners give each border its full length
  },
})
