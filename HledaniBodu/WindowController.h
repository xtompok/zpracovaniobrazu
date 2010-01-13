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
	
	IBOutlet NSTextField *ulLabel;
	IBOutlet NSTextField *urLabel;
	IBOutlet NSTextField *llLabel;
	IBOutlet NSTextField *lrLabel;
	IBOutlet NSTextField *maxSumSquareLabel;
	
	//Config outlets
	IBOutlet NSSlider *rMinSlider;
	IBOutlet NSSlider *gMinSlider;
	IBOutlet NSSlider *bMinSlider;
	IBOutlet NSButton *minTogetherButton;
	IBOutlet NSButton *printToStdButton;
	
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
	int kalibCamArray[5][2];
	int kalibCamArrayindex;
	NSPoint outPoint;
	//int xout;
	//int yout;
	unsigned char mode;
	BOOL running;
	
	CSGCamera *camera;
}

-(IBAction)Calibrate:(id)sender;
-(IBAction)RunAndPause:(id)sender;

-(void)getSumSquareAtX:(int)x andY:(int)y toArray:(int *)pole;
-(int)getPixelIndexAtX:(int)x andY:(int)y ;
-(void)getSumSquareAtIndex:(int)index toArray:(int *)pole;
-(NSPoint)getPixelCoordinatesAtIndex:(int)index;
-(void)modeSetter:(NSNotification *)aNotification;
-(void)writeChar:(unsigned char)znak;
-(NSData *)makeDataFromInt:(int)cislo;
-(void)drawSquareAtX:(int)x andY:(int)Y withRadius:(int)r;


@property unsigned char rmin;
@property unsigned char rmax;
@property unsigned char gmin;
@property unsigned char gmax;
@property unsigned char bmin;
@property unsigned char bmax;
@property NSPoint outPoint;
@property unsigned char mode;


@end