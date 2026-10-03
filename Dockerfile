# syntax=docker/dockerfile:1.7
FROM node:24-bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG BLENDER_MCP_PACKAGE=mcp-for-blender
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

# Blender MCP + isolated mesh-validation Python runtime.
#
# Important:
# - uv owns the managed Python installation under /opt/uv/python.
# - /opt/mesh-tools is a separate venv.
# - /usr/local/bin/mesh-python is a wrapper FILE, never a symlink.
# - /opt/mesh-tools/bin is intentionally not prepended to PATH.
RUN set -eux; \
    uv python install 3.12; \
    PY312="$(uv python find 3.12)"; \
    echo "Using managed Python: ${PY312}"; \
    uv tool install --python "${PY312}" "${BLENDER_MCP_PACKAGE}"; \
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
    command -v mcp-for-blender; \
    uv cache clean; \
    chmod -R a+rX /opt/uv /opt/mesh-tools

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
