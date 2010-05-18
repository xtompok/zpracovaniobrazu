//
//  WindowController.h
//  
//
//  Created by Tomáš Pokorný on 21.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ZOTransform.h"
#import "ZO2PointTransform.h"
#import "ZOPoint.h"
#import "ZOImageView.h"
#import "ZOProjectorView.h"
#import "ZOProjDrawingView.h"
#import "ZOCalibrationData.h"
#import "ZOProcessImage.h"
#import "ZOCalibrateView.h"
#import "ZOCalibrateController.h"
#import <CocoaSequenceGrabber/CocoaSequenceGrabber.h>


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
	
	IBOutlet NSSlider *rMaxSlider;
	IBOutlet NSSlider *gMaxSlider;
	IBOutlet NSSlider *bMaxSlider;
	
	IBOutlet NSSlider *rMinSumSlider;
	IBOutlet NSSlider *gMinSumSlider;
	IBOutlet NSSlider *bMinSumSlider;
	
	IBOutlet NSTextField *rMinLabel;
	IBOutlet NSTextField *gMinLabel;
	IBOutlet NSTextField *bMinLabel;
	
	IBOutlet NSTextField *rMaxLabel;
	IBOutlet NSTextField *gMaxLabel;
	IBOutlet NSTextField *bMaxLabel;
	
	IBOutlet NSTextField *rMinSumLabel;
	IBOutlet NSTextField *gMinSumLabel;
	IBOutlet NSTextField *bMinSumLabel;
	
	IBOutlet NSButton *minTogetherButton;
	IBOutlet NSButton *minTogetherSumButton;
	IBOutlet NSButton *maxTogetherButton;
	
		
	//Projector screen
	IBOutlet NSPanel *projPanel;
	IBOutlet ZOProjectorView *projView;
	IBOutlet NSPanel *drawPanel;
	IBOutlet ZOProjDrawingView *drawView;
	
	IBOutlet ZOCalibrateController * calController;
	NSWindow * projWindow;
	
	/* Images and points */
	/* ----------------- */
	
	CSGCamera *camera;
	NSImage *lastImage;
	
	/* Calibration stuff */
	/* ----------------- */
	
	NSArray *calLabelsArray;
	NSSize size;
	
	/* Modes */
	/* ----- */
	
	BOOL running;
	BOOL calInProgress;
	
	/* ZO classes */
	/* ---------- */
	
	ZOTransform *transformObject;
	ZO2PointTransform *transform2Object;
		
	ZOProcessImage *procImage;	
}

-(IBAction)Calibrate:(id)sender;
-(IBAction)RunAndPause:(id)sender;

-(IBAction)resetDrawing:(id)sender;


//Configuration action
-(void)initSliders;
-(IBAction)sumSquareSliderMoved:(id)sender;
-(IBAction)minSliderMoved:(id)sender;
-(IBAction)maxSliderMoved:(id)sender;
@end