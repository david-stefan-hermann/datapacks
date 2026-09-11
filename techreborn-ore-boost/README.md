# Tech Reborn Ore Boost

A datapack that makes [Tech Reborn](https://github.com/TechReborn/TechReborn) ore veins bigger.

Only the vein size (`size` of each ore `configured_feature`) is changed. Height ranges, veins per chunk and deepslate variants stay exactly as in Tech Reborn.

## Variants

| Ore | Dimension | Default | x2 | x3 |
|---|---|---|---|---|
| Tin | Overworld | 8 | 16 | 24 |
| Galena | Overworld | 8 | 16 | 24 |
| Bauxite | Overworld | 6 | 12 | 18 |
| Lead | Overworld | 6 | 12 | 18 |
| Silver | Overworld | 6 | 12 | 18 |
| Ruby | Overworld | 6 | 12 | 18 |
| Sapphire | Overworld | 6 | 12 | 18 |
| Uranium | Overworld | 4 | 8 | 12 |
| Iridium | Overworld | 3 | 6 | 9 |
| Cinnabar | Nether | 6 | 12 | 18 |
| Pyrite | Nether | 6 | 12 | 18 |
| Sphalerite | Nether | 6 | 12 | 18 |
| Peridot | End | 6 | 12 | 18 |
| Sheldonite | End | 6 | 12 | 18 |
| Sodalite | End | 6 | 12 | 18 |
| Tungsten | End | 6 | 12 | 18 |

`size` is the upper bound of a vein, so the actual block count still varies. On average it scales with the value.

## Requirements

- Minecraft 26.2 (data pack format 107.1)
- Tech Reborn 6.1.1 (Fabric)

Other versions are untested. The pack keeps working as long as Tech Reborn does not change its ore feature files.

## Installation

Download **one** variant from the [releases](../../../releases) (tag `techreborn-ore-boost-v*`) — installing both makes the one loaded last win.

- **New world:** Create World → More → Data Packs → drop the zip in.
- **Existing world:** copy the zip to `saves/<world>/datapacks/` and reload the world. Worldgen changes need a full world load; `/reload` is not enough.

Only newly generated chunks are affected.

## Verifying in game (WorldEdit)

Stand in a freshly generated chunk, select it and count:

```
//chunk
//outset -h 64
//count techreborn:tin_ore,techreborn:deepslate_tin_ore
```

Compare the result with an area generated before the pack was installed.

## Building

```powershell
# regenerate packs/ from a Tech Reborn jar (default factors: 2 and 3)
./tools/generate.ps1 -Jar path/to/TechReborn-6.1.1.jar
# zip all packs in this repository into dist/
../tools/build.ps1
```

## Credits

The ore feature files are derived from Tech Reborn, which is licensed under the MIT License.
