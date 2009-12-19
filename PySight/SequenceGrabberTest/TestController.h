//
//  TestController.h
//  SequenceGrabberTest
//
//  Created by Tim Omernick on 3/18/05.
//  Copyright 2005 Tim Omernick. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "zpracovani.h"

@class CSGCamera;

@interface TestController : NSWindowController
{
	IBOutlet NSImageView *cameraView;
	IBOutlet NSImageView *editView;
	
	NSImage * editImage;
	NSBitmapImageRep * editRep;
	NSBitmapImageRep * origRep;
	NSSize size;
	unsigned char * origbuffer;
	//unsigned char * outputbuffer;
	unsigned char outputbuffer[307200];
	unsigned char * zpracBuf;
	unsigned char * outputbufptr;
	unsigned char ** outrepptr;
	
	zpracovani * pracImg;
	
	CSGCamera *camera;
}

@end
