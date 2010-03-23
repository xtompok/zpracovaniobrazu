//
//  WindowController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 21.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//

#define STDOUTPRINT if([printToStdButton state]==NSOnState)

#import "ZOTransform.h"
#import "ZO2PointTransform.h"
#import "ZOPoint.h"
#import "ZOImageView.h"
#import "ZOProjectorView.h"
#import "ZOCalibrate.h"
#import "ZOProcessImage.h"

#import "WindowController.h"

#import <CocoaSequenceGrabber/CocoaSequenceGrabber.h>
#import "ConfigController.h"


@implementation WindowController

// Init and dealloc

- (void)dealloc;
{
	[camera release];
	
	[super dealloc];
}

- (void)awakeFromNib;
{
	size=NSMakeSize(320, 240);
	
	delka=size.width*size.height*4;
	
	// Start recording
	camera = [[CSGCamera alloc] init];
	[camera setDelegate:self];
	[camera startWithSize:size];
	
	
	// Make sure we don't distort the video as the user resizes the window
	NSWindow *window = [self window];
	/*[[window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
	[[window standardWindowButton:NSWindowZoomButton] setHidden:YES];
	[[window standardWindowButton:NSWindowCloseButton] setHidden:YES];
	NSColor*	translucent = [NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0.6] ;
	[window setBackgroundColor:translucent];*/
	[window setAspectRatio:[window frame].size];
	
	urCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(1, 1)];
	ulCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(1, 1)];
	lrCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(1, 1)];
	llCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(1, 1)];
	
	
	calLabelsArray = [[NSArray alloc] initWithObjects:
					  (NSTextField *) ulLabel,
					  (NSTextField *) urLabel,
					  (NSTextField *) lrLabel,
					  (NSTextField *) llLabel,nil];
	
	calPointsArray = [[NSArray alloc] initWithObjects:
					  (ZOPoint *) ulCalPoint,
					  (ZOPoint *) urCalPoint,
					  (ZOPoint *) lrCalPoint,
					  (ZOPoint *) llCalPoint,
					  nil];
	
	int windowLevel;
	NSRect screeenRect;
	NSScreen *aScreen;
	
	STDOUTPRINT NSLog(@"screens: %i",[[NSScreen screens]count]);
	
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
		[projPanel setFrame:screeenRect display: YES];
		[projWindow setContentView:[projPanel contentView]];
	}	
	
	minColorValue.r=245;
	maxColorValue.r=255;
	minColorValue.g=200;
	maxColorValue.g=255;
	minColorValue.b=200;
	maxColorValue.b=255;
	
	running=YES;
	
	// Show the window
	[self showWindow:nil];
	
	NSArray * firstCalArray;
	ZOPoint *p1=[[ZOPoint alloc] initWithPoint:NSMakePoint(0.1, 0.1)];
	ZOPoint *p2=[[ZOPoint alloc] initWithPoint:NSMakePoint(0.9, 0)];
	ZOPoint *p3=[[ZOPoint alloc] initWithPoint:NSMakePoint(1, 1)];
	ZOPoint *p4=[[ZOPoint alloc] initWithPoint:NSMakePoint(0, 0.9)];
	firstCalArray=[[NSArray alloc] initWithObjects:
				   (ZOPoint *) p1,
				   (ZOPoint *) p2,
				   (ZOPoint *) p3,
				   (ZOPoint *) p4,
				   nil];
	transform2Object = [[ZO2PointTransform alloc] initWithCalibrationArray:firstCalArray];
	
	procImage = [[ZOProcessImage alloc] initWithSize:size];
	calObject = [[ZOCalibrate alloc] initWithProjectorView:projView andSize:size];
	
	[[NSNotificationCenter defaultCenter]  addObserver:self
											  selector:@selector(calibrationCompleted:)
												  name:@"Calibration OK"
												object:nil];
}


// CSGCamera delegate

- (void)camera:(CSGCamera *)aCamera didReceiveFrame:(CSGImage *)aFrame;
{
	lastImage=aFrame;
	
	if (!running) return;
	
	//outPoint=[self getLightestPointFromImage:lastImage];
	outPoint=[procImage getLightestPointFromImage:lastImage];
	
	
	[imageView setAnImage:lastImage];
	//if (calInProgress) {
			[calObject setLastImage:lastImage];
	//}
	
	[imageView setPoint:outPoint];
	[imageView setNeedsDisplay:YES];
	
	NSPoint transPoint;
	
	//[projView setPoint1:outPoint];
	//transPoint=[transform2Object transformPoint:NSMakePoint(outPoint.x*320, outPoint.y*240)];
	transPoint=[transform2Object transformPoint:outPoint];
	[projView setPoint1:transPoint];
	[projView setNeedsDisplay:YES];
	
			
	STDOUTPRINT printf("x=%f, y=%f\n",outPoint.x,outPoint.y);
	
	//transPoint=[transformObject transformPoint:outPoint];

	STDOUTPRINT printf("xt=%f, yt=%f",transPoint.x,transPoint.y);
}

// NSWindow delegate

- (void)windowWillClose:(NSNotification *)notification;
{
	[projWindow orderOut:self];
	[camera stop];
}

/* GUI Interactivity */
/* ----------------- */

// Calibrates after click
-(IBAction)Calibrate:(id)sender
{	
	calInProgress=YES;
	[calibrateButton setEnabled:NO];
	[calObject calibrate];
	
	NSLog(@"Calibrate!");	
}
-(void)calibrationCompleted:(NSNotification *)aNotification
{
	int i;
	NSArray * calArray;
	calArray = [aNotification object];
	[imageView setCalPoints:calArray];
	transform2Object = [[ZO2PointTransform alloc] initWithCalibrationArray:calArray];
	transformObject = [[ZOTransform alloc] initWithCalibrationArray:calArray];
	[calibrateButton setEnabled:YES];
	calInProgress=NO;
	for (i=0;i<4;i++)
	{
		[[calLabelsArray objectAtIndex:i] setStringValue:
		[NSString stringWithFormat:@"%.3d,%.3d",
		  (int)([[calArray objectAtIndex:i] xValue]*size.width),
		  (int)([[calArray objectAtIndex:i] yValue]*size.height)]];
	}
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

//Configuration
-(IBAction)sumSquareSliderMoved:(id)sender
{
	NSLog(@"%@",sender);
	if ([minTogetherButton state]==NSOffState) 
	{
		if (sender==rMinSlider) 
		{	
			[rMinLabel setIntValue:[rMinSlider intValue]];
		} 
		else if (sender==gMinSlider)
		{
			[gMinLabel setIntValue:[gMinSlider intValue]];
		} 
		else if (sender==bMinSlider) 
		{
			[bMinLabel setIntValue:[bMinSlider intValue]];
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
	}
}

@end

