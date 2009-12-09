from __future__ import with_statement

import os, sys, signal, time
from PIL import Image, ImageTk
import Tkinter as tk

root = None
root_lab1 = None
root_lab2 = None
root_stat = None

proj = None
proj_lab = None

imgs = {}


def proj_open(x=1024, y=0, w=800, h=600):
  global proj, proj_lab
  if proj:
    return
  proj = tk.Toplevel()
  proj.config(bg='#000000')
  proj.overrideredirect(1)
  proj.geometry("%dx%d+%d+%d" % (w, h, x, y))
  proj_lab = tk.Label(proj, text='PROJEKTOR')
  proj_lab.place(x=0, y=0, width=w, height=h)
  proj_lab.config(bg='#000000')
  proj.update()

def labdraw(pil_img, label):
  if pil_img:
    i = ImageTk.PhotoImage(pil_img)
    label.config(image = i)
    imgs[hash(label)]=i
  else:
    label.config(text = '<None>')
  label.master.lift()
  label.master.update()

def root_open(w=320, h=240, x=360, y=24):
  global root, root_lab1, root_lab2, root_stat
  if root:
    return
  root = tk.Tk()
  root.geometry("%dx%d+%d+%d" % (2*w+15, h+35, x, y))
  root.lift()
  root.title('M&M zpracovani obrazu')
  root_lab1 = tk.Label(root, width=w, height=h, bg='blue', text='Kamera')
  root_lab1.place(x=5, y=5, width=w, height=h)
  root_lab2 = tk.Label(root, width=w, height = h, bg='gray', text='Obraz')
  root_lab2.place(x=w+10, y=5, width=w, height=h)
  root_stat = tk.Label(root, width=w, height = h, bg='#AAA', text='Status')
  root_stat.place(x=5, y=h+10, width=2*w+5, height=20)
  root.update()

def testWins():
  i1 = Image.open('/home/gavento/00000001.jpg')
  root_open()
  labdraw(i1, root_lab2)
  root.update()
  import time
  time.sleep(2)

