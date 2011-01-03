//
//  WindowController.h
//  
//
//  Created by Tomáš Pokorný on 21.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//
/*!
    @header WindowController
    @abstract   Main clas of application.
    @discussion This is the main class of application. This class connects all parts
				of the applications together. Methods of this class are all actions
				called from GUI.
*/


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

/*!
    @method     
    @abstract   Starts the calibration
    @discussion This methods tells calibration controller to start calibration.
*/

-(IBAction)Calibrate:(id)sender;
/*!
    @method     
    @abstract   Starts and pauses the game.
*/

-(IBAction)RunAndPause:(id)sender;

//Choosing classes
/*!
    @method     
    @abstract   Changes the fullscreen view.
    @discussion This method is called after the viewing class is changed from GUI.
				It tells all classes to left fullscreen ande then the choosed class
				to go fullscreen.
*/
-(IBAction)viewChooseChanged:(id)sender;

/*!
    @method     
    @abstract   Shows settings dialog of selected class.
*/

-(IBAction)procSettingsClicked:(id)sender;

/*!
 @method     
 @abstract   Shows settings dialog of selected class.
 */
-(IBAction)transformSettingsClicked:(id)sender;

/*!
 @method     
 @abstract   Shows settings dialog of selected class.
 */
-(IBAction)viewSettingsClicked:(id)sender;


@end