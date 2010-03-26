//
//  ZOPoint.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 5.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOPoint.h"


@implementation ZOPoint

@synthesize x;
@synthesize y;

// Initialize with NSPoint
-(id)initWithPoint:(NSPoint)aPoint
{
	if ((self = [super init]) == nil) {
		printf("Error in init\n");
		return self;
	}
	
	x=aPoint.x;
	y=aPoint.y;
	
	return self;
}

// Sets NSPoint
-(void)setPoint:(NSPoint)aPoint;
{
	x=aPoint.x;
	y=aPoint.y;
}

// Returns NSPoint of ZOPoint
-(NSPoint)pointValue;
{
	return NSMakePoint(x, y);
	
}

@end
