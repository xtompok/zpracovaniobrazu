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
	/* Outlets */
	/* ------- */
	
	// Main window
	IBOutlet ZOImageView *imageView;
	
	// Calibration points labels
	IBOutlet NSTextField *ulLabel;
	IBOutlet NSTextField *urLabel;
	IBOutlet NSTextField *llLabel;
	IBOutlet NSTextField *lrLabel;
	
	IBOutlet NSTextField *maxSumSquareLabel;
	IBOutlet NSButton *calibrateButton;
	IBOutlet NSButton *printToStdButton;
	
	//Config outlets
	IBOutlet NSSlider *rMinSlider;
	IBOutlet NSSlider *gMinSlider;
	IBOutlet NSSlider *bMinSlider;
	
	IBOutlet NSSlider *rMinSumSlider;
	IBOutlet NSSlider *gMinSumSlider;
	IBOutlet NSSlider *bMinSumSlider;
	
	IBOutlet NSTextField *rMinLabel;
	IBOutlet NSTextField *gMinLabel;
	IBOutlet NSTextField *bMinLabel;
	
	IBOutlet NSTextField *rMinSumLabel;
	IBOutlet NSTextField *gMinSumLabel;
	IBOutlet NSTextField *bMinSumLabel;
	
	IBOutlet NSButton *minTogetherButton;
	IBOutlet NSButton *minTogetherSumButton;
	
		
	//Projector screen
	IBOutlet NSPanel *projPanel;
	IBOutlet ZOProjectorView *projView;
	IBOutlet NSPanel *drawPanel;
	IBOutlet ZOProjDrawingView *drawView;
	NSWindow * projWindow;
	
	/* Images and points */
	/* ----------------- */
	
	CSGCamera *camera;
	NSImage *lastImage;
	NSPoint outPoint;
	
	/* Calibration stuff */
	/* ----------------- */
	
	NSArray *calLabelsArray;
	NSSize size;
	
	/* Modes */
	/* ----- */
	
	unsigned char mode;
	BOOL running;
	BOOL calInProgress;
	
	/* ZO classes */
	/* ---------- */
	
	ZOTransform *transformObject;
	ZO2PointTransform *transform2Object;
	
	ZOCalibrate *calObject;
	
	ZOProcessImage *procImage;
}

-(IBAction)Calibrate:(id)sender;
-(IBAction)RunAndPause:(id)sender;


//Configuration action
-(IBAction)sumSquareSliderMoved:(id)sender;
-(IBAction)minSliderMoved:(id)sender;


@end