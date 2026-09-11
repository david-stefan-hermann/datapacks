# Zips every folder in packs/ into dist/TechReborn-OreBoost-<name>.zip (forward-slash entry paths, as Minecraft expects).
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$root = Split-Path $PSScriptRoot -Parent
$dist = Join-Path $root 'dist'
New-Item -ItemType Directory -Force $dist | Out-Null

foreach ($pack in Get-ChildItem (Join-Path $root 'packs') -Directory) {
    $zipPath = Join-Path $dist "TechReborn-OreBoost-$($pack.Name).zip"
    if (Test-Path $zipPath) { Remove-Item $zipPath }
    $zip = [IO.Compression.ZipFile]::Open($zipPath, 'Create')
    try {
        foreach ($file in Get-ChildItem $pack.FullName -Recurse -File) {
            $entryName = $file.FullName.Substring($pack.FullName.Length + 1).Replace('\', '/')
            [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $file.FullName, $entryName) | Out-Null
        }
    } finally {
        $zip.Dispose()
    }
    "Built $zipPath"
}
