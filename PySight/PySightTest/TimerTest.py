from time import time
from AppKit import *
from Foundation import *
from PyObjCTools import NibClassBuilder, AppHelper

class Echo(NSObject):
    def init(self):
        NSObject.init(self)
        self.previous = time()

    def ping_(self, notification):
        current = time()
        self.previous, elapsed = current, self.previous - current
        print 'elapsed:', elapsed
        
    
echo = Echo.alloc().init()
timer = NSTimer.scheduledTimerWithTimeInterval_target_selector_userInfo_repeats_(
        0.0,
        echo,
        'ping:',
        None,
        True
    )
    
print 'Interval:', timer.timeInterval()

