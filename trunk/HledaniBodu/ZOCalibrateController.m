//
//  ZOCalibrateController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOCalibrateController.h"


@implementation ZOCalibrateController

@synthesize point;

-(id)init
{
	if (![super init])
		return nil;
	
	ulCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(0.01, 0.01)];
	llCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(1, 0)];
	urCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(0,1)];
	lrCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(0.99, 0.99)];
	
	
	calPointsArray = [[NSArray alloc] initWithObjects:
					  (ZOPoint *) ulCalPoint,
					  (ZOPoint *) urCalPoint,
					  (ZOPoint *) lrCalPoint,
					  (ZOPoint *) llCalPoint,
					  nil];
	
	[urCalPoint retain];
	[ulCalPoint retain];
	[llCalPoint retain];
	[lrCalPoint retain];
	[calPointsArray retain];
	
	calPointsArrayIndex=0;	
	
	calTime=2;
	
	NSLog(@"Calibration controller initialized");
	
	return self;
}

//Initialize calPointsArray, sets projector view and camera size
-(void)setSize:(NSSize)aSize;
{
	size.width = aSize.width;
	size.height = aSize.height;
	
}

// Returns actual calPointsArray, for initialization transformations.
-(NSArray *)calibrationArray
{
	return calPointsArray;
}

-(ZOCalibrationData *)calibrationData;
{
	return calData;
}

//Begins calibration
-(void)calibrate
{
	// Go fullscreen
	if ([[NSScreen screens]count]>1)
	{
		// Initialization of projector view
		int windowLevel;
		NSRect screeenRect;
		NSScreen *aScreen;
		
		aScreen = [[NSScreen screens] objectAtIndex:1];
		windowLevel = CGShieldingWindowLevel();
		screeenRect = [aScreen frame];
		
		calWindow = [[NSWindow alloc] initWithContentRect:screeenRect
												styleMask:NSBorderlessWindowMask
												  backing:NSBackingStoreBuffered
													defer:NO screen: [NSScreen mainScreen]];
		[calWindow setLevel:windowLevel];
		[calWindow setBackgroundColor:[NSColor blueColor]];
		[calWindow makeKeyAndOrderFront:nil];
		
		// Load our content view
		
		[calPanel setFrame:screeenRect display: YES];
		[calWindow setContentView:[calPanel contentView]];
		
		
	}	
	
	
	calTimer = [NSTimer scheduledTimerWithTimeInterval: calTime
												target: self
											  selector: @selector(handleBlankTimer:)
											  userInfo: nil
											   repeats: NO];
	
}

// Handles end of blank, set new calibration point
- (void) handleBlankTimer: (NSTimer *) aTimer
{
	[calView setCalPoint:calPointsArrayIndex];
	[calView setNeedsDisplay:YES];
	
	calTimer = [NSTimer scheduledTimerWithTimeInterval: calTime
												target: self
											  selector: @selector(handleCalTimer:)
											  userInfo: nil
											   repeats: NO];
	
}

// Handles end of viewing calibration point, 
// gets its coordinates and saves it into calPointsArray
-(void)handleCalTimer:(NSTimer *)aTimer
{
	//outPoint=[procImage getLightestPointFromImage:lastImage];
	NSLog(@"X: %f, Y: %f",point.x,point.y);
	
	//Correction that calibration points aren't in corners
	point.x+=0/size.width;
	point.y-=0/size.height;
	
	
	[[calPointsArray objectAtIndex:calPointsArrayIndex] setPoint:point];
	
	calPointsArrayIndex++;
	
	// Set blank
	[calView setCalPoint:-1];
	[calView setNeedsDisplay:YES];
	
	// If calibration is complete, sends notification to WindowController
	if (calPointsArrayIndex>3) 
	{
		
		calPointsArrayIndex=0;
		
		calData = [[ZOCalibrationData alloc] initWithCalArray:calPointsArray 
													   maxRed:maxRed 
														Green:maxGreen 
													  andBlue:maxBlue];
		[[NSNotificationCenter defaultCenter] 
		 postNotificationName: @"Calibration OK" 
		 object: calPointsArray];
		
		[calWindow orderOut:self];
		
	}
	// Else sets blank timer
	else 
	{
		calTimer = [NSTimer scheduledTimerWithTimeInterval: calTime
													target: self
												  selector: @selector(handleBlankTimer:)
												  userInfo: nil
												   repeats: NO];
	}
	
}


-(NSString *)description
{
	NSString *result; 
	result = [[NSString alloc] initWithFormat:@"Upper left: %@\nUpper right: %@\nLower right: %@\nLower left: %@\n",
			  ulCalPoint,urCalPoint,lrCalPoint,llCalPoint];
	return result;
}



@end
