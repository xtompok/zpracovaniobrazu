//
//  ZOPoint.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 5.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOPoint.h"


@implementation ZOPoint

// Initialize with NSPoint
-(id)initWithPoint:(NSPoint)aPoint
{
	if ((self = [super init]) == nil) {
		printf("Error in init\n");
		return self;
	}
	
	point.x=aPoint.x;
	point.y=aPoint.y;
	
	return self;
}

// Returns x coordinate of ZOPoint
-(double)xValue
{
	return point.x;
}

// Returns y coordinate of ZOPoint
-(double)yValue;
{
	return point.y;
}

// Returns NSPoint of ZOPoint
-(NSPoint)pointValue;
{
	return point;

}

// Sets NSPoint
-(void)setPoint:(NSPoint)aPoint;
{
	point.x=aPoint.x;
	point.y=aPoint.y;
}

// Sets x coordinate of ZOPoint
-(void)setX:(double)theX;
{
	point.x=theX;
}

// Sets y coordinate of ZOPoint
-(void)setY:(double)theY;
{
	point.y=theY;
}


@end
