#!/usr/bin/python
# -*- coding: utf-8 -*-
import init
from transformace import *
import time
import sys

kalibP = [(0,0)]*4
kalibK = [(0,0)]*4
kalibP[0]=(5, 5)
kalibP[1]=(790, 5)
kalibP[2]=(790,590)
kalibP[3]=(5, 590)

from PIL import Image, ImageTk, ImageDraw
  
def transAKresli((maxx,maxy)):
  #xprimo = maxx*1024/320
  #yprimo = maxy*768/240
  #(xgraf,ygraf) = graftrans(maxx,maxy,kalibK)
  #(xpetr, ypetr) = petrans(maxx,maxy, kalibP, kalibK)  
  (xkarel, ykarel) = karltrans(maxx,maxy)
  i3 = Image.new('RGB', (800, 600))
  d = ImageDraw.Draw(i3)
  #krizek(xgraf,  ygraf,  200, 200, 000,d)
  #krizek(xprimo, yprimo, 255, 000, 000,d)
  #krizek(xpetr,  ypetr,  255, 000, 255,d)
  krizek(xkarel, ykarel, 255, 0, 255,d)
  init.labdraw(i3, init.proj_lab)

def krizek(x,y,r,g,b,d):
  d.line((x-15, y-15, x+15, y+15), fill=(r, g, b))
  d.line((x+15, y-15, x-15, y+15), fill=(r, g, b))
  
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
    kalibK[j] = (cx,cy)
    print "Proj (%d, %d) -> Camera (%d, %d)"%(x, y, cx, cy)
  init.labdraw(i, init.root_lab2)
  statusLine="1: "+kalibK[0].__str__()+" 2:"+kalibK[1].__str__()+" 3:"+kalibK[2].__str__()+" 4:"+kalibK[3].__str__()
  init.root_stat.config(text=statusLine)
  vypocti_kkonst(kalibK,kalibP)
  
def kobr(x,y, r=10, w=800, h=600):
  i = Image.new('RGB', (w,h))
  d = ImageDraw.Draw(i)
  d.rectangle((x-r/2, y-r/2, x+r/2, y+r/2), fill=(255, 255, 255))
  return i

def otevriOkna():
  init.root_open()
  init.proj_open()

if (len(sys.argv)>1):
  otevriOkna()
  objcKal()
  objCLoop()
