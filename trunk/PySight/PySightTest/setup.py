'''
Minimal setup.py example, run with:
% python setup.py py2app
'''

from distutils.core import setup
import py2app

NAME = 'SequenceGrabberTest'
SCRIPT = 'TestController.py'
VERSION = '0.1'
ICON = ''
ID = 'sequence_grabber_test'
COPYRIGHT = 'Copyright 2005 Dethe Elza'
DATA_FILES = ['English.lproj']

plist = dict(
    CFBundleIconFile            = ICON,
    CFBundleName                = NAME,
    CFBundleShortVersionString  = ' '.join([NAME, VERSION]),
    CFBundleGetInfoString       = NAME,
    CFBundleExecutable          = NAME,
    CFBundleIdentifier          = 'org.livingcode.examples.%s' % ID,
    NSHumanReadableCopyright    = COPYRIGHT
)


app_data = dict(script=SCRIPT, plist=plist)
py2app_opt = dict(frameworks=['CocoaSequenceGrabber.framework'],)
options = dict(py2app=py2app_opt,)

setup(
  data_files = DATA_FILES,
  app = [app_data],
  options = options,
)
