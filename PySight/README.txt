PySight: PyObjC wrapper for SequenceGrabber framework

The CocoaSequenceGrabber is a Cocoa wrapper around the Sequence Grabber C API,
written by Tim Omernick.  Since this is exposed as a Framework, it is trivial
to import it into PyObjC for Python scripting, and indeed the PySight
implementation is trivial: a single __init__.py of eight lines.  It expects to
find the framework in /Library/Framworks (or the application bundle of a
py2app-created application), so build and install the CocoaSequenceGrabber
first there.

The CocoaSequenceGrabber project also contains an example project to
demonstrate how to use the library.  I've duplicated this project in Python in
PySightText, which can be built with "python setup.py py2app" on the
command-line.

All of this assumes that PyObjC is installed.  I've only tested it on OS X
Tiger (10.4) with Python 2.4, so your mileage may vary.

I'm interested in hearing any experiences and suggestions for improvement.

Dethe Elza
delza@livingcode.org

