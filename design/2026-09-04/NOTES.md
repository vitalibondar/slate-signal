# Live-use notes, 2026-09-04 (first day on the themes)

What moved after the handoff, and why. Values are the ones now in the repos.

## Bar: translucent per theme
Vitalii's first live look: the wallpaper's own frame sits in the bar's tone, so an opaque
bar read as an asymmetric frame (the bar is taller than the frame). Eight variants were
compared live on Day (see `bar-transparency-contact-sheet.png`, V0 = handoff). Chosen: V2,
alpha 0.5 on Day, 0.7 on Night, with Hyprland blur size 6 / passes 2 on the bar layer only.
Rejected: heavy blur (distorts), no blur (flowers under the clock), fully transparent mode.
Mechanism: each theme ships `shell.bar.toml`; Omarchy merges it into the generated
`shell.toml`. The machine file no longer sets the alpha.

## Typography: one scale, even numbers
Omarchy's `display text size` couples bar, terminal and GTK, but its formula makes GTK
~1.25x the terminal (at 15: bar 15px, terminal 11pt = 14.7px, GTK 14pt = 18.7px). That
read as three unrelated sizes. Fix: text size 14 (even, so the display applet can still
step it) plus GTK interface font `Adwaita Sans 10` instead of 11; the applet multiplies
that base, so GTK stays ~1.1x the terminal at 12/14/16. Result at 14: bar 14px, terminal
11pt = 14.7px, GTK 11.8pt = 15.8px.

## Wallpapers: 3840x2160
The ChatGPT sources are 1672x941 and there is no larger original. Recraft "crisp upscale"
(no regeneration) took them to 4096x2305, then Lanczos to 3840x2160. Creative upscale was
tried and rejected: it redraws berries and flowers (`wallpaper-upscale-compare-3way.png`).
Open question for the designer: the frame does not survive Omarchy's crop on 16:10, 3:2 or
21:9 screens.
