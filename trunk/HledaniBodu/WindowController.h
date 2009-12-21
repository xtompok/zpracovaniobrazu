//
//  WindowController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 21.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>



@class CSGCamera;

@interface WindowController : NSWindowController
{
	IBOutlet NSImageView *cameraView;
	//IBOutlet NSImageView *editView;
	
	NSImage * editImage;
	NSBitmapImageRep * origRep;
	NSSize size;
	unsigned char * origbuffer;
	
	CSGCamera *camera;
}
@end