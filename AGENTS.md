# AGENTS.md — Codex + Blender MCP + Bambu P2S Workspace

## Purpose

This repository is a Codex-driven Blender and 3D-printing workspace.

Primary use cases include:

- recreating 3D objects from one or more images;
- modifying existing `.blend`, `.glb`, `.gltf`, `.fbx`, `.obj`, or mesh assets;
- rigging and animating objects;
- creating mechanical/object animation;
- creating organic/character animation;
- creating procedural geometry;
- preparing validated geometry for Bambu Lab P2S printing.

Use repo skills under `.codex/skills/` for Blender decision-making and execution.

---

# Blender skill routing

Before substantial Blender work:

1. inspect `.codex/skills/`;
2. use `blender-task-router` first for broad, ambiguous, or multi-stage work;
3. select only the relevant specialist skills;
4. choose modeling, topology, animation, and validation strategies before detailed execution.

Typical routing:

```text
request
  ↓
blender-task-router
  ↓
image/model/text input analysis
  ↓
modeling strategy
  ↓
topology strategy
  ↓
animation strategy
  ↓
Blender MCP execution
  ↓
reference/scene QA
  ↓
print preparation when needed
```

Do not automatically create an armature just because the user says “animate.”

Prefer the simplest robust mechanism:
- object transforms;
- parent hierarchy;
- constraints;
- drivers;
- armatures/IK/FK;
- shape keys;
- physics;
depending on the actual motion.

---

# Image-to-3D

For image-based reconstruction, use relevant skills such as:

- `blender-image-to-3d-director`
- `blender-multiview-calibration`
- `blender-reference-to-3d`
- `blender-hard-surface`
- `blender-sculpting-organic`
- `blender-topology-retopology`
- `blender-reference-qa`

A single image does not reveal exact hidden geometry or depth.

Do not pretend unseen geometry is known.

Use measurable reference gates such as:
- silhouette;
- proportions;
- landmark positions;
- negative spaces;
- joint centers;
- repeated-feature spacing.

---

# Animation

Use `blender-animation-strategy` for non-trivial animation.

Examples:

```text
spinning propeller
→ object rotation
→ correct shaft origin
→ linear interpolation
→ perfect loop
```

```text
hinged door
→ origin on hinge
→ constrained/keyed rotation
```

```text
robotic arm
→ rigid hierarchy or armature
→ joint axes and limits
→ IK only if endpoint control helps
```

```text
human/creature
→ animation-ready topology
→ armature
→ weights
→ IK/FK
→ deformation testing
```

Do not use simulation when deterministic keyframes/constraints/drivers are simpler.

---

# Digital animation vs physical printed movement

Digital Blender movement can use:
- bones;
- keyframes;
- constraints;
- drivers;
- physics;
- shape keys.

Physical printed movement requires actual geometry:
- hinges;
- pins;
- shafts;
- sockets;
- bearings;
- flexures;
- clearances;
- multiple printable bodies.

A Blender rig does not make a printed model physically movable.

---

# Blender MCP connection architecture

Blender runs on Computer 2.

Codex and Docker run on Computer 1.

There is NO SSH tunnel.

The connection is direct over the trusted home LAN:

```text
Computer 1

VS Code / Codex
      ↓
docker exec -i
      ↓
3d-mcp-tools
      ↓
mcp-for-blender
      ↓
BLENDER_HOST:9876
      │
      │ trusted home LAN
      ▼

Computer 2

Windows Firewall
(restricted to Computer 1 IP)
      ↓
Blender MCP server
      ↓
Blender
```

`BLENDER_HOST` is Computer 2's LAN IPv4 address and comes from `.env`.

Example:

```env
BLENDER_HOST=192.168.1.50
BLENDER_PORT=9876
```

Do not use `host.docker.internal` for Blender in this direct-LAN configuration.

Do not use `127.0.0.1` inside Docker for Blender.

---

# Direct LAN security

Blender MCP should only be reachable on the trusted LAN.

Computer 2's firewall rule should:
- allow TCP 9876;
- use the Private network profile;
- restrict `RemoteAddress` to Computer 1's LAN IP.

Do not create an unrestricted Internet/public-network firewall rule for port 9876.

Do not forward port 9876 on the router.

Do not expose Blender MCP to the public Internet.

Keep `BLENDER_MCP_SAFE_MODE=1`.

---

# Connection troubleshooting

If Blender MCP is unreachable:

1. verify Blender is running on Computer 2;
2. verify Blender MCP server is started;
3. verify something is listening on TCP 9876;
4. verify the listener is LAN-reachable, not only `127.0.0.1`;
5. verify Computer 2 firewall permits Computer 1's LAN IP;
6. from Computer 1 run:
   `scripts/check-blender-lan.ps1`;
7. only after native LAN connectivity works, investigate Docker or Codex MCP configuration.

Do not add SSH/tunneling as an automatic fix.

---

# Blender execution rules

Use the `blender` MCP server for Blender operations.

Before modifying the scene:
- inspect the scene;
- inspect relevant objects;
- inspect dimensions/transforms;
- inspect existing rigs/Actions where applicable;
- understand hierarchy and current selection.

Do not invent MCP tool names or schemas.
Discover and use the available MCP tools.

Prefer reversible/non-destructive editing during iteration.

Suggested names:
- `PART_*`
- `CUT_*`
- `DATUM_*`
- `REF_*`

Save editable `.blend` source before destructive final export.

---

# Precision and QA

Use numeric values for fit-critical geometry.

Preserve user-defined critical dimensions.

Validate as relevant:
- dimensions;
- normals;
- disconnected geometry;
- manifold/watertight state;
- zero-thickness geometry;
- unintended internal faces;
- pivots;
- constraints;
- frame range;
- F-curves;
- loop boundary;
- reference match;
- exported artifact.

Do not claim work is accurate, animation-ready, or print-ready unless relevant validation was performed.

---

# Printing

For printable output use:
- `blender-printability-director`
- `blender-print-prep`

Validate:
- scale;
- critical dimensions;
- wall thickness;
- clearances;
- body count;
- manifold/watertight state;
- orientation;
- exported STL/3MF.

The Docker toolbox contains:
- `mesh-python`
- `trimesh`
- `manifold3d`
- `numpy`
- `Pillow`

The repo is mounted at `/workspace`.

---

# Bambu Lab P2S

Use the `bambu` MCP for printer state and supported printer operations.

Never echo or commit `.env` secrets.

Physical state changes require explicit user intent.

Do not start/cancel/pause/resume/heat/move/load/unload unless explicitly requested.

“Make printable”, “prepare”, “slice”, or “upload” does not authorize starting a print.

---

# Files

Prefer:

```text
references/
specs/
models/
output/
```

Do not commit `.env`.
