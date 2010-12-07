//
//  WindowController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 21.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//


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
	size=NSMakeSize(640, 480);
	
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
	
	
	/*Initialization own classes*/
	/*--------------------------*/
	
	// Init image processing objects
	[procImage initWithSize:size];
	[proc2Image  initWithSize:size];
	
	// Init calibration object
	[calController setSize:size];
	
	// Init transformation object
	transform2Object = [[ZO2PointTransform alloc] initWithCalibrationArray:[calController calibrationArray]];
	transformObject = [[ZOTransform alloc] initWithCalibrationArray:[calController calibrationArray]];
	transQuadObject = [[ZOQuadTransform alloc] initWithCalibrationArray:[calController calibrationArray]];
	
	//
	[imageView setCalPoints:[calController calibrationArray]];
	
	// Init notification of completed calibration
	[[NSNotificationCenter defaultCenter]  addObserver:self
											  selector:@selector(calibrationCompleted:)
												  name:@"Calibration OK"
												object:nil];
	
	/* Creating arrays of choosable classes */
	/* ------------------------------------ */
	
	procClassesArray = [[NSArray alloc] initWithObjects:
						(ZOProcessImage * ) procImage,
						(ZOProcess2Image *) proc2Image,nil];
	transformClassesArray = [[NSArray alloc] initWithObjects:
							 (ZOTransform *) transformObject,
							 (ZO2PointTransform *) transform2Object,
							 (ZOQuadTransform *) transQuadObject,
							 nil];
	viewClassesArray = [[NSArray alloc] initWithObjects:
						(ZOProjectorController *) projController,
						(ZODrawingController *) drawController, 
						(ZOMultiColorDrawingController *) multiColController,
						(ZOShootingController *) shootController,
						nil];
	// Go fullscreen
	[[viewClassesArray objectAtIndex:
	  [viewChooseButton indexOfSelectedItem]] goFullscreen];
	
	
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
		
	outPoint = [[procClassesArray objectAtIndex:
				 [procChooseButton indexOfSelectedItem]] 
				getThePointFromImage:lastImage]; 
	
	// View picture from camera and found point in WindowController
	if (size.width!=320) {
		[viewImage release];
		viewImage = [[NSImage alloc] initWithSize: NSMakeSize(320, 240)];
		[viewImage lockFocus];
		[lastImage drawInRect: NSMakeRect(0, 0, 320, 240) 
					 fromRect: NSMakeRect(0, 0, [lastImage size].width, [lastImage size].height)
					operation: NSCompositeSourceOver
					 fraction: 1.0];
		[viewImage unlockFocus];
		[imageView setImage:viewImage];
	} else {
		[imageView setImage:lastImage];
	}

	[imageView setPoint:outPoint];
	[imageView setNeedsDisplay:YES];
	
	if (calInProgress) {
		[calController setPoint:outPoint];
		return;
	}
	
	transPoint = [[transformClassesArray objectAtIndex:
				   [transformChooseButton indexOfSelectedItem]]
				  transformPoint:outPoint];

	int i;
	/*for (i=0;i<[viewClassesArray count];i++)
	{
		[[viewClassesArray objectAtIndex:i] setPoint1:transPoint];
	}*/ // Good for drawing but bad for shooting...
	[[viewClassesArray objectAtIndex:[viewChooseButton indexOfSelectedItem]] setPoint1:transPoint];
	
	STDOUTPRINT printf("x=%f, y=%f\n",outPoint.x,outPoint.y);	
	STDOUTPRINT printf("xt=%f, yt=%f",transPoint.x,transPoint.y);
}

// Cleanup before end
- (void)windowWillClose:(NSNotification *)notification;
{
	[camera stop];
	int i;
	for (i=0;i<[viewClassesArray count];i++)
	{
		[[viewClassesArray objectAtIndex:i] leftFullscreen];
	}
}

// Notification receiver from ZOCalibrate, called when calibration is finished
-(void)calibrationCompleted:(NSNotification *)aNotification
{
	int i;
	NSArray * calArray;
		
	calArray = [aNotification object];
		
	[imageView setCalPoints:calArray];
		
	for (i=0;i<[transformClassesArray count];i++)
	{
		[[transformClassesArray objectAtIndex:i] setCalibrationArray:calArray];
		
	}
	
	// View in GUI
	[calibrateButton setEnabled:YES];
	for (i=0;i<4;i++)
	{
		[[calLabelsArray objectAtIndex:i] setStringValue:
		 [NSString stringWithFormat:@"%.3d,%.3d",
		  (int)([[calArray objectAtIndex:i] x]*size.width),
		  (int)([[calArray objectAtIndex:i] y]*size.height)]];
	}
	
	calInProgress=NO;

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
	if (!running) {
		running=YES;
		[sender setTitle:@"Pause"];
		NSLog(@"Running!");
	} else {
		running=NO;
		[sender setTitle:@"Run"];
		NSLog(@"Paused!");
	}
}

//Choosing classes
-(IBAction)viewChooseChanged:(id)sender
{
	int lastIndex;
	int newIndex;
	int i;
	
	lastIndex = [viewChooseButton indexOfItem:[viewChooseButton lastItem]];
	newIndex = [viewChooseButton indexOfSelectedItem];
	for (i=0;i<=lastIndex;i++)
	{
		if (i!=newIndex)
		{
			[[viewClassesArray objectAtIndex:i] leftFullscreen];
		}
	}
	[[viewClassesArray objectAtIndex:newIndex] goFullscreen];
	NSLog(@"Fullscreen view changed to index %d",newIndex);

}

-(IBAction)procSettingsClicked:(id)sender
{
	[[NSNotificationCenter defaultCenter] 
	 postNotificationName: @"Show process settings" 
	 object: [procClassesArray objectAtIndex:
			  [procChooseButton indexOfSelectedItem]]];
	
}
-(IBAction)transformSettingsClicked:(id)sender
{
}
-(IBAction)viewSettingsClicked:(id)sender
{
	[[viewClassesArray objectAtIndex:
	  [viewChooseButton indexOfSelectedItem]]
	 showSettingsWindow];
}

@end

