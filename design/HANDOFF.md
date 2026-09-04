# Slate Signal — Omarchy Day/Night theme pair · Claude Code handoff

A matched, accessibility-first theme pair for a ThinkPad T14s Gen 1 (14" 1920x1080,
restricted-gamut IPS) and a -6D user. Near-achromatic chassis, azure state identity,
luminance-led hierarchy, strong plain selection fill (no fragile per-app hacks).

## What's in this package
| Path | What it is | Where it goes |
|---|---|---|
| `themes/slate-signal-day/colors.toml`   | Day theme palette | `~/.config/omarchy/themes/slate-signal-day/` |
| `themes/slate-signal-night/colors.toml` | Night theme palette | `~/.config/omarchy/themes/slate-signal-night/` |
| `themes/slate-signal-day/backgrounds/`   | Day wallpapers (damask primary, bouquet companion). PART OF THE THEME | rides along with the theme dir |
| `themes/slate-signal-night/backgrounds/` | Night wallpapers (damask primary, bouquet companion). PART OF THE THEME | rides along with the theme dir |
| `themes/slate-signal-{day,night}/shell.toml` | Per-theme bar `background-alpha` (Day 0.5 / Night 0.7). The only per-theme shell key | rides along with the theme dir |
| `config/shell.toml`                     | Shared readability geometry (font 14, spacing, bar-alpha default, focus ring). THEME-INDEPENDENT except bar alpha | `~/.config/omarchy/shell.toml` |
| `config/hyprland-geometry.conf`         | Border width 3 / rounding 0 / under-bar blur. THEME-INDEPENDENT | source from `~/.config/hypr/hyprland.conf` |
| `bin/omarchy-contrast-check`            | Verifies every ratio in the brief on the real files | `~/.local/bin/` (chmod +x) |
| `patches/risk-geometry.md`               | OPTIONAL shared-Button patch: risk-bar for danger/critical actions (3c). Default = upstream | apply to `shell/Ui/Button.qml` + `shell/Commons/Style.qml` only if wanted |

## Wallpapers — part of the final pair
Each theme ships its own `backgrounds/` folder, so the wallpaper switches WITH the
theme automatically: `omarchy-theme-set` points the compositor at the active
theme's `backgrounds/`, and a day image is never shown under the night palette or
vice-versa. Two matched compositions ship per mode, filename-ordered:
- `01-*-primary-damask.png`  — **primary desktop**. All-over millefleur tile: any gap
  between tiled windows lands on balanced, full detail. This is the everyday
  backdrop.
- `02-*-companion-bouquet.png` — **companion**. Asymmetric spray (great lock screen /
  rotation); has intentional negative space, so weaker as the tiling backdrop.

Approved as-is against Slate Signal: cornflower/delphinium blue throughout matches
the azure accent (day `#16589f` / night `#82b4ea`); day grounds are warm cream at
mid-saturation, night grounds deep indigo — deliberately RICHER and more saturated
than the achromatic chassis, per the "decorative interlude, quiet UI" intent. The
opaque gray bar/menus never blend into the wallpaper, so no surface reads as
foreign. The only noted tension (warm cream ground vs. very slightly cool `#f3f4f6`
chassis) is left uncorrected on purpose: it reads as a pleasant warm peek and
cooling the paper would flatten the richness. Do NOT simplify these images.

To make the damask the default and keep the bouquet in rotation, the `01-` prefix
puts it first; `omarchy` picks the folder's first image on theme-set and can cycle
the rest. To pin one explicitly:
```sh
omarchy theme set slate-signal-night
# then, if you want to force a specific file:
omarchy background set 01-slate-signal-night-primary-damask.png
```

### Resolution & the frame under crop (2026-09-04)
Masters are now **3840x2160 (16:9)**, produced by a crisp non-generative upscale of
the 1672x941 sources then downscaled to 4K. A creative/generative upscale was
rejected: it redraws the berries and flowers and would silently fork the approved
artwork. Design unchanged.

The painted border is **decorative, not part of Slate Signal's identity** (which is
the achromatic chassis + azure state). Omarchy fills-and-crops, so a non-16:9 panel
keeps the frame on two sides only - the same lopsided-frame effect we just removed
from the bar. Decision: the target panel is 16:9 (1920x1080) and the masters are
16:9, so the frame survives **intact on this machine - keep it as shipped**. For any
non-16:9 display, prefer a frameless full-bleed master over a one-sided frame. The
all-over damask bleeds cleanly to the edge; the bouquet relies on its frame, so it
stays 16:9-only.

## Install & verify
```sh
mkdir -p ~/.config/omarchy/themes
cp -r themes/slate-signal-day  ~/.config/omarchy/themes/   # includes backgrounds/
cp -r themes/slate-signal-night ~/.config/omarchy/themes/   # includes backgrounds/
cp config/shell.toml ~/.config/omarchy/shell.toml            # review first if you have one
install -m755 bin/omarchy-contrast-check ~/.local/bin/

# gate on the numbers before applying anything
omarchy-contrast-check themes/slate-signal-day/colors.toml
omarchy-contrast-check themes/slate-signal-night/colors.toml

# geometry, then theme
# (add 'source = ~/.config/hypr/hyprland-geometry.conf' to hyprland.conf)
omarchy display text size 14
omarchy theme set slate-signal-night
```

