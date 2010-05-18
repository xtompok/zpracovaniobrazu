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
	int windowLevel;
	NSRect screeenRect;
	NSScreen *aScreen;
	
	STDOUTPRINT NSLog(@"screens: %i",[[NSScreen screens]count]);
	
	// Go fullscreen
	if ([[NSScreen screens]count]>1)
	{
		aScreen = [[NSScreen screens] objectAtIndex:1];
		windowLevel = CGShieldingWindowLevel();
		screeenRect = [aScreen frame];
		
		projWindow = [[NSWindow alloc] initWithContentRect:screeenRect
												 styleMask:NSBorderlessWindowMask
												   backing:NSBackingStoreBuffered
													 defer:NO screen: [NSScreen mainScreen]];
		[projWindow setLevel:windowLevel];
		[projWindow setBackgroundColor:[NSColor blueColor]];
		[projWindow makeKeyAndOrderFront:nil];
		
		// Load our content view
//		[projPanel setFrame:screeenRect display: YES];
//		[projWindow setContentView:[projPanel contentView]];
		
		[drawPanel setFrame:screeenRect display: YES];
		[projWindow setContentView:[drawPanel contentView]];

	
	}	
	
	/*Initialization own classes*/
	/*--------------------------*/
	
	// Init image processing object
	procImage = [[ZOProcessImage alloc] initWithSize:size];
	[self initSliders];
	
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
		
	NSPoint transPoint, outPoint;
	
	if (!running) return;
	
	outPoint = [procImage getLightestPointFromImage:lastImage];
	
	if (calInProgress) {
		[calController setPoint:outPoint];
	}
	
	[imageView setAnImage:lastImage];
	[imageView setPoint:outPoint];
	[imageView setNeedsDisplay:YES];
	
	transPoint = [transform2Object transformPoint:outPoint];
	
	//[projView setPoint1:transPoint];
	//[projView setNeedsDisplay:YES];
	[drawView setPoint1:transPoint];
	[drawView setNeedsDisplay:YES];
	
	[maxSumSquareLabel setStringValue:
	 [NSString stringWithFormat:@"%d,%d,%d",
	  [procImage maxR],
	  [procImage maxG],
	  [procImage maxB]]];
	
			
	STDOUTPRINT printf("x=%f, y=%f\n",outPoint.x,outPoint.y);
	
	//transPoint=[transformObject transformPoint:outPoint];

	STDOUTPRINT printf("xt=%f, yt=%f",transPoint.x,transPoint.y);
}

