#!/usr/bin/env python
import subprocess as sp
from PIL import Image
import math

getter=sp.Popen("./launch_grabber.sh",stdin=sp.PIPE,stdout=sp.PIPE)

def gi(getter):
    getter.stdin.write("GI\n")
    a=getter.stdout.read(76800*4)
    getter.stdout.read(1)
    im=load_buffer(a,len(a))
#    im=Image.frombuffer("RGBA",[160,120],a)
    return im

def load_buffer(buffer,leng):
    im=Image.new("RGB",(320,240))
    pp=im.load();
    rozmer=320
    x=0
    y=0
    i=0
    for i in range(0,leng,4):
        pp[x,y]=(ord(buffer[i]),
                 ord(buffer[i+1]),
                 ord(buffer[i+2]))
        x+=1
        if x>=rozmer:
            x=0
            y+=1
    return im

def postproc(im,size):
    pp=im.load()
    im2=Image.new("RGB",(160,160))
    pp2=im2.load()
    x=0
    for i in range(size):
        for j in range(size):
            if ((j+1)%4)!=0:
                pp2[x,i]=pp[j,i]
                x+=1
        x=0
    return im2
