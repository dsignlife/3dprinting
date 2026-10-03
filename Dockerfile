# syntax=docker/dockerfile:1.7
FROM node:24-bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG BLENDER_MCP_PACKAGE=mcp-for-blender
ARG BAMBU_MCP_PACKAGE=bambu-printer-mcp@latest

# IMPORTANT:
# The SSH tunnel runs manually on Computer 1 (Windows), NOT in Docker.
# mcp-for-blender reaches the Windows-side tunnel through host.docker.internal.
ENV HOME=/home/node \
    BLENDER_HOST=host.docker.internal \
    BLENDER_PORT=9876 \
    BLENDER_MCP_SAFE_MODE=1 \
    MCP_TRANSPORT=stdio \
    UV_PYTHON_INSTALL_DIR=/opt/uv/python \
    UV_TOOL_DIR=/opt/uv/tools \
    UV_TOOL_BIN_DIR=/usr/local/bin \
    PATH=/opt/mesh-tools/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin

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

RUN uv python install 3.12 \
    && uv tool install --python 3.12 "${BLENDER_MCP_PACKAGE}" \
    && uv venv --python 3.12 /opt/mesh-tools \
    && uv pip install --python /opt/mesh-tools/bin/python \
        numpy \
        trimesh \
        manifold3d \
        pillow \
    && ln -s /opt/mesh-tools/bin/python /usr/local/bin/mesh-python \
    && uv cache clean \
    && chmod -R a+rX /opt/uv /opt/mesh-tools

RUN npm install --global --no-audit --no-fund "${BAMBU_MCP_PACKAGE}" \
    && npm cache clean --force

RUN mkdir -p /workspace \
    && chown -R node:node /workspace /home/node

WORKDIR /workspace
USER node

CMD ["sleep", "infinity"]
