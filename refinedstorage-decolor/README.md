# Refined Storage Decolor

A datapack that lets you craft any coloured [Refined Storage](https://github.com/refinedmods/refinedstorage2) block back into its default colour: put the coloured block alone into a crafting grid, take out the default one. No dye needed.

## Why

Refined Storage recipes that use a block as an ingredient (a Grid inside a Crafting Grid or Pattern Grid, a Cable inside an Importer or Exporter, ...) only accept the default-coloured variant. Once a block has been dyed, it cannot be used as a component any more. Refined Storage itself only offers the reverse route with dye (`light_blue_dye` or `gray_dye`, depending on the block), which this pack makes unnecessary.

## What it does

One shapeless recipe per block family, 21 in total:

| Family | Default colour |
|---|---|
| Autocrafter, Autocrafter Manager, Autocrafting Monitor | light blue |
| Controller, Creative Controller, Detector, Disk Interface, Relay, Security Manager | light blue |
| Grid, Crafting Grid, Pattern Grid | light blue |
| Network Receiver, Network Transmitter, Wireless Transmitter | light blue |
| Cable, Constructor, Destructor, Exporter, Importer, External Storage | gray |

Each recipe accepts any of the 15 non-default colours of that family and returns the default one. The recipes live in the `rsdecolor` namespace and appear in the recipe book under the group `rsdecolor`.

The recipe uses the vanilla shapeless type, so block-entity data stored on the item (for example the energy inside a Controller) is **not** carried over. Refined Storage's own dye recipes keep it; use those if that matters.

## Requirements

- Minecraft 26.2 (data pack format 107.1)
- Refined Storage 2 (Fabric build for 26.2, `refinedstorage` namespace)

The pack only references item ids, so it keeps working as long as Refined Storage keeps its block ids.

## Installation

Download `RefinedStorage-Decolor.zip` from the [releases](../../../releases) (tag `refinedstorage-decolor-v*`).

- **New world:** Create World → More → Data Packs → drop the zip in.
- **Existing world:** copy the zip to `saves/<world>/datapacks/` and run `/reload` (recipes reload without leaving the world).

## Verifying in game

Dye a Grid red, put the red Grid alone into a crafting table: the output is a plain Grid. `/recipe give @s rsdecolor:grid` unlocks it in the recipe book if it is not shown yet.

## Building

```powershell
# regenerate packs/ from a Refined Storage jar (reads the colour family item tags)
./tools/generate.ps1 -Jar path/to/refinedstorage-fabric-<version>.jar
# zip all packs in this repository into dist/
../tools/build.ps1
```

## Credits

Block ids come from Refined Storage 2, which is licensed under the MIT License.
