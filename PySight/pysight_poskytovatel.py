#!/usr/bin/python
import pysight
import Quartz.CoreGraphics
import sys
import gc

cam=pysight.Camera()

def getframe(cam):
    return cam.get_ns_frame().representations()[0].getBitmapDataPlanes_()[0]

j=0
while True:
    vstup=raw_input()
    if vstup!="GI": continue
    print getframe(cam)
    sys.stdout.flush()
    gc.enable()
    gc.collect()
    #print len(b)
cam.stop()