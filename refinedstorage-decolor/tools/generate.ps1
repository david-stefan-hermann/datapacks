# Regenerates packs/RefinedStorage-Decolor from a Refined Storage jar.
#
# For every coloured block family (grids, cables, controllers, ...) Refined Storage
# ships an item tag data/refinedstorage/tags/item/<family>.json listing all 16 colour
# variants. The entry without a colour prefix (e.g. refinedstorage:grid) is the default
# colour. This script emits one shapeless recipe per family that turns any of the other
# 15 variants back into the default one, so coloured blocks can be used in recipes that
# only accept the default variant.
param(
    [Parameter(Mandatory)] [string] $Jar
)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem

$root = Split-Path $PSScriptRoot -Parent
$utf8 = New-Object System.Text.UTF8Encoding($false)
$pack = Join-Path $root 'packs/RefinedStorage-Decolor'
$recipeDir = Join-Path $pack 'data/rsdecolor/recipe'

# Every vanilla dye colour; used to tell coloured variants from the default one.
$colours = @('white', 'orange', 'magenta', 'light_blue', 'yellow', 'lime', 'pink', 'gray',
             'light_gray', 'cyan', 'purple', 'blue', 'brown', 'green', 'red', 'black')
$colourPrefix = '^refinedstorage:(' + ($colours -join '|') + ')_(.+)$'

$src = [IO.Compression.ZipFile]::OpenRead((Resolve-Path $Jar).Path)
try {
    $tags = $src.Entries | Where-Object { $_.FullName -match '^data/refinedstorage/tags/item/[a-z_]+\.json$' }

    if (Test-Path $pack) { Remove-Item $pack -Recurse -Force }
    New-Item -ItemType Directory -Force $recipeDir | Out-Null

    $mcmeta = "{`n  `"pack`": {`n    `"description`": `"Refined Storage: craft coloured blocks back to the default colour`",`n    `"min_format`": [107, 1],`n    `"max_format`": 107`n  }`n}`n"
    [IO.File]::WriteAllText((Join-Path $pack 'pack.mcmeta'), $mcmeta, $utf8)

    $count = 0
    foreach ($entry in $tags) {
        $reader = New-Object IO.StreamReader($entry.Open())
        $json = $reader.ReadToEnd()
        $reader.Dispose()

        $ids = [regex]::Matches($json, '"(refinedstorage:[a-z_]+)"') | ForEach-Object { $_.Groups[1].Value }
        $coloured = @($ids | Where-Object { $_ -match $colourPrefix })
        $default = @($ids | Where-Object { $_ -notmatch $colourPrefix })

        # Only families with exactly one default variant plus 15 coloured ones are colour maps;
        # tags like storage_disks are skipped.
        if ($coloured.Count -ne 15 -or $default.Count -ne 1) { continue }

        $family = $default[0].Substring('refinedstorage:'.Length)
        $ingredients = ($coloured | ForEach-Object { "      `"$_`"" }) -join ",`n"
        $recipe = @"
{
  "type": "minecraft:crafting_shapeless",
  "category": "misc",
  "group": "rsdecolor",
  "ingredients": [
    [
$ingredients
    ]
  ],
  "result": {
    "id": "$($default[0])"
  }
}
"@
        [IO.File]::WriteAllText((Join-Path $recipeDir "$family.json"), ($recipe -replace "`r`n", "`n"), $utf8)
        "{0,-24} <- 15 coloured variants" -f $family
        $count++
    }
    "Generated $count recipes into $recipeDir"
} finally {
    $src.Dispose()
}
