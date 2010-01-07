 # -*- coding: utf-8 -*-
from PIL import Image, ImageTk, ImageDraw
from math import sqrt

kalibP = [(0,0)]*4
kalibK = [(0,0)]*4
kalibP[1]=(790, 590)
kalibP[2]=(790,590)

kkonst= [[0,0]]*5

def vypocti_kkonst(kalibK,kalibP):
  kkonst[1][0]=(kalibK[0][0]+kalibK[2][0]-kalibK[1][0]-kalibK[3][0])/(kalibP[1][0]*kalibP[2][1]*1.0)
  kkonst[1][1]=(kalibK[0][1]+kalibK[2][1]-kalibK[1][1]-kalibK[3][1])/(kalibP[1][0]*kalibP[2][1]*1.0)

  kkonst[2][0]=(-kalibK[0][0]+kalibK[3][0])/(kalibP[2][1]*1.0)
  kkonst[2][1]=(-kalibK[0][1]+kalibK[3][1])/(kalibP[2][1]*1.0)

  kkonst[3][0]=(kalibK[1][0]-kalibK[0][0])/(kalibP[1][0]*1.0)
  kkonst[3][1]=(kalibK[1][1]-kalibK[0][1])/(kalibP[1][0]*1.0)

  kkonst[4][0]=kalibK[0][0]
  kkonst[4][1]=kalibK[0][1]


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
    print "Z"
  if 600>koren1>0:
    return koren1
  elif 600>koren1>0:
    return koren2
  else: print "O"

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

  #print d1, d2, d3

  ytrans=kvadrat(d1,d2,d3)
  xtrans=(ytrans*c2x+c4x-x)/(-ytrans*c1x-c3x)
  #print xtrans, ytrans
  return (xtrans,ytrans)

