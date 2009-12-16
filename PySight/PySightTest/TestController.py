'''
  PySight Example 
  
  Transliterated from Objective-C example in the CocoaSequenceGrabber SequenceGrabberTest TestController.m
  
  Originally Created by Tim Omernick on 3/18/05.
  Original Copyright 2005 Tim Omernick. All rights reserved.
  Python translation by Dethe Elza on 2005-05-09
  Python copyright 2005 Dethe Elza
  
'''
from Foundation import *
from AppKit import *
from PySight import *
from PyObjCTools import NibClassBuilder, AppHelper

NibClassBuilder.extractClasses("MainMenu")

class TestController(NibClassBuilder.AutoBaseClass):

    def awakeFromNib(self):
        # start recording
        self.camera = CSGCamera.alloc().init()
        self.camera.setDelegate_(self)
        self.camera.startWithSize_((160, 120))
        self.lastTime = 0
        
        # Make sure we don't distort the video as the user resizes the window
        window = self.window()
        window.setAspectRatio_(window.frame().size);
        
        # Show the window
        self.showWindow_(None);
        
    # outlet
    def setCameraView_(self, cameraView):
        self._cameraView = cameraView
    
    def cameraView(self):
        return self._cameraView
    
    # CSGCamera delegate
    
    def camera_didReceiveFrame_(self, aCamera, aFrame):
        self._cameraView.setImage_(aFrame)
        print 'FPS:', int(round(1.0 / (aFrame.sampleTime() - self.lastTime)))
        self.lastTime = aFrame.sampleTime()
        self._cameraView.display()
        
    
    # NSWindow delegate
    
    def windowWillClose_(self, notification):
        self.camera.stop()


AppHelper.runEventLoop()
