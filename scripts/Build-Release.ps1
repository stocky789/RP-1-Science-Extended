param(
  [switch]$SkipValidate
)

$ErrorActionPreference = 'Stop'
$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$versionPath = Join-Path $Root 'GameData/RP-1-Extended Science/RP1ExtendedScience.version'
$distDir = Join-Path $Root 'dist'

if (-not (Test-Path -LiteralPath $versionPath)) {
  Write-Error "Version file not found: $versionPath"
  exit 1
}

$verJson = Get-Content -LiteralPath $versionPath -Raw | ConvertFrom-Json
$major = [int]$verJson.VERSION.MAJOR
$minor = [int]$verJson.VERSION.MINOR
$patch = [int]$verJson.VERSION.PATCH
$versionTag = "v$major.$minor.$patch"
$zipName = "RP-1-Science-Extended-$versionTag.zip"
$zipPath = Join-Path $distDir $zipName

if (-not $SkipValidate) {
  $validateScript = Join-Path $Root 'scripts/Validate-Project.ps1'
  & $validateScript
  if (-not $?) {
    exit 1
  }
}

$gameData = Join-Path $Root 'GameData'
if (-not (Test-Path -LiteralPath $gameData)) {
  Write-Error "GameData folder not found: $gameData"
  exit 1
}

New-Item -ItemType Directory -Force -Path $distDir | Out-Null
if (Test-Path -LiteralPath $zipPath) {
  Remove-Item -LiteralPath $zipPath -Force
}

Compress-Archive -Path $gameData -DestinationPath $zipPath -CompressionLevel Optimal -Force

$sizeMb = [math]::Round((Get-Item -LiteralPath $zipPath).Length / 1MB, 2)
Write-Host "Built $zipName ($sizeMb MiB) -> $zipPath"
