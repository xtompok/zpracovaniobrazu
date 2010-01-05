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
	NSFileHandle *pyOut;
	NSFileHandle *pyIn;
	NSTask *pyProg;
	int delka;
	unsigned char * origbuffer;
	unsigned char rmin;
	unsigned char rmax;
	unsigned char gmin;
	unsigned char gmax;
	unsigned char bmin;
	unsigned char bmax;
	int xout;
	int yout;
	unsigned char mode;
	
	CSGCamera *camera;
}

-(IBAction)Calibrate:(id)sender;
-(IBAction)RunAndPause:(id)sender;

-(void)getSumSquareAtX:(int)x andY:(int)y toArray:(int *)pole;
-(int)getPixelIndexAtX:(int)x andY:(int)y ;
-(void)getSumSquareAtIndex:(int)index toArray:(int *)pole;
-(NSSize)getPixelCoordinatesAtIndex:(int)index;
-(void)modeSetter:(NSNotification *)aNotification;
-(void)writeChar:(unsigned char)znak;
-(NSData *)makeDataFromInt:(int)cislo;


@property unsigned char rmin;
@property unsigned char rmax;
@property unsigned char gmin;
@property unsigned char gmax;
@property unsigned char bmin;
@property unsigned char bmax;
@property int xout;
@property int yout;
@property unsigned char mode;


@end