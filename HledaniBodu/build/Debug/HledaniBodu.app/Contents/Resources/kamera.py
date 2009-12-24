from __future__ import with_statement
from runcmd import runcmd3e 

import threading
import os, sys, signal, time
from PIL import Image, ImageTk
import init

class KameraThread(threading.Thread):
  def __init__(s, lab=None, **kw):
    threading.Thread.__init__(s)
    s.kam = Kamera(**kw)
    s.kam.start()
    s.lock = threading.Condition()
    s.img = None
    s.lab = lab
    s.stopflag = False
  def get_image(s):
    with s.lock:
      if not s.img:
	s.lock.wait()
      return s.img
  def run(s):
    while True:
      i = s.kam.get_image()
      with s.lock:
	s.lock.notify()
	s.img = i
	if s.stopflag:
	  return 
      if s.lab:
	init.labdraw(i, s.lab)
  def stop(s):
    with s.lock:
      s.stopflag = True
    s.join()

class Kamera(object):
  def __init__(s, dir='/tmp/kamera', cmd="true", keep=0, sleep=0.05, clear=True):
    s.dir = dir
    assert s.dir and s.dir!='.' and s.dir!='./'
    s.cmd = cmd
    s.pid = None
    s.running = False
    s.keep = keep
    s.sleep = sleep
    s.last = ""
    s.clear = clear
  def start(s, cmd=None):
    print "Kamera(%r).start()"%s.dir 
    if s.clear:
      runcmd3e("rm", ["rm", "-rf", s.dir])
      runcmd3e("mkdir", ["mkdir", "-p", s.dir])
    if cmd or s.cmd:
      s.pid = os.fork()
      if s.pid == 0:
	os.close(1)
	os.close(2)
	os.chdir(s.dir)
	os.execvp('/bin/bash', ['bash', '-c', (cmd or s.cmd)])
    s.running = True
  def stop(s):
    print "Kamera(%r).stop()"%s.dir 
    if not s.running: 
      return 
    if s.pid:
      os.kill(s.pid, signal.SIGKILL)
      os.waitpid(s.pid, 0)
      s.pid = None
    s.running = False
  def get_image(s):
    #if s.running and os.waitpid(s.pid, os.WNOHANG)>0:
    #  s.running = False
    #  print "Warning: camera process has exited"
    if not s.running:
      return None
    images = os.listdir(s.dir)
    print images
    images.sort()
    while len(images)<2 or images[-2] == s.last:
      time.sleep(s.sleep)
      images = os.listdir(s.dir)
      #print images
      images.sort()
    s.last = images[-2]
    print s.last
    i = Image.open(s.dir+'/'+s.last)
    i.load()
    if s.keep>0:
      while len(images)>s.keep:
	os.remove(s.dir+'/'+images[0])
	images.pop(0)
    return i
    

