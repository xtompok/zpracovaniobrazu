#!/usr/bin/python
import pysight
import Quartz.CoreGraphics
import sys
import gc

cam=pysight.Camera()

j=0
while True:
    vstup=raw_input()
    if vstup!="GI": continue
    frame=cam.get_ns_frame()
    reps=frame.representations()[0]
    plane=reps.getBitmapDataPlanes_()[0]
    print plane
    sys.stdout.flush()
    #frame.release()
    reps.release()
    #plane.release()
    #print len(b)
cam.stop()