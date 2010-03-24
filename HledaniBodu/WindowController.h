//
//  WindowController.h
//  
//
//  Created by Tomáš Pokorný on 21.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef struct {
	int r;
	int g;
	int b;
} BARVA;

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
	
	IBOutlet NSSlider *rMinSumSlider;
	IBOutlet NSSlider *gMinSumSlider;
	IBOutlet NSSlider *bMinSumSlider;
	
	IBOutlet NSButton *minTogetherButton;
	IBOutlet NSButton *minTogetherSumButton;
	
	IBOutlet NSButton *printToStdButton;
	
	IBOutlet NSTextField *rMinLabel;
	IBOutlet NSTextField *gMinLabel;
	IBOutlet NSTextField *bMinLabel;
	
	IBOutlet NSTextField *rMinSumLabel;
	IBOutlet NSTextField *gMinSumLabel;
	IBOutlet NSTextField *bMinSumLabel;
	
	NSArray *calLabelsArray;
	
	NSSize size;
	
	NSWindow * projWindow;
	
	NSImage *lastImage;
	
	int delka;
	unsigned char * origbuffer;
	
	BARVA minColorValue;
	BARVA maxColorValue;

	NSPoint outPoint;
	unsigned char mode;
	BOOL running;
	
	BOOL calInProgress;
	
	ZOTransform *transformObject;
	ZO2PointTransform *transform2Object;
	
	ZOProcessImage *procImage;
	ZOCalibrate *calObject;
	
	CSGCamera *camera;
}

-(IBAction)Calibrate:(id)sender;
-(IBAction)RunAndPause:(id)sender;


//Configuration action
-(IBAction)sumSquareSliderMoved:(id)sender;
-(IBAction)minSliderMoved:(id)sender;


@end