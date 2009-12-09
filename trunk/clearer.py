#!/usr/bin/python

import os

sdir = 'kamera1/'
skeep = 100
ssleep = 1
while True:
  images = os.listdir(sdir)
  images.sort()
  while len(images)>skeep:
    #os.remove(sdir+'/'+images[0])
    images.pop(0)
  time.sleep(ssleep)
