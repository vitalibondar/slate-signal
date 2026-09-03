# Optional patch — risk geometry for the shared Button (3c)
# APPROVED, OPTIONAL. Slate Signal is complete without this. Apply only if you
# want the redundant geometric risk cue on genuinely dangerous / irreversible
# actions. Default behaviour with the patch is IDENTICAL to upstream Omarchy.

## What it does
Adds a left "risk-bar" (a heavier left border) to buttons whose action is
genuinely dangerous or irreversible — the same visual motif Omarchy already uses
for the urgent notification. Corners stay square (no radius change), no other
control type is touched, and there are no per-call-site style overrides.

Validated at text size 15 on the target panel: danger 6px, critical 8px.
(6/10 read heavier than necessary; 5px danger sat too close to the 2px normal
border. 6/8 gives a clear danger<critical step while staying restrained.)

## Two independent axes (the corrected model)
Emphasis and risk are ORTHOGONAL and may combine — the confirm button in a
destructive dialog is emphasis=Primary AND risk=Critical.

    emphasis : Normal | Primary          # action hierarchy — fill/weight only
    risk     : None | Caution | Danger | Critical   # consequence

Geometry (the risk-bar) is spent ONLY on risk >= Danger:

    | risk      | left bar | colour role        | fill (with emphasis=Primary) |
    |-----------|----------|--------------------|------------------------------|
    | None      | 0        | accent / neutral   | accent fill                  |
    | Caution   | 0        | warm/urgent border | (rarely primary)             |
    | Danger    | 6px      | urgent outline+txt | urgent outline               |
    | Critical  | 8px      | urgent             | urgent fill (loudest)        |

Caution gets colour/icon/text treatment but NO bar and NO special geometry, so
"Remove widget" never looks like "Delete permanently".

## Style.qml — 2 tokens (scale with font via Style.space)
    readonly property int riskBarDanger:   Style.space(6)
    readonly property int riskBarCritical: Style.space(8)

## Button.qml — 2 enums, 2 properties, all defaulting to today's look
    enum Emphasis { Normal, Primary }
    enum Risk     { None, Caution, Danger, Critical }
    property int emphasis: Button.Emphasis.Normal
    property int risk:     Button.Risk.None

    // centralized — no per-call-site geometry
    readonly property int _riskBar:
          risk === Button.Risk.Critical ? Style.riskBarCritical
        : risk === Button.Risk.Danger   ? Style.riskBarDanger : 0
    readonly property color _intentColor:
          (risk >= Button.Risk.Caution) ? Color.urgent : Color.accent

    // radius unchanged: stays square, mirrors Hyprland rounding
    radius: Style.cornerRadius
    // left risk-bar composes with the existing BorderSurface border spec;
    // emphasis=Primary drives the accent (or urgent, when risk>=Danger) fill
    // through the SAME state precedence already in Button.qml. Focus ring,
    // hover, pressed, selected and disabled are untouched and still win.

## Preserve ConfirmDialog.qml — do NOT replace its semantics
ConfirmDialog already computes `destructive: index === 1` and swaps in
Color.urgent. Keep that. The patch only maps its existing flags onto the new
axes and lets risk>=Danger draw the bar:

    // cancel button
    emphasis: Button.Emphasis.Normal;  risk: Button.Risk.None
    // confirm button (non-destructive flow)
    emphasis: Button.Emphasis.Primary; risk: Button.Risk.None
    // confirm button (destructive flow)  — existing 'destructive' flag
    emphasis: Button.Emphasis.Primary
    risk: irreversible ? Button.Risk.Critical : Button.Risk.Danger

`irreversible` is a one-line prop the caller sets for permanent deletes /
power-off / factory reset; everything else destructive stays Danger.

## Call sites — name intent, nothing else
    Button { text: "Save";               emphasis: Emphasis.Primary }
    Button { text: "Remove widget";      risk: Risk.Caution }
    Button { text: "Forget network";     risk: Risk.Danger }
    Button { text: "Delete permanently"; emphasis: Emphasis.Primary; risk: Risk.Critical; }

## Guarantees
- Default (Normal / None) renders byte-for-byte like upstream — zero visual diff.
- No per-dialog hacks, no forked button components, no scattered radii.
- Danger/critical geometry lives only in Style.qml + Button.qml.
- 4.1 widget picker / drag-to-remove inherit the axes automatically.
- Geometry is redundant: colour + label + confirmation still fully carry meaning.
