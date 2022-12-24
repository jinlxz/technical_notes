Set up X server and GUI applications in linux quickly
---

# Xvfb
```shell
Xvfb :110 -ac +bs -dpi 110 -listen tcp -screen :110 1920x1280x24 // start a X server
x11vnc -listen 0.0.0.0   -display :110 //expose the X server as VNC server
mutter --replace --sync --x11   // start Window Manager.
```
# Xvnc
```shell
Vncserver -passwd // set VNC password
//start a X server and VNC server at the same time
vncserver :120 -geometry 1920x1280 -depth 24 -localhost no -alwaysshared
```
# start GUI application.
```shell
DISPLAY=':110' firefox &
DISPLAY=':110' google-chrome &
```
