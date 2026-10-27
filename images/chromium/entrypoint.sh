#!/bin/bash
set -e

# Start Xvfb in the background on display :1 and doesn't allow TCP connections from other hosts
export DISPLAY=:1
Xvfb :1 -screen 0 1280x720x24 -nolisten tcp &

while [ ! -e /tmp/.X11-unix/X1 ]; do
    sleep 0.1
done 

# Start x11vnc in the background on display :1, only allowing connections from localhost, on port 5900, running forever, allowing shared connections, without a password, and in quiet mode
x11vnc -display :1 -localhost -rfbport 5900 -forever -shared -nopw -quiet &

# Start websockify in the background, serving the noVNC web client from /usr/share/novnc/ on port 6080, and forwarding connections to localhost:5900
websockify --web /usr/share/novnc/ 6080 localhost:5900 &

# Start chromium in the foreground with no welcome screen, window position at 0,0, window size of 1280x720, and opening a blank page
exec chromium \
    --no-first-run \
    --no-default-browser-check \
    --window-position=0,0 \
    --window-size=1280,720 \
    about:blank