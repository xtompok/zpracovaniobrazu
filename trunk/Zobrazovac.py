#!/usr/bin/python
# -*- coding: utf-8 -*-
import init
import sys

from PIL import Image, ImageTk, ImageDraw

def krizek(x,y,r,g,b,d):
  d.line((x-15, y-15, x+15, y+15), fill=(r, g, b))
  d.line((x+15, y-15, x-15, y+15), fill=(r, g, b)) 

if (len(sys.argv)>1):
  init.root_open()
  init.proj_open()
  while True:
    print "g"
    sys.stdout.flush()
    souradnice=raw_input()
    sep=","
    (x,sep,y)=souradnice.partition(",")
    if x.isdigit():
      x=int(x)
    else:
      x=0
    if y.isdigit():
      y=int(y)
    else:
      y=0
    i = Image.new('RGB', (800, 600))
    d = ImageDraw.Draw(i)
    krizek(x, y, 255, 0, 255,d)
    init.labdraw(i, init.proj_lab) 