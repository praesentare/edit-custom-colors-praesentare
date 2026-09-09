# Builds the versioned skill package from package/ into dist/.
# The version comes from package/manifest.json, the file name from the skill
# folder, so both are set in exactly one place.

$ErrorActionPreference = 'Stop'

$root     = Split-Path -Parent $MyInvocation.MyCommand.Path
$source   = Join-Path $root 'package'
$dist     = Join-Path $root 'dist'
$manifest = Get-Content (Join-Path $source 'manifest.json') -Raw | ConvertFrom-Json
$name     = (Get-ChildItem -Path (Join-Path $source 'skills') -Directory | Select-Object -First 1).Name
$version  = $manifest.version
$target   = Join-Path $dist "$name-v$version.zip"

if (-not (Test-Path $dist)) { New-Item -ItemType Directory -Path $dist | Out-Null }
if (Test-Path $target) { Remove-Item $target }

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

# Entries are added one by one with an explicitly forward-slashed name.
# Neither Compress-Archive nor ZipFile::CreateFromDirectory does this on Windows
# PowerShell: both write backslashes, which package validators reject.
$prefix = (Resolve-Path $source).Path.TrimEnd('\') + '\'
$zip = [System.IO.Compression.ZipFile]::Open($target, 'Create')
try {
    foreach ($file in Get-ChildItem -Path $source -Recurse -File) {
        $entry = $file.FullName.Substring($prefix.Length).Replace('\', '/')
        [void][System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
            $zip, $file.FullName, $entry,
            [System.IO.Compression.CompressionLevel]::Optimal)
    }
} finally {
    $zip.Dispose()
}

Write-Host "Built $target"
