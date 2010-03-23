//
//  ZOCalibrate.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 23.3.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOCalibrate.h"


@implementation ZOCalibrate

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
-(NSArray *)someCalibrationArray
{
	return calPointsArray;
}

-(void)calibrate
{
	calTimer = [NSTimer scheduledTimerWithTimeInterval: 2
												target: self
											  selector: @selector(handleCalTimer:)
											  userInfo: nil
											   repeats: NO];
	
}
-(void)setLastImage:(NSImage *)anImage
{
	lastImage=anImage;
}

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
	
} // handleTimer

-(void)handleBlankTimer:(NSTimer *)aTimer
{
	NSPoint outPoint;
	outPoint=[procImage getLightestPointFromImage:lastImage];
	
	//Correction that calibration points aren't in corners
	outPoint.x+=0/size.width;
	outPoint.y-=2/size.height;
	
	[[calPointsArray objectAtIndex:calPointsArrayIndex] setPoint:outPoint];
	
	calPointsArrayIndex++;
	
	[projView setCalPoint:0];
	[projView setNeedsDisplay:YES];
	
	if (calPointsArrayIndex>3) 
	{
		calPointsArrayIndex=0;
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Calibration OK" object:calPointsArray];

		
		//return calPointsArray;
	}
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
