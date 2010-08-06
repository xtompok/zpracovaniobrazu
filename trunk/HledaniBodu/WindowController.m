//
//  WindowController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 21.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//

/*
 TO DO:
 ------
 - ukládání prvotního nastavení sliderů na disk
 - vykuchat perspektivní transformaci
 - licence PIL
 */


#define STDOUTPRINT if([printToStdButton state]==NSOnState)

#import "WindowController.h"

@implementation WindowController

// Init and dealloc

- (void)dealloc;
{
	[camera release];
	
	[super dealloc];
}

- (void)awakeFromNib;
{
	/* Initialization of camera */
	/* ------------------------ */
	
	// Set resolution of camera
	size=NSMakeSize(320, 240);
	
	// Start recording
	camera = [[CSGCamera alloc] init];
	[camera setDelegate:self];
	[camera startWithSize:size];
	
	/* Initialization windows and views */
	/* -------------------------------- */
	
	// Set window
	NSWindow *window = [self window];
	[window setAspectRatio:[window frame].size];
		
	// Init labels of calibration points
	calLabelsArray = [[NSArray alloc] initWithObjects:
					  (NSTextField *) ulLabel,
					  (NSTextField *) urLabel,
					  (NSTextField *) lrLabel,
					  (NSTextField *) llLabel,nil];
	
	// Initialization of projector view
	
	
	STDOUTPRINT NSLog(@"screens: %i",[[NSScreen screens]count]);
	
	// Go fullscreen
	[drawController goFullscreen];
	//[projController goFullscreen];
	
	/*Initialization own classes*/
	/*--------------------------*/
	
	// Init image processing object
	[procImage initWithSize:size];
	[proc2Image  initWithSize:size];
	
	// Init calibration object
	[calController setSize:size];
	
	
	// Init transformation object
	transform2Object = [[ZO2PointTransform alloc] initWithCalibrationArray:[calController calibrationArray]];
	
	// Init notification of completed calibration
	[[NSNotificationCenter defaultCenter]  addObserver:self
											  selector:@selector(calibrationCompleted:)
												  name:@"Calibration OK"
												object:nil];
	
	// Set running or paused
	running=YES;
	
	// Show the window
	[self showWindow:nil];
}


/* Camera delegate */
// Called when new image received from camera, does all about the image.
- (void)camera:(CSGCamera *)aCamera didReceiveFrame:(CSGImage *)aFrame;
{
	lastImage=aFrame;
	
	if (!running) return;
		
	NSPoint transPoint, outPoint;
		
	outPoint = [proc2Image getThePointFromImage:lastImage];
	
	[imageView setAnImage:lastImage];
	[imageView setPoint:outPoint];
	[imageView setNeedsDisplay:YES];
	
	if (calInProgress) {
		[calController setPoint:outPoint];
		return;
	}
	
	transPoint = [transform2Object transformPoint:outPoint];
	

	[drawController setPoint1:transPoint];
	[projController setPoint1:transPoint];
			
	STDOUTPRINT printf("x=%f, y=%f\n",outPoint.x,outPoint.y);
	
	//transPoint=[transformObject transformPoint:outPoint];

	STDOUTPRINT printf("xt=%f, yt=%f",transPoint.x,transPoint.y);
}

// Cleanup before end
- (void)windowWillClose:(NSNotification *)notification;
{
	[camera stop];
}

// Notification receiver from ZOCalibrate, called when calibration is finished
-(void)calibrationCompleted:(NSNotification *)aNotification
{
	int i;
	NSArray * calArray;
	ZOCalibrationData * calData;
	
	calData = [aNotification object];
	calArray = [[NSArray alloc] initWithArray:[calData calPointsArray]];
	
	[imageView setCalPoints:[calData calPointsArray]];
	transform2Object = [[ZO2PointTransform alloc] initWithCalibrationArray:calArray];
	transformObject = [[ZOTransform alloc] initWithCalibrationArray:calArray];
	[calibrateButton setEnabled:YES];
	calInProgress=NO;
	for (i=0;i<4;i++)
	{
		[[calLabelsArray objectAtIndex:i] setStringValue:
		 [NSString stringWithFormat:@"%.3d,%.3d",
		  (int)([[calArray objectAtIndex:i] x]*size.width),
		  (int)([[calArray objectAtIndex:i] y]*size.height)]];
	}
}

/* GUI Interactivity */
/* ----------------- */

// Calibrates after click
-(IBAction)Calibrate:(id)sender
{	
	calInProgress=YES;
	[calibrateButton setEnabled:NO];
	[calController calibrate];
	
	NSLog(@"Calibrate!");	
}


// Pause and resume running program
-(IBAction)RunAndPause:(id)sender
{
	if ([sender title]==@"Run") {
		running=YES;
		[sender setTitle:@"Pause"];
		NSLog(@"Running!");
	} else {
		running=NO;
		[sender setTitle:@"Run"];
		NSLog(@"Paused!");
	}
}

@end

