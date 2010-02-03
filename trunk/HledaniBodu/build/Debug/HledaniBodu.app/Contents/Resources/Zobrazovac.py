#!/usr/bin/python
# -*- coding: utf-8 -*-
import init
import sys
import time

from PIL import Image, ImageTk, ImageDraw

def kobr(x,y, r=20, w=800, h=600):
  i = Image.new('RGB', (w,h))
  d = ImageDraw.Draw(i)
  d.rectangle((x-r/2, y-r/2, x+r/2, y+r/2), fill=(255, 255, 255))
  return i

def krizek(x,y,r,g,b,d):
  d.line((x-150, y-150, x+150, y+150), fill=(r, g, b))
  d.line((x+150, y-150, x-150, y+150), fill=(r, g, b))
    
def objcKal(w=800,h=600):
  a=5
  r=5
  init.labdraw(kobr(-100, -100), init.proj_lab)
  time.sleep(1)
  s= [(a,a), (w-a, a), (w-a, h-a), (a, h-a),(0,0)]
  for j in range(5):
    x, y = s[j]
    init.labdraw(kobr(x, y), init.proj_lab)
    time.sleep(2.0)
    print "w"
    sys.stdout.flush()
    raw_input()
    init.labdraw(kobr(-100, -100), init.proj_lab)
    time.sleep(1.0)


if (len(sys.argv)>1):
  #init.root_open()
  init.proj_open()
  while True:
    print "g"
    sys.stdout.flush()
    souradnice=raw_input()
    if not (',' in souradnice):
      if souradnice[0]=='c':
        objcKal()
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