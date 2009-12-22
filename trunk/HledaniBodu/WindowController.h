//
//  WindowController.h
//  
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
	int delka;
	unsigned char * origbuffer;
	unsigned char rmin;
	unsigned char rmax;
	unsigned char gmin;
	unsigned char gmax;
	unsigned char bmin;
	unsigned char bmax;
	
	CSGCamera *camera;
}

-(void)getSumSquareAtX:(int)x andY:(int)y toArray:(int *)pole;
-(int)getPixelIndexAtX:(int)x andY:(int)y ;
-(void)getSumSquareAtIndex:(int)index toArray:(int *)pole;
-(NSSize)getPixelCoordinatesAtIndex:(int)index;

@property unsigned char rmin;
@property unsigned char rmax;
@property unsigned char gmin;
@property unsigned char gmax;
@property unsigned char bmin;
@property unsigned char bmax;


@end