# -*- coding: utf-8 -*-
from kamera import *
import init

from PIL import Image, ImageTk, ImageDraw
import IPython
import threading
from math import sqrt, tan, atan, sin, cos

kalibP = [(0,0)]*4
kalibK = [(0,0)]*4
kalibP[1]=(790, 590)
kalibP[2]=(790,590)

kkonst=[]
for i in range(5):
  kkonst.append([0,0])



def vypocti_kkonst(kalibK,kalibP):
  print kalibK
  print kalibP
  kkonst[1][0]=(kalibK[0][0]+kalibK[2][0]-kalibK[1][0]-kalibK[3][0])/(kalibP[1][0]*kalibP[2][1]*1.0)
  kkonst[1][1]=(kalibK[0][1]+kalibK[2][1]-kalibK[1][1]-kalibK[3][1])/(kalibP[1][0]*kalibP[2][1]*1.0)

  kkonst[2][0]=(-kalibK[0][0]+kalibK[3][0])/(kalibP[2][1]*1.0)
  kkonst[2][1]=(-kalibK[0][1]+kalibK[3][1])/(kalibP[2][1]*1.0)

  kkonst[3][0]=(kalibK[1][0]-kalibK[0][0])/(kalibP[1][0]*1.0)
  kkonst[3][1]=(kalibK[1][1]-kalibK[0][1])/(kalibP[1][0]*1.0)

  kkonst[4][0]=kalibK[0][0]
  kkonst[4][1]=kalibK[0][1]

def gi():
  init.root_stat.config(text='Cekam na obrazek')
  i = cam1.get_image()
  init.labdraw(i, init.root_lab1)
  init.root_stat.config(text='')
  return i

def g():
  while True:
    t1()

def ctverecek(p, x, y, r):
  s = [0, 0, 0]
  for i in range(x-r, x+r):
    for j in range(y-r, y+r):
      c = p[(i,j)]
      for k in range(3):
        s[k] += c[k]
  return s

def t1():
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
    d.line((maxx-15, maxy-15, maxx+15, maxy+15), fill=(255, 0, 0))
    d.line((maxx+15, maxy-15, maxx-15, maxy+15), fill=(255, 0, 0))
  init.labdraw(i2, init.root_lab2)

  i3 = Image.new('RGB', (800, 600))
  maxx2 = maxx
  maxy2 = maxy
  maxx3 = maxx
  maxy3 = maxy
  xgraf = maxx
  ygraf = maxy
  maxx = maxx*1024/320
  maxy = maxy*768/240
  (xgraf,ygraf) = graftrans(xgraf,ygraf)
  (maxx2, maxy2) = petrans(maxx2,maxy2)  
  (maxx3, maxy3) = karltrans(maxx3,maxy3)
  d = ImageDraw.Draw(i3)
  krizek(xgraf, ygraf,200, 200, 0,d)
  krizek(maxx, maxy, 255, 0, 0,d)
  krizek(maxx2, maxy2, 255, 0, 255,d)
  krizek(maxx3,maxy3, 0, 0, 255,d)
  init.labdraw(i3, init.proj_lab)
  return i

def krizek(x,y,r,g,b,d):
  d.line((x-15, y-15, x+15, y+15), fill=(r, g, b))
  d.line((x+15, y-15, x-15, y+15), fill=(r, g, b))

def kobr(x,y, r=10, w=800, h=600):
  i = Image.new('RGB', (w,h))
  d = ImageDraw.Draw(i)
  d.rectangle((x-r/2, y-r/2, x+r/2, y+r/2), fill=(255, 0, 0))
  init.labdraw(i, init.proj_lab)

def kal(w=800, h=600):
  kobr(-100, -100)
  time.sleep(0.6)
  i0 = gi()
  i = i0.copy()
  d = ImageDraw.Draw(i)
  r = 5
  for j in range(4):
    a=5
    s= [(a,a), (w-a, a), (w-a, h-a), (a, h-a)]
    x, y = s[j]
    kobr(x, y)
    time.sleep(1.5)
    i1 = gi()
    kobr(-100, -100)
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