// Cleanup before end
- (void)windowWillClose:(NSNotification *)notification;
{
	[projWindow orderOut:self];
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

// Resets drawing
-(IBAction)resetDrawing:(id)sender
{
	[drawView resetDrawing];
}

//Configuration
-(void)initSliders
{
	int minR, minG,minB,maxR,maxG,maxB;
	minR = 100;
	minG = 100;
	minB = 100;
	maxR = 255;
	maxG = 255;
	maxB = 255;
	
	// Setting min values
	[rMinSlider setIntValue:minR];
	[rMinLabel  setIntValue:minR];
	[procImage setMinRValue:minR];
	
	[gMinSlider setIntValue:minG];
	[gMinLabel  setIntValue:minG];
	[procImage setMinGValue:minG];
	
	[bMinSlider setIntValue:minB];
	[bMinLabel  setIntValue:minB];
	[procImage setMinBValue:minB];
	
	// Setting max values	
	[rMaxSlider setIntValue:maxR];
	[rMaxLabel  setIntValue:maxR];
	[procImage setMaxRValue:maxR];
	
	[gMaxSlider setIntValue:maxG];
	[gMaxLabel  setIntValue:maxG];
	[procImage setMaxGValue:maxG];
	
	[bMaxSlider setIntValue:maxB];
	[bMaxLabel  setIntValue:maxB];
	[procImage setMaxBValue:maxB];
}

-(IBAction)minSliderMoved:(id)sender
{
	
	if ([minTogetherButton state]==NSOffState) 
	{
		if (sender==rMinSlider) 
		{	
			[rMinLabel setIntValue:[rMinSlider intValue]];
			[procImage setMinRValue:[rMinSlider intValue]];
		} 
		else if (sender==gMinSlider)
		{
			[gMinLabel setIntValue:[gMinSlider intValue]];
			[procImage setMinGValue:[gMinSlider intValue]];
		} 
		else if (sender==bMinSlider) 
		{
			[bMinLabel setIntValue:[bMinSlider intValue]];
			[procImage setMinBValue:[bMinSlider intValue]];
		}
		
	} else {
		if (sender==rMinSlider) 
		{
			[gMinSlider setIntValue:[rMinSlider intValue]];
			[bMinSlider setIntValue:[rMinSlider intValue]];
			
			[rMinLabel setIntValue:[rMinSlider intValue]];
			[gMinLabel setIntValue:[rMinSlider intValue]];
			[bMinLabel setIntValue:[rMinSlider intValue]];
		} 
		else if (sender==gMinSlider)
		{
			[rMinSlider setIntValue:[gMinSlider intValue]];
			[bMinSlider setIntValue:[gMinSlider intValue]];
			
			[rMinLabel setIntValue:[gMinSlider intValue]];
			[gMinLabel setIntValue:[gMinSlider intValue]];
			[bMinLabel setIntValue:[gMinSlider intValue]];
		} 
		else if (sender==bMinSlider) 
		{
			[rMinSlider setIntValue:[bMinSlider intValue]];
			[gMinSlider setIntValue:[bMinSlider intValue]];
			
			[rMinLabel setIntValue:[bMinSlider intValue]];
			[gMinLabel setIntValue:[bMinSlider intValue]];
			[bMinLabel setIntValue:[bMinSlider intValue]];
		}
		[procImage setMinRValue:[rMinSlider intValue]];
		[procImage setMinGValue:[gMinSlider intValue]];
		[procImage setMinBValue:[bMinSlider intValue]];
	}
}

-(IBAction)maxSliderMoved:(id)sender
{	
	if ([maxTogetherButton state]==NSOffState) 
	{
		if (sender==rMaxSlider) 
		{	
			[rMaxLabel setIntValue:[rMaxSlider intValue]];
			[procImage setMaxRValue:[rMaxSlider intValue]];
		} 
		else if (sender==gMaxSlider)
		{
			[gMaxLabel setIntValue:[gMaxSlider intValue]];
			[procImage setMaxGValue:[gMaxSlider intValue]];
		} 
		else if (sender==bMaxSlider) 
		{
			[bMaxLabel setIntValue:[bMaxSlider intValue]];
			[procImage setMaxBValue:[bMaxSlider intValue]];
		}
		
	} else {
		if (sender==rMaxSlider) 
		{
			[gMaxSlider setIntValue:[rMaxSlider intValue]];
			[bMaxSlider setIntValue:[rMaxSlider intValue]];
			
			[rMaxLabel setIntValue:[rMaxSlider intValue]];
			[gMaxLabel setIntValue:[rMaxSlider intValue]];
			[bMaxLabel setIntValue:[rMaxSlider intValue]];
		} 
		else if (sender==gMaxSlider)
		{
			[rMaxSlider setIntValue:[gMaxSlider intValue]];
			[bMaxSlider setIntValue:[gMaxSlider intValue]];
			
			[rMaxLabel setIntValue:[gMaxSlider intValue]];
			[gMaxLabel setIntValue:[gMaxSlider intValue]];
			[bMaxLabel setIntValue:[gMaxSlider intValue]];
		} 
		else if (sender==bMaxSlider) 
		{
			[rMaxSlider setIntValue:[bMaxSlider intValue]];
			[gMaxSlider setIntValue:[bMaxSlider intValue]];
			
			[rMaxLabel setIntValue:[bMaxSlider intValue]];
			[gMaxLabel setIntValue:[bMaxSlider intValue]];
			[bMaxLabel setIntValue:[bMaxSlider intValue]];
		}
		[procImage setMaxRValue:[rMaxSlider intValue]];
		[procImage setMaxGValue:[gMaxSlider intValue]];
		[procImage setMaxBValue:[bMaxSlider intValue]];
	}
}

-(IBAction)sumSquareSliderMoved:(id)sender
{
	NSLog(@"%@",sender);
	if ([minTogetherSumButton state]==NSOffState) 
	{
		if (sender==rMinSumSlider) 
		{	
			[rMinSumLabel setIntValue:[rMinSumSlider intValue]];
			[procImage setMinRSumValue:[rMinSumSlider intValue]];
		} 
		else if (sender==gMinSumSlider)
		{
			[gMinSumLabel setIntValue:[gMinSumSlider intValue]];
			[procImage setMinGSumValue:[gMinSumSlider intValue]];
		} 
		else if (sender==bMinSumSlider) 
		{
			[bMinSumLabel setIntValue:[bMinSumSlider intValue]];
			[procImage setMinBSumValue:[bMinSumSlider intValue]];
		}
		
	} else {
		if (sender==rMinSumSlider) 
		{
			[gMinSumSlider setIntValue:[rMinSumSlider intValue]];
			[bMinSumSlider setIntValue:[rMinSumSlider intValue]];
			
			[rMinSumLabel setIntValue:[rMinSumSlider intValue]];
			[gMinSumLabel setIntValue:[rMinSumSlider intValue]];
			[bMinSumLabel setIntValue:[rMinSumSlider intValue]];
		} 
		else if (sender==gMinSumSlider)
		{
			[rMinSumSlider setIntValue:[gMinSumSlider intValue]];
			[bMinSumSlider setIntValue:[gMinSumSlider intValue]];
			
			[rMinSumLabel setIntValue:[gMinSumSlider intValue]];
			[gMinSumLabel setIntValue:[gMinSumSlider intValue]];
			[bMinSumLabel setIntValue:[gMinSumSlider intValue]];
		} 
		else if (sender==bMinSumSlider) 
		{
			[rMinSumSlider setIntValue:[bMinSumSlider intValue]];
			[gMinSumSlider setIntValue:[bMinSumSlider intValue]];
			
			[rMinSumLabel setIntValue:[bMinSumSlider intValue]];
			[gMinSumLabel setIntValue:[bMinSumSlider intValue]];
			[bMinSumLabel setIntValue:[bMinSumSlider intValue]];
		}
		[procImage setMinRSumValue:[rMinSumSlider intValue]];
		[procImage setMinGSumValue:[gMinSumSlider intValue]];
		[procImage setMinBSumValue:[bMinSumSlider intValue]];
	}
}

@end

