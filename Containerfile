FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/obsidian"

COPY obsidian /usr/bin/obsidian
COPY md.obsidian.Obsidian.desktop /usr/share/applications/md.obsidian.Obsidian.desktop

RUN chmod 0755 /usr/bin/obsidian && \
    mkdir -p /usr/share/icons/hicolor/256x256/apps && \
    ln -sf /usr/share/icons/hicolor/512x512/apps/obsidian.png /usr/share/icons/hicolor/256x256/apps/md.obsidian.Obsidian.png && \
    cpak-clean-junk
