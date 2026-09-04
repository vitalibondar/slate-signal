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
    -- 2026-09-04: the bar is translucent per theme (each theme ships a
    -- shell.bar.toml: Day 0.5, Night 0.7). Blur is switched on only for the
    -- omarchy-bar layer (layer_rule below); windows keep opacity 1.0.
    blur = {
      enabled = true,
      size = 6,
      passes = 2,
    },
  },
})

-- Translucent bar: blur under the omarchy-bar layer so text stays readable
-- over busy wallpapers; ignore_alpha keeps fully transparent pixels unblurred.
hl.layer_rule({ match = { namespace = "omarchy-bar" }, blur = true, ignore_alpha = 0.2 })
