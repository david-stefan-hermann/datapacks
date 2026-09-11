# Zips every pack source folder (<pack>/packs/<Name>) into dist/<Name>.zip,
# using forward-slash entry paths, as Minecraft expects.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$root = Split-Path $PSScriptRoot -Parent
$dist = Join-Path $root 'dist'
New-Item -ItemType Directory -Force $dist | Out-Null

$sources = Get-ChildItem (Join-Path $root '*/packs/*') -Directory
if (-not $sources) { throw "No pack sources found under */packs/*" }

foreach ($pack in $sources) {
    if (-not (Test-Path (Join-Path $pack.FullName 'pack.mcmeta'))) {
        throw "Missing pack.mcmeta in $($pack.FullName)"
    }
    $zipPath = Join-Path $dist "$($pack.Name).zip"
    if (Test-Path $zipPath) { Remove-Item $zipPath }
    $zip = [IO.Compression.ZipFile]::Open($zipPath, 'Create')
    try {
        foreach ($file in Get-ChildItem $pack.FullName -Recurse -File) {
            $relative = $file.FullName.Substring($pack.FullName.Length + 1)
            $entryName = $relative -replace '\\', '/'
            [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $file.FullName, $entryName) | Out-Null
        }
    } finally {
        $zip.Dispose()
    }
    "Built $zipPath"
}
