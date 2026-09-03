# Slate Signal — Omarchy Day/Night theme pair · Claude Code handoff

A matched, accessibility-first theme pair for a ThinkPad T14s Gen 1 (14" 1920x1080,
restricted-gamut IPS) and a short-sighted user. Near-achromatic chassis, azure state identity,
luminance-led hierarchy, strong plain selection fill (no fragile per-app hacks).

## What's in this package
| Path | What it is | Where it goes |
|---|---|---|
| `themes/slate-signal-day/colors.toml`   | Day theme palette | `~/.config/omarchy/themes/slate-signal-day/` |
| `themes/slate-signal-night/colors.toml` | Night theme palette | `~/.config/omarchy/themes/slate-signal-night/` |
| `themes/slate-signal-day/backgrounds/`   | Day wallpapers (damask primary, bouquet companion). PART OF THE THEME | rides along with the theme dir |
| `themes/slate-signal-night/backgrounds/` | Night wallpapers (damask primary, bouquet companion). PART OF THE THEME | rides along with the theme dir |
| `config/shell.toml`                     | Shared readability geometry (font 15, spacing, bar, focus ring). THEME-INDEPENDENT | `~/.config/omarchy/shell.toml` |
| `config/hyprland-geometry.conf`         | Border width 3 / rounding 0. THEME-INDEPENDENT | source from `~/.config/hypr/hyprland.conf` |
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
omarchy display text size 15
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

## Override count (derived from the software, not the mockup)
- **Per-theme template overrides: 0.** Border colors generate from the palette;
  selection is a palette value; no `shell.<section>.toml` per theme is required.
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
