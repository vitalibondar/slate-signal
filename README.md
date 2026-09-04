# Slate Signal

A day and night theme pair for Omarchy, and the pieces that make a pair behave as one: shared machine geometry, a contrast checker, and the design notes behind the choices.

The themes themselves are separate repos, because `omarchy theme install` wants one theme per repository:

- [Slate Signal Day](https://github.com/vitalibondar/omarchy-slate-signal-day-theme), light
- [Slate Signal Night](https://github.com/vitalibondar/omarchy-slate-signal-night-theme), dark

## The idea

I read a lot of text on a 14" 1920x1080 ThinkPad, and I am short-sighted, so the pair is tuned for eyes like mine first. What I wanted was a desktop where the hierarchy is carried by lightness, one colour carries state, and a selected region is visible without hunting for it. Both themes use the same hues; only the lightness order flips. So if you switch by sunrise and sunset, the desktop feels like the same place at a different hour.

## What is in here

`machine/` holds the settings that should not move when the theme changes, because they are about your eyes and your panel, not about colour:

- `shell.toml`: shell font base size 14, spacing scaled with the font, a real 2px focus ring so focus never reads like hover, and a slightly stronger text selection in shell inputs. Goes to `~/.config/omarchy/shell.toml` and is picked up live. The bar's transparency is per theme (each theme ships a `shell.bar.toml`, Day 0.5 and Night 0.7), so it is deliberately absent here: this file would win over the theme.
- `looknfeel.lua`: window border 3px, rounding 0, and a light blur under the bar only (size 6, passes 2), as a block for `~/.config/hypr/looknfeel.lua`. Omarchy 4 configures Hyprland in Lua.
- `hyprland-geometry.conf`: the same settings in classic Hyprland syntax, if you are on a setup that still sources `.conf` files.

So `bin/omarchy-contrast-check` reads any Omarchy `colors.toml` and prints WCAG ratios for the pairs that matter (body, muted, accent, selection, the six status colours), with PASS, WARN and FAIL against the targets I used. It derives `selection_foreground` the way `omarchy-theme-color` actually does in 4.0.2, which is simply `bright_foreground`. It exits non-zero on any FAIL, so you can gate on it.

```sh
omarchy-contrast-check ~/.config/omarchy/themes/slate-signal-night/colors.toml
```

`design/HANDOFF.md` is the implementation brief the themes were built from, with the changes from the first day of use dated at the end. `design/2026-09-04/` has the notes and pictures behind those changes. `design/risk-geometry.md` is an optional idea that did not ship: a left "risk bar" on buttons for dangerous actions. It would need changes to the shell's own `Button.qml`, and that lives in `/usr/share/omarchy`, so it is an upstream conversation and not something a theme can carry.

## Applying the whole thing

```sh
omarchy theme install https://github.com/vitalibondar/omarchy-slate-signal-day-theme.git
omarchy theme install https://github.com/vitalibondar/omarchy-slate-signal-night-theme.git
cp machine/shell.toml ~/.config/omarchy/shell.toml        # review first if you already have one
# add the block from machine/looknfeel.lua to ~/.config/hypr/looknfeel.lua
omarchy display text size 14                              # even, so the display applet (steps of 2) can still move it
gsettings set org.gnome.desktop.interface font-name 'Adwaita Sans 10'   # GTK ~1.1x the terminal instead of Omarchy's ~1.25x
omarchy theme set slate-signal-night
```

And if you already run a sunrise/sunset switcher, point it at `slate-signal-day` and `slate-signal-night` and you are done.

## Status

Fresh as of 3 September 2026, verified against Omarchy 4.0.2. After the first day the bar went translucent, the text size settled at 14 with the GTK font at 10pt, and the wallpapers were upscaled to 3840x2160; the theme repos carry previews from that state. Feedback on how it reads on other panels is welcome; say which screen and which theme.

## Credits

The brief and every prompt came from ChatGPT (GPT-5.6). Claude Design executed them: the palette, the selection study and the override count, checked against the real Omarchy templates. Claude Code did the install. Wallpapers were generated with ChatGPT as well. MIT.
