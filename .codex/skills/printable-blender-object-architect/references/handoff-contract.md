# Planner → executor contract

The planner should remove design ambiguity. The executor should remove implementation ambiguity.

A good handoff contains:
- exact part names;
- datums;
- dimensions;
- feature coordinates;
- modifier/boolean intent;
- protected interfaces;
- orientation;
- validation measurements;
- output filenames.

Bad:
> Add two mounting holes on the back.

Good:
> Create CUT_MountHole_L and CUT_MountHole_R, cylinders parallel to +Y, diameter 4.4 mm, centers at X=-30 mm and X=+30 mm, Z=18 mm relative to DATUM_BACK_CENTER. Boolean Difference from PART_Backplate. Hole diameter is CRITICAL and must not be changed without reporting a conflict.

The executor may choose equivalent Blender API/MCP mechanics, but may not change the design intent silently.
