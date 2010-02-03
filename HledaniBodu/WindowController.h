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
	IBOutlet NSTextField *rMinLabel;
	IBOutlet NSTextField *gMinLabel;
	IBOutlet NSTextField *bMinLabel;
	IBOutlet ZOImageView *imageView;
	
	NSSize size;
	
	NSFileHandle *pyOut;
	NSFileHandle *pyIn;
	NSTask *pyProg;
	
	NSImage *lastImage;
	
	NSArray *calArray;
	int delka;
	unsigned char * origbuffer;
	unsigned char rmin;
	unsigned char rmax;
	unsigned char gmin;
	unsigned char gmax;
	unsigned char bmin;
	unsigned char bmax;
	int kalibCamArray[6][2];
	int kalibCamArrayindex;
	NSPoint outPoint;
	//int xout;
	//int yout;
	unsigned char mode;
	BOOL running;
	
	ZOTransform *transformObject;
	ZO2PointTransform *transform2Object;
	
	
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
-(NSPoint)getLightestPointFromImage:(NSImage *)anImage;


//Configuration action
-(IBAction)sumSquareSliderMoved:(id)sender;



@end