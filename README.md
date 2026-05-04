# RP-1 Extended Science

RP-1 Extended Science is a Kerbalism config mod for RP-1 that adds long-duration crew and station science, including late-game planetary-orbit studies, for extended habitation gameplay.

## Goals

- Make stations matter beyond contracts.
- Add long-form crew science that fits RP-1 progression.
- Support both early station gameplay and late, multi-decade habitation.
- Keep the mod compatible with common RP-1 station part ecosystems without forcing them as hard dependencies.

## Release Scope

Version `v1.0.0` includes:

- 20 Kerbalism long-run experiments (Earth/Moon station line plus late planetary-orbit extensions).
- Experiments are Kerbalism **Configure** options (not always-on modules): capsules extend RP-1's existing **Crew Science** picker; crew parts without that (typical mod hulls) get a separate **Extended Crew Science** picker; station habs use **Long-Duration Crew Science** with tiered slot counts.
- Capsule support for the shorter non-station crew studies up to three years (same pattern as stock RP-1 capsule experiments such as Orbital Maneuvering).
- RP-1 station-tier progression for which studies appear on which hab parts.
- CKAN metadata (identifier `RP1ExtendedScience`) and `.version` (KSP-AVC) for installs under `GameData/RP-1-Extended Science`.
- `docs/infographic.html` as a browser/print-friendly overview of the same experiment sheet as the table below.

## Balance Model

The science curve is intentionally front-loaded enough to reward early station work, but not so high that one station trivializes the tech tree.

- 1-3 year studies are modest and approachable.
- 5-12 year studies are the core of the mod.
- 15-30 year Earth/Moon studies are capstones for serious station programs.
- Planetary-orbit studies are late-game, high-commitment extensions for interplanetary station players.

The design assumes players can run multiple studies in parallel, so individual values are meaningful but not excessive.

Kerbalism treats completed dataset size as `scienceCap * dataScale` (MiB). These experiments use `dataScale = 0.1`, so each finished file is **one tenth of its science cap in MiB** (~10 science per MiB). Part `data_rate` numerators match that total spread over the run duration, which keeps generation and archive sizes in line with RealAntennas/Kerbalism links without stuffing drives on weak deep-space rates.

Each experiment's **minimum crew** is set to match what the title and description imply (for example, one for solo morale or computer-adaptation logging, two for paired medical or maintenance work, three for group behavioral and isolation instruments or most planetary-orbit campaigns, four for multi-decade crew turnover and the fifteen-year Venus/Mars closed-loop capstone).

Short non-station crew studies are optional configure loadouts: RP-1 vehicles use **Crew Science** where RP-1 defines it; other crewed parts use **Extended Crew Science**. That keeps the part menu clean and avoids offering station-only work on generic crew hulls.

## Dependencies

Hard requirements (same as CKAN `depends`):

- `RP-1`
- `ModuleManager`
- `Kerbalism-Config-RO`
- `RealSolarSystem`

The experiments follow Real Solar System naming and RP-1 body-filter conventions:

- Early baseline, leisure, and station-operations studies are Earth low-orbit studies.
- Logistics-heavy physiology, life-support, greenhouse, and continuity studies are low-orbit station work around Earth or the Moon.
- Radiation, isolation, closed-loop habitation, and permanent habitation capstones are restricted to high space so they cannot all be farmed from the same low-orbit station.
- Planetary-orbit radiation, autonomy, and closed-loop studies use explicit RSS planet filters and narrower low/high orbit rules to keep the late game from becoming one universal experiment bus.

| Experiment | Duration | Crew | Science | Valid Location |
| --- | ---: | ---: | ---: | --- |
| Crew Morale and Recreation Survey | 1 year | 1 | 90 | Earth, Space Low |
| Orbital Crew Health Baseline | 1 year | 2 | 200 | Earth, Space Low |
| Computer Workload Adaptation Study | 2 years | 1 | 160 | Earth, Space Low |
| Microgravity Fungal Culture Study | 2 years | 2 | 350 | Earth or Moon, Space Low |
| Crew Leisure and Daily Routine Study | 3 years | 2 | 260 | Earth, Space Low |
| Station Operations Reliability Study | 3 years | 2 | 450 | Earth, Space Low |
| Bone and Muscle Countermeasure Trial | 5 years | 2 | 700 | Earth or Moon, Space Low |
| High-Orbit Crew Radiation Dosimetry | 5 years | 2 | 700 | Earth or Moon, Space High |
| Behavioral Health and Isolation Study | 6 years | 3 | 800 | Earth or Moon, Space High |
| Life Support Maintenance Study | 8 years | 2 | 950 | Earth or Moon, Space Low |
| Closed-Loop Atmosphere Validation | 10 years | 2 | 1100 | Earth or Moon, Space Low |
| Orbital Greenhouse and Crop Operations | 12 years | 2 | 1300 | Earth or Moon, Space Low |
| Closed-Loop Habitation Demonstration | 15 years | 3 | 1600 | Earth or Moon, Space High |
| Crew Turnover and Station Continuity | 20 years | 4 | 2000 | Earth or Moon, Space Low |
| Permanent Habitation Systems Trial | 30 years | 4 | 2600 | Earth or Moon, Space High |
| Interplanetary Radiation Dosimetry | 5 years | 3 | 950 | Mercury, Venus, Mars, Jupiter, Saturn, Uranus, Neptune, or Pluto, Space High |
| Autonomous Life Support Operations (Venus/Mars) | 8 years | 3 | 1250 | Venus or Mars, Space High |
| Mars-Orbit Habitation Systems Trial | 10 years | 3 | 1500 | Mars, Space Low |
| Planetary Crew Autonomy and Comms Delay | 12 years | 3 | 1750 | Mercury, Venus, Mars, Jupiter, Saturn, Uranus, Neptune, or Pluto, Space High |
| Planetary Closed-Loop Habitat Demonstration | 15 years | 4 | 2200 | Venus or Mars, Space High |

Optional part packs (CKAN `suggests` / `supports`; not required for the configs to load):

- `StationPartsExpansionRedux`, `HabTech2`, `CxAerospace`, `RN-SalyutStations`, `RN-Skylab`, `RN-SovietSpacecraft`
- `NearFutureConstruction`, `NearFutureElectrical`, `NearFutureSolar`, `ROCapsules`, `ROTanks`, `ROSolar`

## Installation

Install through CKAN once the NetKAN entry is published, or copy the `RP-1-Extended Science` folder from this repo's `GameData` tree into your KSP `GameData` directory (you should end up with `GameData/RP-1-Extended Science/...` next to your other mods).
