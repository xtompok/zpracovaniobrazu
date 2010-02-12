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
	IBOutlet ZOImageView *imageView;
	IBOutlet NSImageView *imageView2;
	
	//Projector screen
	IBOutlet NSPanel *projPanel;
	IBOutlet ZOProjectorView *projView;
	
	IBOutlet NSTextField *ulLabel;
	IBOutlet NSTextField *urLabel;
	IBOutlet NSTextField *llLabel;
	IBOutlet NSTextField *lrLabel;
	IBOutlet NSTextField *maxSumSquareLabel;
	IBOutlet NSButton *calibrateButton;
	
	//Config outlets
	IBOutlet NSSlider *rMinSlider;
	IBOutlet NSSlider *gMinSlider;
	IBOutlet NSSlider *bMinSlider;
	
	/*IBOutlet NSSlider *rMinValueSlider;
	IBOutlet NSSlider *gMinValueSlider;
	IBOutlet NSSlider *bMinValueSlider;*/
	
	IBOutlet NSButton *minTogetherButton;
	//IBOutlet NSButton *minTogetherValueButton;
	
	IBOutlet NSButton *printToStdButton;
	
	IBOutlet NSTextField *rMinLabel;
	IBOutlet NSTextField *gMinLabel;
	IBOutlet NSTextField *bMinLabel;
	
	/*IBOutlet NSTextField *rMinValueLabel;
	IBOutlet NSTextField *gMinValueLabel;
	IBOutlet NSTextField *bMinValueLabel;*/
	
	NSArray *calLabelsArray;
	NSArray *calPointsArray;
	
	ZOPoint *ulCalPoint;
	ZOPoint *urCalPoint;
	ZOPoint *llCalPoint;
	ZOPoint *lrCalPoint;
	
	NSSize size;
	
	NSWindow * projWindow;
	
	NSTimer *calTimer;
	NSTimer *calBlankTimer;
	
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
-(NSData *)makeDataFromInt:(int)cislo;
-(NSPoint)getLightestPointFromImage:(NSImage *)anImage;

-(void)handleCalTimer:(NSTimer *)aTimer;
-(void)handleBlankTimer:(NSTimer *)aTimer;


//Configuration action
-(IBAction)sumSquareSliderMoved:(id)sender;



@end