# Notes from the first day, 2026-09-04

What moved after the handoff, and why. The values below are the ones in the repos now.

## The bar went translucent, per theme
On my first look at Day the wallpaper's own painted frame sat in the bar's tone, and the bar is taller than that frame. So the two together read as one lopsided frame. I compared eight variants live on Day; they are all on `bar-transparency-contact-sheet.png`, and V0 is the handoff. I kept V2: alpha 0.5 on Day and 0.7 on Night, with a light Hyprland blur under the bar only (size 6, passes 2). Heavy blur distorts the art, no blur leaves flowers under the clock, and the fully transparent mode does the same, so those three went out. Each theme carries its alpha in `shell.bar.toml`, and the machine file no longer sets it.

## One type scale, even numbers
Omarchy's `display text size` moves the bar, the terminal and GTK together, but its formula makes GTK about 1.25x the terminal. At 15 that was bar 15px, terminal 11pt (14.7px), GTK 14pt (18.7px), and it read as three unrelated sizes on one screen. The fix is text size 14, which is even so the display applet can still step it, plus the GTK interface font at 10pt instead of 11. The applet multiplies that base, so GTK stays about 1.1x the terminal at 12, 14 or 16. At 14 it is bar 14px, terminal 11pt (14.7px), GTK 11.8pt (15.8px).

## Wallpapers at 3840x2160
The ChatGPT sources are 1672x941 and there is no larger original. A crisp, non-generative upscale took them to 4096x2305, then Lanczos down to 3840x2160. I also tried the creative upscale and rejected it: it redraws berries and flowers, see `wallpaper-upscale-compare-3way.png`.

## The frame under crop
Omarchy fills the screen and crops, so on a 16:10 or 3:2 panel the frame survives on two sides only. The designer's call, same day: the frame is decorative, not part of the theme's identity. On this 16:9 panel it stays as shipped. For other ratios a frameless master would be the better choice; the damask bleeds fine, the bouquet needs its frame and stays 16:9 only.
