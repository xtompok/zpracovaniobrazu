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
#import "ZOQuadTransform.h"

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
#import "ZOMultiColorDrawingController.h"
#import "ZOShootingController.h"
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
	IBOutlet ZOMultiColorDrawingController * multiColController;
	IBOutlet ZOShootingController * shootController;
	
	//Choosing classes
	IBOutlet NSPopUpButton * procChooseButton;
	IBOutlet NSPopUpButton * transformChooseButton;
	IBOutlet NSPopUpButton * viewChooseButton;

	
	/* Images and points */
	/* ----------------- */
	
	CSGCamera *camera;
	NSImage *lastImage;
	NSImage *viewImage;
	
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
	ZOQuadTransform *transQuadObject;
		
	IBOutlet ZOProcessImage *procImage;
	IBOutlet ZOProcess2Image *proc2Image;
	
	/* Arrays of choosable classes */
	/* --------------------------- */
	
	NSArray * procClassesArray;
	NSArray * transformClassesArray;
	NSArray * viewClassesArray;
}

-(IBAction)Calibrate:(id)sender;
-(IBAction)RunAndPause:(id)sender;

//Choosing classes
-(IBAction)viewChooseChanged:(id)sender;

-(IBAction)procSettingsClicked:(id)sender;
-(IBAction)transformSettingsClicked:(id)sender;
-(IBAction)viewSettingsClicked:(id)sender;


@end