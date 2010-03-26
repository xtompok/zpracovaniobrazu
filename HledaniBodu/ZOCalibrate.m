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
-(id)initWithSize:(NSSize)aSize
{
	if (![super init])
		return nil;
	
	ulCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(0.01, 0.01)];
	llCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(0, 1)];
	urCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(0.9, 0.9)];
	lrCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(1, 0)];
	
	
	
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
	
	size.width=aSize.width;
	size.height=aSize.height;
	
	procImage = [[ZOProcessImage alloc]initWithSize:aSize];
	
	calPointsArrayIndex=0;
	
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
	
	[[NSNotificationCenter defaultCenter] 
	 postNotificationName: @"Set calibration point" 
	 object: [NSValue value:&calPointsArrayIndex withObjCType:@encode(int *)]];
	
	calTimer = [NSTimer scheduledTimerWithTimeInterval: 2
												target: self
											  selector: @selector(handleBlankTimer:)
											  userInfo: nil
											   repeats: NO];
	
}

// Handles end of viewing calibration point, 
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
	int i;
	i=-1;
	[[NSNotificationCenter defaultCenter] 
	 postNotificationName: @"Set calibration point" 
	 object: [NSValue value:&i withObjCType:@encode(int *)]];
	
	
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
