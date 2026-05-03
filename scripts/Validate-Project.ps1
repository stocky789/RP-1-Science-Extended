param(
  [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$errors = New-Object System.Collections.Generic.List[string]

$requiredFiles = @(
  'README.md',
  'CHANGELOG.md',
  'LICENSE',
  'RP1ExtendedScience.netkan',
  'GameData/RP-1-Extended Science/RP1ExtendedScience.version',
  'GameData/RP-1-Extended Science/Patches/RP1ES_Experiments.cfg',
  'GameData/RP-1-Extended Science/Patches/RP1ES_CapsulePartPatches.cfg',
  'GameData/RP-1-Extended Science/Patches/RP1ES_StationPartPatches.cfg'
)

foreach ($relative in $requiredFiles) {
  $path = Join-Path $Root $relative
  if (-not (Test-Path -LiteralPath $path)) {
    $errors.Add("Missing required file: $relative")
  }
}

$netkanPath = Join-Path $Root 'RP1ExtendedScience.netkan'
if (Test-Path -LiteralPath $netkanPath) {
  $netkan = Get-Content -LiteralPath $netkanPath -Raw
  foreach ($pattern in @(
    'spec_version:\s*v1\.34',
    'identifier:\s*RP1ExtendedScience',
    'author:\s*\r?\n\s*-\s*stocky789',
    '\$kref:\s*''#/ckan/github/stocky789/RP-1-Science-Extended/asset_match/RP-1-Science-Extended-v\[0-9\]\+\\\.\[0-9\]\+\\\.\[0-9\]\+\\\.zip''',
    '\$vref:\s*''#/ckan/ksp-avc''',
    'depends:',
    'name:\s*RealSolarSystem',
    'suggests:',
    'supports:',
    'install:'
  )) {
    if ($netkan -notmatch $pattern) {
      $errors.Add("NetKAN check failed for pattern: $pattern")
    }
  }
}

$versionPath = Join-Path $Root 'GameData/RP-1-Extended Science/RP1ExtendedScience.version'
if (Test-Path -LiteralPath $versionPath) {
  $version = Get-Content -LiteralPath $versionPath -Raw
  foreach ($pattern in @(
    '"MAJOR": 1',
    '"MINOR": 0',
    '"PATCH": 0'
  )) {
    if ($version -notmatch $pattern) {
      $errors.Add("Version file check failed for pattern: $pattern")
    }
  }
}

$experimentsPath = Join-Path $Root 'GameData/RP-1-Extended Science/Patches/RP1ES_Experiments.cfg'
if (Test-Path -LiteralPath $experimentsPath) {
  $text = Get-Content -LiteralPath $experimentsPath -Raw
  $ids = [regex]::Matches($text, 'id = (RP1ES_[A-Za-z0-9_]+)') | ForEach-Object { $_.Groups[1].Value }
  $titles = [regex]::Matches($text, 'title = (.+)') | ForEach-Object { $_.Groups[1].Value.Trim() }

  if ($ids.Count -ne 20) {
    $errors.Add("Expected 20 experiment IDs, found $($ids.Count).")
  }

  if (($ids | Sort-Object -Unique).Count -ne $ids.Count) {
    $errors.Add("Experiment IDs are not unique.")
  }

  if (($titles | Sort-Object -Unique).Count -ne $titles.Count) {
    $errors.Add("Experiment titles are not unique.")
  }

  if ($text -match 'RP0[A-Za-z0-9_]') {
    $errors.Add("Unexpected RP0 namespace reference found in mod files.")
  }

  $expectedExperimentRules = @{
    'RP1ES_OneYearConsoleGamingMoraleStudy' = @{
      situationMask = '16'
      celestialBodies = 'Earth'
      bodyAllowed = 'HomeBody'
    }
    'RP1ES_OneYearCrewHealthBaseline' = @{
      situationMask = '16'
      celestialBodies = 'Earth'
      bodyAllowed = 'HomeBody'
    }
    'RP1ES_TwoYearComputerGamingAdaptationStudy' = @{
      situationMask = '16'
      celestialBodies = 'Earth'
      bodyAllowed = 'HomeBody'
    }
    'RP1ES_TwoYearMicrogravityAdaptationStudy' = @{
      situationMask = '48'
      celestialBodies = 'Earth;Moon'
      bodyAllowed = 'HomeBodyAndMoons'
    }
    'RP1ES_ThreeYearCrewLeisureDailyRoutineStudy' = @{
      situationMask = '16'
      celestialBodies = 'Earth'
      bodyAllowed = 'HomeBody'
    }
    'RP1ES_ThreeYearStationOperationsReliabilityStudy' = @{
      situationMask = '16'
      celestialBodies = 'Earth'
      bodyAllowed = 'HomeBody'
    }
    'RP1ES_FiveYearBoneMuscleCountermeasureTrial' = @{
      situationMask = '48'
      celestialBodies = 'Earth;Moon'
      bodyAllowed = 'HomeBodyAndMoons'
    }
    'RP1ES_FiveYearCrewRadiationDosimetryCohort' = @{
      situationMask = '32'
      celestialBodies = 'Earth;Moon'
      bodyAllowed = 'HomeBodyAndMoons'
    }
    'RP1ES_SixYearBehavioralHealthIsolationStudy' = @{
      situationMask = '48'
      celestialBodies = 'Earth;Moon'
      bodyAllowed = 'HomeBodyAndMoons'
    }
    'RP1ES_EightYearLifeSupportMaintenanceStudy' = @{
      situationMask = '48'
      celestialBodies = 'Earth;Moon'
      bodyAllowed = 'HomeBodyAndMoons'
    }
    'RP1ES_TenYearClosedLoopAtmosphereValidation' = @{
      situationMask = '48'
      celestialBodies = 'Earth;Moon'
      bodyAllowed = 'HomeBodyAndMoons'
    }
    'RP1ES_TwelveYearOrbitalGreenhouseOperationsStudy' = @{
      situationMask = '48'
      celestialBodies = 'Earth;Moon'
      bodyAllowed = 'HomeBodyAndMoons'
    }
    'RP1ES_FifteenYearClosedLoopHabitationDemonstration' = @{
      situationMask = '48'
      celestialBodies = 'Earth;Moon'
      bodyAllowed = 'HomeBodyAndMoons'
    }
    'RP1ES_TwentyYearGenerationalStationOperationsStudy' = @{
      situationMask = '48'
      celestialBodies = 'Earth;Moon'
      bodyAllowed = 'HomeBodyAndMoons'
    }
    'RP1ES_ThirtyYearPermanentHabitationSystemsTrial' = @{
      situationMask = '48'
      celestialBodies = 'Earth;Moon'
      bodyAllowed = 'HomeBodyAndMoons'
    }
    'RP1ES_FiveYearInterplanetaryRadiationDosimetryCohort' = @{
      situationMask = '32'
      celestialBodies = 'Mercury;Venus;Mars;Jupiter;Saturn;Uranus;Neptune;Pluto'
      bodyAllowed = 'Mercury|Venus|Mars|Jupiter|Saturn|Uranus|Neptune|Pluto'
    }
    'RP1ES_EightYearAutonomousLifeSupportOperationsStudy' = @{
      situationMask = '48'
      celestialBodies = 'Venus;Mars'
      bodyAllowed = 'Venus|Mars'
    }
    'RP1ES_TenYearMarsOrbitHabitationSystemsTrial' = @{
      situationMask = '48'
      celestialBodies = 'Mars'
      bodyAllowed = 'Mars'
    }
    'RP1ES_TwelveYearPlanetaryOrbitBehavioralAutonomyStudy' = @{
      situationMask = '48'
      celestialBodies = 'Mercury;Venus;Mars;Jupiter;Saturn;Uranus;Neptune;Pluto'
      bodyAllowed = 'Mercury|Venus|Mars|Jupiter|Saturn|Uranus|Neptune|Pluto'
    }
    'RP1ES_FifteenYearPlanetaryOrbitClosedLoopHabitatDemonstration' = @{
      situationMask = '48'
      celestialBodies = 'Venus;Mars'
      bodyAllowed = 'Venus|Mars'
    }
  }

  foreach ($id in $expectedExperimentRules.Keys) {
    $blockPattern = "id = $([regex]::Escape($id))(?<block>.*?)(?=\r?\nEXPERIMENT_DEFINITION|\z)"
    $match = [regex]::Match($text, $blockPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $match.Success) {
      $errors.Add("Expected experiment block was not found: $id")
      continue
    }

    $block = $match.Value
    $rule = $expectedExperimentRules[$id]
    foreach ($field in @('situationMask', 'celestialBodies')) {
      $expected = [regex]::Escape($rule[$field])
      if ($block -notmatch "(?m)^\s*$field = $expected\s*$") {
        $errors.Add("$id has invalid $field. Expected $($rule[$field]).")
      }
    }

    $expectedBodies = $rule.bodyAllowed -split '\|'
    foreach ($body in $expectedBodies) {
      $expectedBodyAllowed = [regex]::Escape($body)
      if ($block -notmatch "(?m)^\s*BodyAllowed = $expectedBodyAllowed\s*$") {
        $errors.Add("$id has invalid BodyAllowed. Expected $body.")
      }
    }

    if ($block -notmatch "(?m)^\s*dataScale = 0\.1\s*$") {
      $errors.Add("$id must set dataScale = 0.1 (Kerbalism DataSize = scienceCap * dataScale).")
    }
  }
}

$patchPath = Join-Path $Root 'GameData/RP-1-Extended Science/Patches/RP1ES_StationPartPatches.cfg'
if (Test-Path -LiteralPath $patchPath) {
  $patch = Get-Content -LiteralPath $patchPath -Raw
  if ($patch -notmatch 'Long-Duration Crew Science') {
    $errors.Add('Station patch must define Configure title Long-Duration Crew Science.')
  }
  if ($patch -notmatch 'type = Experiment') {
    $errors.Add('Station patch must use Kerbalism Configure SETUP Experiment submodules (type = Experiment).')
  }
  foreach ($id in @(
    'RP1ES_OneYearConsoleGamingMoraleStudy',
    'RP1ES_OneYearCrewHealthBaseline',
    'RP1ES_TwoYearComputerGamingAdaptationStudy',
    'RP1ES_TwoYearMicrogravityAdaptationStudy',
    'RP1ES_ThreeYearCrewLeisureDailyRoutineStudy',
    'RP1ES_ThreeYearStationOperationsReliabilityStudy',
    'RP1ES_FiveYearBoneMuscleCountermeasureTrial',
    'RP1ES_FiveYearCrewRadiationDosimetryCohort',
    'RP1ES_SixYearBehavioralHealthIsolationStudy',
    'RP1ES_EightYearLifeSupportMaintenanceStudy',
    'RP1ES_TenYearClosedLoopAtmosphereValidation',
    'RP1ES_TwelveYearOrbitalGreenhouseOperationsStudy',
    'RP1ES_FifteenYearClosedLoopHabitationDemonstration',
    'RP1ES_TwentyYearGenerationalStationOperationsStudy',
    'RP1ES_ThirtyYearPermanentHabitationSystemsTrial',
    'RP1ES_FiveYearInterplanetaryRadiationDosimetryCohort',
    'RP1ES_EightYearAutonomousLifeSupportOperationsStudy',
    'RP1ES_TenYearMarsOrbitHabitationSystemsTrial',
    'RP1ES_TwelveYearPlanetaryOrbitBehavioralAutonomyStudy',
    'RP1ES_FifteenYearPlanetaryOrbitClosedLoopHabitatDemonstration'
  )) {
    if ($patch -notmatch [regex]::Escape($id)) {
      $errors.Add("Station patch does not reference $id")
    }
  }
}

$capsulePatchPath = Join-Path $Root 'GameData/RP-1-Extended Science/Patches/RP1ES_CapsulePartPatches.cfg'
if (Test-Path -LiteralPath $capsulePatchPath) {
  $capsulePatch = Get-Content -LiteralPath $capsulePatchPath -Raw

  foreach ($pattern in @(
    '#CrewCapacity\[>0\]',
    '@MODULE\[Configure\]:HAS\[#title\[Crew\?Science\]\]\]',
    '~TechRequired\[spaceStationPrototypes\]',
    '~TechRequired\[inflatableHabitats\]',
    'type = Experiment',
    'id_value = RP1ES_OneYearConsoleGamingMoraleStudy'
  )) {
    if ($capsulePatch -notmatch $pattern) {
      $errors.Add("Capsule patch check failed for pattern: $pattern")
    }
  }

  foreach ($id in @(
    'RP1ES_OneYearConsoleGamingMoraleStudy',
    'RP1ES_OneYearCrewHealthBaseline',
    'RP1ES_TwoYearComputerGamingAdaptationStudy',
    'RP1ES_TwoYearMicrogravityAdaptationStudy',
    'RP1ES_ThreeYearCrewLeisureDailyRoutineStudy'
  )) {
    if ($capsulePatch -notmatch [regex]::Escape($id)) {
      $errors.Add("Capsule patch does not reference $id")
    }
  }

  if ($capsulePatch -match 'RP1ES_ThreeYearStationOperationsReliabilityStudy') {
    $errors.Add("Station operations reliability study should not be available on capsule patches.")
  }
}

if ($errors.Count -gt 0) {
  $errors | ForEach-Object { Write-Error $_ }
  exit 1
}

Write-Host "Validation passed."

