# Slate Signal

A day and night theme pair for Omarchy, and the pieces that make a pair behave as one: shared machine geometry, a contrast checker, and the design notes behind the choices.

The themes themselves are separate repos, because `omarchy theme install` wants one theme per repository:

- [Slate Signal Day](https://github.com/vitalibondar/omarchy-slate-signal-day-theme), light
- [Slate Signal Night](https://github.com/vitalibondar/omarchy-slate-signal-night-theme), dark

## The idea

I read a lot of text on a 14" 1920x1080 ThinkPad, and my eyesight is minus six. What I wanted was a desktop where the hierarchy is carried by lightness, one colour carries state, and a selected region is visible without hunting for it. Both themes use the same hues; only the lightness order flips. So if you switch by sunrise and sunset, the desktop feels like the same place at a different hour.

## What is in here

`machine/` holds the settings that should not move when the theme changes, because they are about your eyes and your panel, not about colour:

- `shell.toml`: shell font base size 15, spacing scaled with the font, an opaque bar, a real 2px focus ring so focus never reads like hover, and a slightly stronger text selection in shell inputs. Goes to `~/.config/omarchy/shell.toml` and is picked up live.
- `looknfeel.lua`: window border 3px and rounding 0, as a block for `~/.config/hypr/looknfeel.lua`. Omarchy 4 configures Hyprland in Lua.
- `hyprland-geometry.conf`: the same two settings in classic Hyprland syntax, if you are on a setup that still sources `.conf` files.

So `bin/omarchy-contrast-check` reads any Omarchy `colors.toml` and prints WCAG ratios for the pairs that matter (body, muted, accent, selection, the six status colours), with PASS, WARN and FAIL against the targets I used. It derives `selection_foreground` the way `omarchy-theme-color` actually does in 4.0.2, which is simply `bright_foreground`. It exits non-zero on any FAIL, so you can gate on it.

```sh
omarchy-contrast-check ~/.config/omarchy/themes/slate-signal-night/colors.toml
```

`design/HANDOFF.md` is the implementation brief the themes were built from. `design/risk-geometry.md` is an optional idea that did not ship: a left "risk bar" on buttons for dangerous actions. It would need changes to the shell's own `Button.qml`, and that lives in `/usr/share/omarchy`, so it is an upstream conversation and not something a theme can carry.

## Applying the whole thing

```sh
omarchy theme install https://github.com/vitalibondar/omarchy-slate-signal-day-theme.git
omarchy theme install https://github.com/vitalibondar/omarchy-slate-signal-night-theme.git
cp machine/shell.toml ~/.config/omarchy/shell.toml        # review first if you already have one
# add the block from machine/looknfeel.lua to ~/.config/hypr/looknfeel.lua
omarchy display text size 15
omarchy theme set slate-signal-night
```

And if you already run a sunrise/sunset switcher, point it at `slate-signal-day` and `slate-signal-night` and you are done.

## Status

Fresh as of 3 September 2026, verified against Omarchy 4.0.2. Previews for the theme switcher and the catalog are still to come. Feedback on how it reads on other panels is welcome; say which screen and which theme.

## Credits

The palette, the selection study and the override count were worked out in Claude Design against the real Omarchy templates, and the install was done with Claude Code. Wallpapers were generated with ChatGPT for this pair. MIT.
