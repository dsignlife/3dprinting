# syntax=docker/dockerfile:1.7
FROM node:24-bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG BLENDER_MCP_ARCHIVE=mcp-for-blender-fix-screenshot-over-socket.zip
ARG BAMBU_MCP_PACKAGE=bambu-printer-mcp@latest

ENV HOME=/home/node \
    BLENDER_PORT=9876 \
    BLENDER_MCP_SAFE_MODE=1 \
    MCP_TRANSPORT=stdio \
    UV_PYTHON_INSTALL_DIR=/opt/uv/python \
    UV_TOOL_DIR=/opt/uv/tools \
    UV_TOOL_BIN_DIR=/usr/local/bin \
    PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        ffmpeg \
        file \
        git \
        git-lfs \
        jq \
        netcat-openbsd \
        procps \
        ripgrep \
        unzip \
        zip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# The patched mcp-for-blender source archive must be in the Docker build context
# beside this Dockerfile. Protocol 14 returns viewport PNG data over the socket,
# avoiding shared-filesystem assumptions between Docker and remote Blender.
COPY ${BLENDER_MCP_ARCHIVE} /tmp/blender-mcp-socketfix.zip

# Install the patched Blender MCP server from the local archive, then create the
# independent mesh-validation runtime.
RUN set -eux; \
    mkdir -p /opt/blender-mcp-src; \
    unzip -q /tmp/blender-mcp-socketfix.zip -d /opt/blender-mcp-src; \
    SRC_DIR="$(find /opt/blender-mcp-src -mindepth 1 -maxdepth 1 -type d | head -n 1)"; \
    test -n "${SRC_DIR}"; \
    test -f "${SRC_DIR}/pyproject.toml"; \
    test -f "${SRC_DIR}/addon.py"; \
    test -f "${SRC_DIR}/src/blender_mcp/server.py"; \
    grep -q 'ADDON_PROTOCOL_VERSION = 14' "${SRC_DIR}/addon.py"; \
    grep -q '"return_data": True' "${SRC_DIR}/src/blender_mcp/server.py"; \
    uv python install 3.12; \
    PY312="$(uv python find 3.12)"; \
    echo "Using managed Python: ${PY312}"; \
    uv tool install --python "${PY312}" "${SRC_DIR}"; \
    command -v mcp-for-blender; \
    cp "${SRC_DIR}/addon.py" /opt/blender-mcp-addon-protocol14.py; \
    TOOL_PY="/opt/uv/tools/mcp-for-blender/bin/python"; \
    test -x "${TOOL_PY}"; \
    "${TOOL_PY}" -c "import inspect, blender_mcp.server as s; src=inspect.getsource(s._capture_viewport); assert '\"return_data\": True' in src; print('Blender MCP socket screenshot fix installed')"; \
    uv venv --python "${PY312}" /opt/mesh-tools; \
    uv pip install --python /opt/mesh-tools/bin/python \
        numpy \
        trimesh \
        manifold3d \
        pillow; \
    printf '%s\n' \
        '#!/bin/sh' \
        'exec /opt/mesh-tools/bin/python "$@"' \
        > /usr/local/bin/mesh-python; \
    chmod 0755 /usr/local/bin/mesh-python; \
    /opt/mesh-tools/bin/python -c "import sys, numpy, trimesh, manifold3d, PIL; print(sys.executable); print('mesh runtime OK')"; \
    /usr/local/bin/mesh-python -c "import trimesh, manifold3d, numpy; print('mesh-python wrapper OK')"; \
    uv cache clean; \
    rm -rf /opt/blender-mcp-src /tmp/blender-mcp-socketfix.zip; \
    chmod -R a+rX /opt/uv /opt/mesh-tools /opt/blender-mcp-addon-protocol14.py

# Bambu Lab MCP.
RUN set -eux; \
    npm install --global --no-audit --no-fund "${BAMBU_MCP_PACKAGE}"; \
    command -v bambu-printer-mcp; \
    node --version; \
    npm cache clean --force

RUN mkdir -p /workspace \
    && chown -R node:node /workspace /home/node

WORKDIR /workspace
USER node

CMD ["sleep", "infinity"]
