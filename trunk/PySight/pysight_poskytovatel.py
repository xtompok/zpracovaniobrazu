#!/usr/bin/python
import pysight
import Quartz.CoreGraphics
import sys

cam=pysight.Camera()

j=0
while True:
    vstup=raw_input()
    if vstup!="GI": continue
    a=cam.get_ns_frame().representations()[0]
   # for i in range(3):
   #     cam.get_ns_frame()
    b=a.getBitmapDataPlanes_()[0]
    print b
    sys.stdout.flush()
    #print len(b)
cam.stop()