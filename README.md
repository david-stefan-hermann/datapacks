# Minecraft Datapacks

Small datapacks that tweak mods, built for **Minecraft 26.2** (data pack format 107.1) on Fabric.

| Pack | What it does | Mod |
|---|---|---|
| [techreborn-ore-boost](techreborn-ore-boost) | Makes ore veins 2x or 3x bigger | Tech Reborn 6.1.1 |
| [energizedpower-no-tin-ore](energizedpower-no-tin-ore) | Disables Tin Ore generation | Energized Power 3.0.0+26.2.x |
| [refinedstorage-decolor](refinedstorage-decolor) | Crafts coloured blocks back to the default colour, no dye | Refined Storage 2 (26.2 Fabric build) |

Each folder has its own README with the details. Downloads are on the [releases page](../../releases); tags are prefixed per pack, e.g. `techreborn-ore-boost-v1.0.0`.

## Installation (all packs)

- **New world:** Create World → More → Data Packs → drop the zip in.
- **Existing world:** copy the zip to `saves/<world>/datapacks/` and reload the world. Worldgen changes need a full world load; `/reload` is not enough.

Worldgen changes only affect newly generated chunks.

## Repository layout

```
<pack-name>/
  README.md
  packs/<ZipName>/      # pack source: pack.mcmeta + data/
  tools/                # optional, pack-specific scripts
tools/build.ps1         # zips every packs/<ZipName> into dist/<ZipName>.zip
```

## Building

```powershell
./tools/build.ps1
```

The zips land in `dist/`, which is not tracked by git.
