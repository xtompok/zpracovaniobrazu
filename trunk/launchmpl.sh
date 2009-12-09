#!/bin/bash

#./clearer.py &
cd kamera1
rm 000*.jpg
mplayer tv:// -tv driver=v4l2:device=/dev/video$1:width=320:height=240:noaudio -vo jpeg 

