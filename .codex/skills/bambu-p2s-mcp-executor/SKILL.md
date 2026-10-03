---
name: bambu-p2s-mcp-executor
description: Use Bambu P2S MCP safely for status, AMS information, file workflow, preflight, upload, and print control while requiring explicit approval for physical printer actions.
version: 1.0.0
---

# Bambu P2S MCP Executor

Use this skill after geometry is validated or when the user asks about printer state.

Target:
- Bambu Lab P2S
- printer reachable over local LAN
- credentials supplied privately through Docker environment

## 1. Discover tools

Do not assume Bambu MCP tool names.
Discover the connected MCP server's current tools and schemas.

## 2. Read-only inspection first

When relevant gather:
- printer model/state;
- active errors/HMS;
- nozzle temperature;
- bed temperature;
- AMS/external spool state;
- active job;
- material information.

For setup/debugging, keep actions read-only.

## 3. Credentials

Never:
- request the LAN access code if already configured;
- echo it;
- print it;
- commit it;
- place it in repo files.

The MCP process inherits credentials from the Docker `.env`.

## 4. Physical-action approval

Require explicit user intent before:
- starting a print;
- cancelling/stopping;
- pausing/resuming;
- heating;
- moving hardware;
- loading/unloading filament;
- other physical state changes.

The following do NOT imply permission to print:
- "make this printable"
- "prepare this"
- "slice this"
- "upload this"
- "send it to the printer"

Only perform the specific physical action the user explicitly requested.

## 5. Print preparation

Before an approved print:
- confirm correct P2S target;
- check blocking errors;
- confirm intended file/plate;
- check nozzle/profile compatibility when available;
- check material/AMS mapping;
- confirm printer is not in a conflicting state.

If slicing is not available in the container, stop at validated export/upload/preparation and let the user slice in Bambu Studio.

## 6. Command result verification

Distinguish:
- command submitted;
- printer acknowledged;
- printer actually changed state.

Do not report "printing" solely because a request returned success.

## 7. Status reporting

Return concise state:
- printer;
- job;
- temperatures;
- AMS/material;
- active errors;
- requested action result.

Never include secrets.
