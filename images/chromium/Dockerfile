# This Dockerfile is used to create a Docker image that includes Chromium, Xvfb, x11vnc, websockify, and noVNC. 
# It is based on the Debian Bookworm slim image.
FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        chromium \
        xvfb \
        x11vnc \
        websockify \
        novnc \
        fonts-liberation \
        fonts-noto-color-emoji \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user to run the browser
# This is a security best practice to avoid running applications as the root user.
RUN useradd --create-home --shell /bin/bash browser \
    && mkdir -p /tmp/.X11-unix \
    && chmod 1777 /tmp/.X11-unix

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER browser
WORKDIR /home/browser

EXPOSE 6080
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# The entrypoint.sh script should start Xvfb, x11vnc, websockify.