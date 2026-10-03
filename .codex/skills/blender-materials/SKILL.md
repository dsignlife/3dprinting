---
name: blender-materials
description: Build and modify Blender materials through MCP using Principled BSDF, procedural textures, image textures, UVs and clean material organization.
---

# Blender Materials

Use Principled BSDF as the default physically based material.

## Workflow
1. Inspect current material slots.
2. Identify real material boundaries.
3. Build simple PBR material first.
4. Add textures/procedural detail only when needed.
5. Verify UVs for image textures.
6. Avoid unnecessarily complex node graphs.

For visual references, match:
- base color;
- roughness;
- metallic;
- transmission;
- emission;
- normal detail.

For 3D-print-focused objects, remember that Blender material appearance usually does not determine physical print color unless downstream multi-material workflow explicitly uses it.
