# P2S manufacturing baseline

Use these only as machine-level baseline data, not as a replacement for the active slicer profile.

- Machine: Bambu Lab P2S
- Nominal build volume: 256 × 256 × 256 mm
- Included/default nozzle: 0.4 mm
- Supported nozzle diameters: 0.2 / 0.4 / 0.6 / 0.8 mm
- Filament diameter: 1.75 mm

## Planning rules

1. The active Bambu/Orca profile is authoritative for usable plate regions and machine-specific exclusions.
2. If the object is near the bed limit, plan a split rather than using a nominal bounding-box check as proof of printability.
3. Do not prescribe a layer height, temperature, flow, or support profile by fabrication. Use a real installed slicer profile.
4. Material matters. PLA, PETG, ABS/ASA, TPU, filled materials, etc. can require different fit and geometry decisions.
5. When fit is critical, measured calibration beats a generic internet tolerance.
