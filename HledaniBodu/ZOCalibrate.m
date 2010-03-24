//
//  ZOCalibrate.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 23.3.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOCalibrate.h"


@implementation ZOCalibrate

//Initialize calPointsArray, sets projector view and camera size
-(id)initWithProjectorView:(ZOProjectorView *) aView andSize:(NSSize)aSize
{
	if (![super init])
		return nil;
	
	projView=aView;
	procImage = [[ZOProcessImage alloc]initWithSize:aSize];
	size=aSize;
	
	ulCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(0, 0)];
	llCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(0, 0)];
	urCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(0, 0)];
	lrCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(0, 0)];
	
	
	calPointsArray = [[NSArray alloc] initWithObjects:
					  (ZOPoint *) ulCalPoint,
					  (ZOPoint *) urCalPoint,
					  (ZOPoint *) lrCalPoint,
					  (ZOPoint *) llCalPoint,
					  nil];
	
	return self;
}

// Returns actual calPointsArray, for initialization transformations.
-(NSArray *)someCalibrationArray
{
	return calPointsArray;
}

//Begins calibration
-(void)calibrate
{
	calTimer = [NSTimer scheduledTimerWithTimeInterval: 2
												target: self
											  selector: @selector(handleCalTimer:)
											  userInfo: nil
											   repeats: NO];
	
}

// Gets image from WindowController
-(void)setLastImage:(NSImage *)anImage
{
	lastImage=anImage;
}

// Handles end of blank, set new calibration point
- (void) handleCalTimer: (NSTimer *) aTimer
{
	printf("Timer has expired\n");
	
	[projView setCalPoint:(calPointsArrayIndex+1)];
	[projView setNeedsDisplay:YES];
	
	calTimer = [NSTimer scheduledTimerWithTimeInterval: 2
												target: self
											  selector: @selector(handleBlankTimer:)
											  userInfo: nil
											   repeats: NO];
	
}

// Hnadles end of viewing calibration point, 
// gets its coordinates and saves it into calPointsArray
-(void)handleBlankTimer:(NSTimer *)aTimer
{
	NSPoint outPoint;
	outPoint=[procImage getLightestPointFromImage:lastImage];
	
	//Correction that calibration points aren't in corners
	outPoint.x+=0/size.width;
	outPoint.y-=2/size.height;
	
	[[calPointsArray objectAtIndex:calPointsArrayIndex] setPoint:outPoint];
	
	calPointsArrayIndex++;
	
	// Set blank
	[projView setCalPoint:0];
	[projView setNeedsDisplay:YES];
	
	// If calibration is complete, sends notification to WindowController
	if (calPointsArrayIndex>3) 
	{
		calPointsArrayIndex=0;
		
		[[NSNotificationCenter defaultCenter] 
			postNotificationName: @"Calibration OK" 
						  object: calPointsArray];

	}
	// Else sets blank timer
	else 
	{
		calTimer = [NSTimer scheduledTimerWithTimeInterval: 3
													target: self
												  selector: @selector(handleCalTimer:)
												  userInfo: nil
												   repeats: NO];
	}
	
}


@end
