//
//  ZOCalibrationData.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 14.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOCalibrationData.h"


@implementation ZOCalibrationData
@synthesize maxR;
@synthesize maxG;
@synthesize maxB;

-(id)initWithCalArray:(NSArray *) anArray 
			   maxRed:(int) aRed 
				Green:(int) aGreen 
			  andBlue:(int) aBlue
{
	if (![super init])
		return nil;
	
	maxR = aRed;
	maxG = aGreen;
	maxB = aBlue;
	
	calPointsArray = [[NSArray alloc] initWithArray:anArray];

	NSLog(@"Calibration data initialized");
	
	return self;

}
-(NSArray *)calPointsArray
{
	return calPointsArray;
}

@end
