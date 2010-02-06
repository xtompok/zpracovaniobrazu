//
//  ZOPoint.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 5.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOPoint.h"


@implementation ZOPoint

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

-(double)xValue
{
	return point.x;
}
-(double)yValue;
{
	return point.y;
}
-(NSPoint)pointValue;
{
	return point;

}
-(void)setPoint:(NSPoint)aPoint;
{
	point.x=aPoint.x;
	point.y=aPoint.y;
}
-(void)setX:(double)theX;
{
	point.x=theX;
}
-(void)setY:(double)theY;
{
	point.y=theY;
}


@end
