# P2S MCP security notes

Private environment values typically include:
- PRINTER_HOST
- BAMBU_MODEL=p2s
- BAMBU_SERIAL
- BAMBU_TOKEN
- NOZZLE_DIAMETER

Keep them in `.env` only.

Codex should call:

`docker exec -i 3d-mcp-tools bambu-printer-mcp`

The child process inherits the container environment.

Never expose printer credentials in `.codex/config.toml`.
