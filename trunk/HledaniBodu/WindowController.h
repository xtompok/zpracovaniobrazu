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
#import "ZOProcess2Image.h"
#import "ZOCalibrateView.h"
#import "ZOCalibrateController.h"
#import "ZODrawingController.h"
#import "ZOProjectorController.h"
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
	
	IBOutlet NSButton *calibrateButton;
	IBOutlet NSButton *printToStdButton;
		
	//Projector screen

	IBOutlet ZOCalibrateController * calController;
	IBOutlet ZODrawingController * drawController;
	IBOutlet ZOProjectorController * projController;
	
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
		
	IBOutlet ZOProcessImage *procImage;
	IBOutlet ZOProcess2Image *proc2Image;
}

-(IBAction)Calibrate:(id)sender;
-(IBAction)RunAndPause:(id)sender;

@end