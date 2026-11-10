# UMP Roblox Port (v1)

This folder contains a first playable Roblox Studio port of **UMP: Ultimate Math Practice**.

## What is included
- The same eight topic groups as the current web game: square roots, powers, short multiplication, equations, logarithms, trigonometry, derivatives, and integrals.
- Formula reference screen.
- Formula recall questions followed by randomized numerical practice.
- Three answer choices, shuffled order, 30-second timer, immediate feedback, and mistake retries.
- Session score, mistake explanations, topic breakdown, and spaced-review schedule.
- English/Russian interface labels and formula prompts.
- Server-side DataStore persistence for attempts and review intervals.
- No leaderboard, multiplayer mechanics, shop, or monetization.

## Project structure
- `default.project.json` — Rojo project mapping.
- `src/ReplicatedStorage/UMP/FormulaData.lua` — topic/formula data and randomized question generation.
- `src/StarterPlayer/StarterPlayerScripts/UMP.client.lua` — UI and gameplay.
- `src/ServerScriptService/UMPData.server.lua` — saved progress.

## Open in Roblox Studio
This is a Rojo source project. Install Rojo, open a terminal in this folder, and run:

```bash
rojo serve
```

Then connect from the Rojo plugin in Roblox Studio. Alternatively, create the same folders and copy each Lua file into a ModuleScript/LocalScript/Script with the matching name.

For DataStore testing in Studio, publish the experience and enable **Game Settings → Security → Enable Studio Access to API Services**. The experience can still be played without this setting, but progress will not persist reliably in Studio.

## Known v1 porting differences
Roblox TextLabels do not natively render KaTeX, so formulas are represented using Unicode mathematical notation. This keeps the formula content readable but some complex fractions/radicals may look less polished than the web version. The screen layout and background are recreated with Roblox UI primitives rather than browser CSS/SVG. These are implementation details we can refine in later iterations.
