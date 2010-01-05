#!/usr/bin/python
# -*- coding: utf-8 -*-
from kamera import *
import init
from transformace import *
#from objctools import *
#from kalibrace import *

from PIL import Image, ImageTk, ImageDraw
import IPython
import threading
from math import sqrt, tan, atan, sin, cos
import sys


def gi():
  init.root_stat.config(text='Cekam na obrazek')
  i = cam1.get_image()
  init.labdraw(i, init.root_lab1)
  init.root_stat.config(text='')
  return i

def g():
  while True:
    transAKresli(najdiBod())

def ctverecek(p, x, y, r):
  s = [0, 0, 0]
  for i in range(x-r, x+r):
    for j in range(y-r, y+r):
      c = p[(i,j)]
      for k in range(3):
        s[k] += c[k]
  return s

def najdiBod():
  i = gi()
  p = i.load()
  i2 = i.copy()
  p2 = i2.load()
  max = 0
  maxx = 0
  maxy = 0
  for x in range(4, i.size[0]-4):
    for y in range(4, i.size[1]-4):
      c = p[ (x,y) ]
      if c[1]>200 and c[0]<200:
        m = ctverecek(p,x,y,3)
        if m[1]/(m[0]+1.0)>1.3:
          if m[1]>max:
            maxx = x
            maxy = y
            max = m[1]
      else:
        p2[(x,y)] = (0,0,0)
  print max
  if max>2000:  
    d = ImageDraw.Draw(i2)
    krizek(maxx,maxy,255,0,0,d)
  init.labdraw(i2, init.root_lab2)
  return (maxx,maxy)
  
def transAKresli((maxx,maxy)):
  xprimo = maxx*1024/320
  yprimo = maxy*768/240
  (xgraf,ygraf) = graftrans(maxx,maxy)
  #(xpetr, ypetr) = petrans(maxx,maxy)  
  #(xkarel, ykarel) = karltrans(maxx,maxy)
  i3 = Image.new('RGB', (800, 600))
  d = ImageDraw.Draw(i3)
  krizek(xgraf,  ygraf,  200, 200, 000,d)
  krizek(xprimo, yprimo, 255, 000, 000,d)
  #krizek(xpetr,  ypetr,  255, 000, 255,d)
  #krizek(xkarel, ykarel, 000, 000, 255,d)
  init.labdraw(i3, init.proj_lab)
  return i

def krizek(x,y,r,g,b,d):
  d.line((x-15, y-15, x+15, y+15), fill=(r, g, b))
  d.line((x+15, y-15, x-15, y+15), fill=(r, g, b))


def kal(w=800, h=600):
  init.labdraw(kobr(-100, -100), init.proj_lab)
  time.sleep(0.6)
  i0 = gi()
  i = i0.copy()
  d = ImageDraw.Draw(i)
  r = 5
  for j in range(4):
    a=5
    s= [(a,a), (w-a, a), (w-a, h-a), (a, h-a)]
    x, y = s[j]
    init.labdraw(kobr(x, y), init.proj_lab)
    time.sleep(1.5)
    i1 = gi()
    init.labdraw(kobr(-100, -100), init.proj_lab)
    time.sleep(1.2)
    #i2 = Image.eval(i1, lambda x:255-x)
    #i3 = Image.blend(i0, i2, 0.5)
    i3 = rozdil(i1, i0)
    cx, cy = t2(i3)
    d.rectangle((cx-r/2, cy-r/2, cx+r/2, cy+r/2), fill=(255, 0, 255))
    kalibK[j] = (cx,cy)
    #kalibP[j] = (x,y)
    print "Proj (%d, %d) -> Camera (%d, %d)"%(x, y, cx, cy)
  init.labdraw(i, init.root_lab2)
  vypocti_kkonst(kalibK,kalibP)

  
def rozdil(i1,i2):
    p1 = i1.load()
    p2 = i2.load()
    i3 = i1.copy()
    p3 = i3.load()
    for x in range(i1.size[0]):
      for y in range(i1.size[1]):
        c1 = list(p1[(x,y)])
        c2 = p2[(x,y)]
        c1[0]-= c2[0]
        c1[1]-= c2[1]
        c1[2]-= c2[2]
        p3[(x,y)] = tuple(c1)
    return i3


def t2(i):
  p = i.load()
  max = 0
  maxx = 0
  maxy = 0
  for x in range(4, i.size[0]-4):
    for y in range(4, i.size[1]-4):
      c = p[ (x,y) ]
      if c[0]>60:
        m = ctverecek(p,x,y,3)
        if m[1]>max:
          maxx = x
          maxy = y
          max = m[1]
  print maxx, maxy
  return (maxx, maxy)
  
def objcGetCoor(char="g"):
  print char
  sys.stdout.flush()
  souradnice=raw_input()
  if not (',' in souradnice):
    if souradnice[0]=='c':
      print "k" 
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
  return (x,y)

def objCLoop():
  while True:
    x,y=objcGetCoor()
    transAKresli((x,y))
    
def objcKal(w=800,h=600):
  a=5
  r=5
  init.labdraw(kobr(-100, -100), init.proj_lab)
  time.sleep(1)
  objcGetCoor("c")
  objcGetCoor("c")
  s= [(a,a), (w-a, a), (w-a, h-a), (a, h-a)]
  i=Image.new("RGB",(800,600))
  d=ImageDraw.Draw(i)
  for j in range(4):
    x, y = s[j]
    init.labdraw(kobr(x, y), init.proj_lab)
    time.sleep(1.0)
    (cx,cy)=objcGetCoor("c")
    init.labdraw(kobr(-100, -100), init.proj_lab)
    time.sleep(1.0)
    d.rectangle((cx-r/2, cy-r/2, cx+r/2, cy+r/2), fill=(255, 0, 255))
    d.text((50,10*j),cx.__str__()+","+cy.__str__())
    kalibK[j] = (cx,cy)
    print "Proj (%d, %d) -> Camera (%d, %d)"%(x, y, cx, cy)
  init.labdraw(i, init.root_lab2)
  #vypocti_kkonst(kalibK,kalibP)
  
def kobr(x,y, r=10, w=800, h=600):
  i = Image.new('RGB', (w,h))
  d = ImageDraw.Draw(i)
  d.rectangle((x-r/2, y-r/2, x+r/2, y+r/2), fill=(255, 255, 255))
  return i

def otevriOkna():
  init.root_open()
  init.proj_open()

def camLoad():
  global cam1
  cam1 = Kamera(dir='kamera2/', cmd="", clear=False)
  cam1.start()
#cam1 = KameraThread(lab=init.root_lab1, dir='kamera1/', cmd="". clear=False)
#init.labdraw(i, init.proj_lab)

if (len(sys.argv)>1):
  #print sys.argv[1]
  otevriOkna()
  objcKal()
  objCLoop()

try:
  camLoad()
  otevriOkna()
  shell = IPython.Shell.IPythonShellEmbed(banner='M&M uzasny shell')
  vars = dict(locals())
  shell(local_ns = vars, global_ns={})
finally:
  if init.root:
    init.root.destroy()
  cam1.stop()
