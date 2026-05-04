# RP-1 Extended Science

RP-1 Extended Science adds long-duration crew and station science to RP-1. It gives space stations and habitation builds something useful to do over the long haul, from early station work to multi-decade crewed programs and late-game planetary orbit missions.

## What It Adds

- 20 Kerbalism long-duration experiments for crewed stations and planetary orbit missions.
- Early studies for morale, health, operations, and routine station work.
- Mid-game experiments for life support, countermeasures, greenhouse operations, and closed-loop systems.
- Late-game capstones for multi-decade habitation and permanent crewed stations.
- Planetary-orbit studies for Mercury, Venus, Mars, Jupiter, Saturn, Uranus, Neptune, and Pluto.

## How It Fits RP-1

The configs are set up to fit RP-1's progression rather than replace it.

- Capsule parts use RP-1's existing `Crew Science` menu where available.
- Other crewed parts get a separate `Extended Crew Science` menu.
- Station habitation parts use `Long-Duration Crew Science` with tiered slot counts.
- Experiment availability follows RP-1 station tiers and stock RSS body filters.

## Experiment List

```text
Experiment                                  Duration   Crew   Science   Valid Location
Crew Morale and Recreation Survey           1 year     1      90        Earth, Space Low
Orbital Crew Health Baseline                1 year     2      200       Earth, Space Low
Computer Workload Adaptation Study          2 years    1      160       Earth, Space Low
Microgravity Fungal Culture Study           2 years    2      350       Earth or Moon, Space Low
Crew Leisure and Daily Routine Study        3 years    2      260       Earth, Space Low
Station Operations Reliability Study        3 years    2      450       Earth, Space Low
Bone and Muscle Countermeasure Trial        5 years    2      700       Earth or Moon, Space Low
High-Orbit Crew Radiation Dosimetry         5 years    2      700       Earth or Moon, Space High
Behavioral Health and Isolation Study       6 years    3      800       Earth or Moon, Space High
Life Support Maintenance Study              8 years    2      950       Earth or Moon, Space Low
Closed-Loop Atmosphere Validation          10 years    2      1100      Earth or Moon, Space Low
Orbital Greenhouse and Crop Operations      12 years    2      1300      Earth or Moon, Space Low
Closed-Loop Habitation Demonstration       15 years    3      1600      Earth or Moon, Space High
Crew Turnover and Station Continuity       20 years    4      2000      Earth or Moon, Space Low
Permanent Habitation Systems Trial         30 years    4      2600      Earth or Moon, Space High
Interplanetary Radiation Dosimetry          5 years    3      950       Mercury, Venus, Mars, Jupiter, Saturn, Uranus, Neptune, or Pluto, Space High
Autonomous Life Support Operations          8 years    3      1250      Venus or Mars, Space High
Mars-Orbit Habitation Systems Trial        10 years    3      1500      Mars, Space Low
Planetary Crew Autonomy and Comms Delay    12 years    3      1750      Mercury, Venus, Mars, Jupiter, Saturn, Uranus, Neptune, or Pluto, Space High
Planetary Closed-Loop Habitat Demonstration 15 years    4      2200      Venus or Mars, Space High
```

## Requirements

Hard requirements:

- `RP-1`
- `ModuleManager`
- `Kerbalism-Config-RO`
- `RealSolarSystem`

Optional part packs are supported but not required:

- `StationPartsExpansionRedux`
- `HabTech2`
- `CxAerospace`
- `RN-SalyutStations`
- `RN-Skylab`
- `RN-SovietSpacecraft`
- `NearFutureConstruction`
- `NearFutureElectrical`
- `NearFutureSolar`
- `ROCapsules`
- `ROTanks`
- `ROSolar`

## Installation

Copy the `RP-1-Extended Science` folder from this repo's `GameData` tree into your KSP `GameData` directory so it ends up as `GameData/RP-1-Extended Science/...`.