def graftrans(maxx, maxy):
  i3a = Image.new('RGB', (320, 240))
  d = ImageDraw.Draw(i3a)
  d.point((maxx,maxy),fill=(0,255,0))
  dd = []
  for ii in [0, 3, 2, 1]:
    dd.append(kalibK[ii][0])
    dd.append(kalibK[ii][1])
  i3a = i3a.transform((390, 290), Image.QUAD, dd)
  p3=i3a.load()
  xgraf=ygraf=0
  for x in range (i3a.size[0]):
    for y in range (i3a.size[1]):
      c = p3[ (x,y) ]
      if c[1]>200:
        (xgraf, ygraf) = (x*2,y*2)
  return (xgraf+5, ygraf+5)

def pomery(kalibP,kalibK):
  lrozdil=kalibK[0][0]-kalibK[2][0]
  prozdil=kalibK[1][0]-kalibK[3][0]
  hrozdil=kalibK[0][1]-kalibK[1][1]
  drozdil=kalibK[2][1]-kalibK[3][1]

def petrans(x,y):
  x1=(x-kalibK[0][0]*1.0)/(kalibK[2][0]-kalibK[0][0])*kalibP[1][0]
  x2=(x-kalibK[3][0]*1.0)/(kalibK[1][0]-kalibK[3][0])*kalibP[1][0]
  
  y1=(y-kalibK[0][1]*1.0)/(kalibK[2][1]-kalibK[0][1])*kalibP[2][1]
  y2=(y-kalibK[1][1]*1.0)/(kalibK[3][1]-kalibK[1][1])*kalibP[2][1]
  
  transx=(x1+x2)/2
  transy=(y1+y2)/2

  return (transx,transy)

def kvadrat(a,b,c):
  diskr=b*b-4*a*c
  print diskr
  if diskr>=0 and a!=0:
    koren1=(-b+sqrt(diskr))/(2*a)
    koren2=(-b-sqrt(diskr))/(2*a)
  else:
    raise "Chybny diskriminant nebo deleni nulou"
  if 600>koren1>0:
    return koren1
  elif 600>koren1>0:
    return koren2
  else: raise "Mate tam bug"

#kalibP = [(0,0)]*4 01
#kalibK = [(0,0)]*4 23
def karltrans(x,y):
  if x<=0 or y<=0: return (-100, -100)
  c1x=kkonst[1][0]
  c1y=kkonst[1][1]
  c2x=kkonst[2][0]
  c2y=kkonst[2][1]
  c3x=kkonst[3][0]
  c3y=kkonst[3][1]
  c4x=kkonst[4][0]
  c4y=kkonst[4][1]

  d1=c1x*c2y+c2x*c1y
  d2=c1y*c4x-x*c1y+c2y*c3x-c2x*c3y+c4x*c1x-c1x*y
  d3=x*c3y+c3x*c4x-c3y*c4x-y*c3x

  print d1, d2, d3

  ytrans=kvadrat(d1,d2,d3)
  xtrans=(ytrans*c2x+c4x-x)/(-ytrans*c1x-c3x)
  print xtrans, ytrans
  return (xtrans,ytrans)

cam1 = Kamera(dir='kamera2/', cmd="", clear=False)
#cam1 = KameraThread(lab=init.root_lab1, dir='kamera1/', cmd="". clear=False)
#init.labdraw(i, init.proj_lab)

try:
  init.root_open()
  init.proj_open()
  cam1.start()
  shell = IPython.Shell.IPythonShellEmbed(banner='M&M uzasny shell')
  vars = dict(locals())
  shell(local_ns = vars, global_ns={})
finally:
  if init.root:
    init.root.destroy()
  cam1.stop()
