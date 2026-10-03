---
name: blender-character-animation
description: Animate organic rigs using pose blocking, breakdowns, IK/FK, arcs, root motion, shape keys, Actions and NLA.
---

# Blender Character Animation

Workflow:
reference -> key poses -> breakdowns -> spline -> polish -> loop/export verification.

Start with readable key poses rather than dense keys.

Check:
- timing and spacing;
- anticipation;
- follow-through;
- overlap;
- arcs;
- weight transfer;
- silhouette;
- contacts;
- center of mass.

Use IK for planted hands/feet and contacts.
Use FK for free arcs and swinging motion.

Decide whether locomotion is in-place or root-motion and keep it consistent with export needs.

Use shape keys for expressions and corrective deformation.
Use separate Actions for reusable clips and NLA for sequencing/layering.