## Selection: what was verified, and why it is a plain fill
Every target app exposes only a selection **fill + foreground** — there is no
selection-edge primitive anywhere. `colors.toml` carries a single `selection`
key; `omarchy-theme-set` derives `selection_foreground`/`selection_background`
from it. So the "2px accent rule" from the mockups is intentionally dropped and
the region is carried by a **stronger plain fill** instead. See the compatibility
table in the design doc. If `omarchy-contrast-check` reports the derived
`selection_foreground` below 4.5 on the band, force it to `bright_foreground` in
that theme's `colors.toml` — that is the only selection override that could ever
be needed, and only if the generator's pick disagrees.

## Live-use revisions (2026-09-04, first day on the target laptop)
Three things moved from the handoff in real use; all reviewed and accepted, with
previous values kept above and dated. Night is the stronger of the two themes.

1. **Translucent bar (was opaque `background-alpha = 1.0`).** Now Day 0.5 /
   Night 0.7 with a light under-bar blur (Hyprland blur size 6, passes 2; windows
   stay opaque). An opaque bar, taller than the wallpaper's own painted frame,
   read as a lopsided second frame; the blur frosts the panel so bar text keeps
   contrast. Asymmetry is intentional (Night's light-on-dark glyphs need the
   denser panel). Alphas are floors - raise Night toward 0.8 before dropping blur.
2. **Base size 14 (was 15).** Omarchy's ~1.25x GTK multiplier made 15 render as
   three unrelated sizes; even-14 + GTK 10pt gives one ~1.1x ramp (14 / 14.7 /
   15.8) and the applet can still step to 16. 14 is the floor, not the target.
3. **Wallpapers 3840x2160, crisp upscale.** See the wallpaper section above.

Frame-under-crop: decided - decorative, kept intact on this 16:9 panel, frameless
preferred on non-16:9. See the wallpaper section.

## Override count (derived from the software, not the mockup)
- **Per-theme template overrides: 1** (was 0). Border colors generate from the
  palette and selection is a palette value, so those still need no override - but
  as of 2026-09-04 the **bar `background-alpha` differs by theme** (Day 0.5,
  Night 0.7), and a machine file can't vary by theme, so each theme's
  `shell.toml` now carries that one line. Nothing else is per-theme.
- **Shared machine files (constant across Day & Night): 2** — `shell.toml`
  (font/spacing/bar/focus) and the Hyprland geometry snippet. Neither is a theme
  override; both are geometry/accessibility and must NOT change when you switch.
- Optional, only if wanted: a per-theme `shell.toml` to tint the focus ring /
  selection azure; a one-line VS Code `editor.selectionBackground` alpha bump
  (its default 0x60 blend makes selection the weakest of all apps).

## Optional: risk geometry (approved, not required)
See `patches/risk-geometry.md`. It adds two orthogonal axes to the shared Button —
`emphasis (Normal|Primary)` and `risk (None|Caution|Danger|Critical)` — and draws a
left risk-bar (6px danger / 8px critical) only for risk>=Danger. Square corners and
all other controls are untouched; default behaviour is identical to upstream. This
is a shell component change, NOT a theme file, so it is independent of Day/Night and
ships only if you want the redundant geometric cue. Emphasis and risk are separate
dimensions and combine (a destructive confirm button is Primary + Critical).

The round-1 claim of "exactly two overrides (shell.controls.toml + hyprland.lua)"
was wrong: the focus ring belongs in the shared machine file, not a per-theme
override, and the selection needs no override at all.

## Implementation notes (Claude Code, 2026-09-04, verified on Omarchy 4.0.2)
Written after the live-use revisions above were accepted. Three details of the
revision package do not match how Omarchy 4.0.2 actually applies files; the values
are all right, only the mechanism differs. The package files were corrected to
match; the text above is kept as the designer wrote it.

1. **Per-theme file is `shell.bar.toml`, not `shell.toml`.** A theme-shipped
   `shell.toml` *replaces* the whole generated shell.toml (`omarchy-theme-set-templates`
   skips generation when the file already exists in the theme), so a file holding
   only `[bar] background-alpha` would drop every other generated section. The
   sanctioned partial override is `shell.<section>.toml`: the script splices that
   section into the generated file, and the file must carry the **whole** `[bar]`
   section (background, background-alpha, text, active, scale-with-font,
   size-horizontal, size-vertical), because it replaces the section rather than
   patching one key. Precedence as assumed: the machine `~/.config/omarchy/shell.toml`
   wins over the theme, so the alpha must not appear there.
2. **GTK 10pt is a gsettings value, not a shell.toml key.** `gtk-interface-pt` is
   not read by the shell. The rule is applied with
   `gsettings set org.gnome.desktop.interface font-name 'Adwaita Sans 10'`; Omarchy's
   text-size command multiplies that base, and only `omarchy font set` rewrites it.
   `config/shell.toml` documents this in a comment instead of a fake key.
3. **`ignorealpha` must sit below the Day bar's own alpha.** With Day at 0.5, a
   threshold of 0.5 puts the bar's pixels at the cut-off and the Day bar loses its
   blur. The package uses `ignorealpha 0.2` (Lua: `ignore_alpha = 0.2`), which keeps
   fully transparent pixels unblurred and blurs both bars.

Omarchy 4 configures Hyprland in Lua; the geometry snippet in classic syntax is kept
for reference, the applied form is the `hl.config` / `hl.layer_rule` block in the
slate-signal repo's `machine/looknfeel.lua`.
