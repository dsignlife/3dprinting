# Bambu MCP configuration and security notes

A current Bambu-focused MCP commonly requires private local values equivalent to:
- printer host/IP;
- printer model (`p2s`);
- printer serial/device ID;
- LAN access token/code.

Keep these only in local/private environment configuration.

Do not:
- commit them to Git;
- paste them into planner prompts;
- echo the access code in status reports.

The Bambu MCP should handle protocol details. Prefer its dedicated checked tools over manually constructing MQTT/FTPS printer commands.

Slicer settings such as layer height, temperatures, support, and filament process parameters should come from real slicer profiles/projects. A printer-control MCP cannot safely "override" arbitrary baked settings in an already sliced file.
