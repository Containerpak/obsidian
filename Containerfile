FROM ubuntu:26.04 AS source

ARG APP_SHA256=e0d8e0a611624de8c9c7dcd8a9e648279fb0a0d552faa1312b7e4f3a5fa72663

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl squashfs-tools && \
    curl --fail --location --output /tmp/Obsidian-1.13.7.AppImage "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.13.7/Obsidian-1.13.7.AppImage" && \
    echo "${APP_SHA256}  /tmp/Obsidian-1.13.7.AppImage" | sha256sum --check && \
    chmod 0755 /tmp/Obsidian-1.13.7.AppImage && \
    cd /tmp && \
    ./Obsidian-1.13.7.AppImage --appimage-extract >/dev/null && \
    mv /tmp/squashfs-root /out

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/obsidian"

COPY --from=source /out /opt/obsidian
COPY obsidian /usr/bin/obsidian
COPY md.obsidian.Obsidian.desktop /usr/share/applications/md.obsidian.Obsidian.desktop

RUN chmod 0755 /usr/bin/obsidian && \
    if [ -e /opt/obsidian/.DirIcon ]; then install -Dm644 /opt/obsidian/.DirIcon /usr/share/icons/hicolor/256x256/apps/md.obsidian.Obsidian.png; fi && \
    cpak-clean-junk
