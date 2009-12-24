from PIL import Image,ImageDraw
from kalibrace import kobr
import time
import sys

def objcGetCoor(char="g"):
  print char
  sys.stdout.flush()
  souradnice=raw_input()
  sep=","
  (x,sep,y)=souradnice.partition(",")
  x=int(x)
  y=int(y)
  return (x,y)

def objCLoop():
  while True:
    x,y=objcGetCoor()
    transAKresli((x,y))
    
def objcKal(init,w=800,h=600):
  a=5
  r=5
  s= [(a,a), (w-a, a), (w-a, h-a), (a, h-a)]
  i=Image.new("RGB",(800,600))
  d=ImageDraw.Draw(i)
  for j in range(4):
    x, y = s[j]
    init.labdraw(kobr(x, y), init.proj_lab)
    time.sleep(1.5)
    (cx,cy)=objcGetCoor("c")
    init.labdraw(kobr(-100, -100), init.proj_lab)
    time.sleep(1.0)
    d.rectangle((cx-r/2, cy-r/2, cx+r/2, cy+r/2), fill=(255, 0, 255))
    kalibK[j] = (cx,cy)
    print "Proj (%d, %d) -> Camera (%d, %d)"%(x, y, cx, cy)
  init.labdraw(i, init.root_lab2)
  vypocti_kkonst(kalibK,kalibP)

