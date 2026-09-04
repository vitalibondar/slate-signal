# Slate Signal Day — експеримент з прозорістю верхньої панелі (2026-09-04)

Запит Vitalii 04.09.2026 після першого живого погляду на теми: на Day рамка обоїв у тон панелі
читається несиметрично, панель хочеться прозорішою; сильний blur (V2b) відхилено як надто спотворюючий.
Кожен варіант ставився наживо на кілька секунд і знімався `grim` (верхні 120 логічних px, 1920×150 фізичних).
Усі знімки — тема **Slate Signal Day**, обої 01 (дамаск), один і той самий стан столу.

## Оригінал дизайнера (Claude Design, handoff 03.09.2026)
- панель: `bar.background-alpha = 1.0` (непрозора, свідомо незалежна від обоїв), `bar.transparent = false`
- Hyprland: `decoration.blur.enabled = false` (дефолт Omarchy), жодних layer-правил для панелі

## Що змінювалось (і тільки це)
- `bar.background-alpha` — через машинний `~/.config/omarchy/shell.toml` як тимчасову ручку (у підсумку значення живуть per-theme у `themes/<name>/shell.bar.toml`)
- Hyprland `decoration.blur` (enabled/size/passes/noise/vibrancy) — наживо через `hyprctl eval`; у файлі `~/.config/hypr/looknfeel.lua` плюс `layer_rule blur + ignore_alpha 0.2` лише для шару `omarchy-bar`
- V6: `bar.transparent = true` у `~/.config/omarchy/shell.json` (режим Omarchy: фон панелі повністю прозорий, колір тексту шел підбирає під обої)
- Вікна не чіпались: opacity 1.0, blur їх не зачіпає

## Варіанти
| ID | Налаштування | Примітка | Файл |
|---|---|---|---|
| V0 | ORIGINAL (designer): alpha 1.0, blur off | baseline, as shipped by Claude Design | `V0-day-bar.png` |
| V1 | alpha 0.7, blur size 6 / passes 2 | first live change 04.09 08:16 | `V1-day-bar.png` |
| V2 | alpha 0.5, blur size 6 / passes 2 | current Day value in shell.bar.toml | `V2-day-bar.png` |
| V2b | alpha 0.5, blur size 12 / passes 3, noise 0.03, vibrancy 0.35 | REJECTED by Vitalii 08:29: distorts too much | `V2b-day-bar.png` |
| V3 | alpha 0.35, blur size 4 / passes 1 | more transparent, lighter blur | `V3-day-bar.png` |
| V4 | alpha 0.25, blur size 4 / passes 1 | more transparent still, lighter blur | `V4-day-bar.png` |
| V5 | alpha 0.35, blur off | transparency without any blur | `V5-day-bar.png` |
| V6 | TRANSPARENT MODE (Omarchy bar.transparent=true, auto text colour), blur off | alpha 0; shell picks text colour from wallpaper | `V6-day-bar.png` |

Контактний лист усіх варіантів: `contact-sheet.png`. Сирі дані знімків: `captures.json`.
