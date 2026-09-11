# Regenerates packs/x<N> from a Tech Reborn jar: copies every ore configured_feature and multiplies its "size".
param(
    [Parameter(Mandatory)] [string] $Jar,
    [int[]] $Factors = @(2, 3)
)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem

$root = Split-Path $PSScriptRoot -Parent
$utf8 = New-Object System.Text.UTF8Encoding($false)
$src  = [IO.Compression.ZipFile]::OpenRead((Resolve-Path $Jar).Path)
try {
    $ores = $src.Entries | Where-Object { $_.FullName -match '^data/techreborn/worldgen/configured_feature/.*_ore\.json$' }
    foreach ($factor in $Factors) {
        $pack = Join-Path $root "packs/x$factor"
        if (Test-Path $pack) { Remove-Item $pack -Recurse -Force }
        $featureDir = Join-Path $pack 'data/techreborn/worldgen/configured_feature'
        New-Item -ItemType Directory -Force $featureDir | Out-Null

        $mcmeta = "{`n  `"pack`": {`n    `"description`": `"Tech Reborn Ore Boost: vein size x$factor`",`n    `"min_format`": [107, 1],`n    `"max_format`": 107`n  }`n}`n"
        [IO.File]::WriteAllText((Join-Path $pack 'pack.mcmeta'), $mcmeta, $utf8)

        foreach ($entry in $ores) {
            $reader = New-Object IO.StreamReader($entry.Open())
            $json = $reader.ReadToEnd()
            $reader.Dispose()
            $m = [regex]::Match($json, '"size"\s*:\s*(\d+)')
            if (-not $m.Success) { throw "No size in $($entry.FullName)" }
            $old = [int]$m.Groups[1].Value
            $new = [Math]::Min($old * $factor, 64)  # ore feature size is capped at 64
            $json = $json.Substring(0, $m.Groups[1].Index) + $new + $json.Substring($m.Groups[1].Index + $m.Groups[1].Length)
            [IO.File]::WriteAllText((Join-Path $featureDir $entry.Name), $json, $utf8)
            "x{0}  {1,-22} {2,2} -> {3,2}" -f $factor, $entry.Name, $old, $new
        }
    }
} finally {
    $src.Dispose()
}
