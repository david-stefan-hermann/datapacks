# Energized Power: No Tin Ore

A datapack that stops [Energized Power](https://github.com/JDDev0/EnergizedPower) from generating its Tin Ore.

Useful when another mod already adds tin and you do not want two kinds of tin ore in the ground — for example alongside Tech Reborn.

## How it works

The pack overrides two of the mod's worldgen files:

- `configured_feature/tin_ore.json` becomes `minecraft:no_op`, a feature that places nothing.
- `placed_feature/tin_ore.json` gets an empty placement list.

Nothing else is touched. The Tin Ore block, its items and all recipes stay in the game — only world generation is disabled.

## Requirements

- Minecraft 26.2 (data pack format 107.1)
- Energized Power 3.0.0+26.2.x (Fabric)

## Installation

- **New world:** Create World → More → Data Packs → drop the zip in.
- **Existing world:** copy the zip to `saves/<world>/datapacks/` and reload the world. Worldgen changes need a full world load; `/reload` is not enough.

Only newly generated chunks are affected. Tin Ore in already explored areas stays where it is.

## Verifying in game (WorldEdit)

Stand in a freshly generated chunk and count — the result should be `0`:

```
//chunk
//outset -h 64
//count energizedpower:tin_ore,energizedpower:deepslate_tin_ore
```
