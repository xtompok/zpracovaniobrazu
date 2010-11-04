//
//  ZOQuadTransform.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 25.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
#import "ZOQuadTransform.h"


@implementation ZOQuadTransform

-(id)initWithCalibrationArray:(NSArray *)calArray
{
	if (![super init])
		return nil;
	[self setCalibrationArray:calArray];

	NSLog(@"Quad transformation initialized");

	return self;

}

-(void)setCalibrationArray:(NSArray *)calArray
{
	float x1, x2, x3, x4;
	float y1, y2, y3, y4;
	float a0, a1, a2, a3, a4, a5, a6, a7;
	
	x1=[[calArray objectAtIndex:0] x];
	y1=[[calArray objectAtIndex:0] y];
	
	x2 = [[calArray objectAtIndex:1] x];
	y2 = [[calArray objectAtIndex:1] y];
	
	x3 = [[calArray objectAtIndex:3] x];
	y3 = [[calArray objectAtIndex:3] y];
	
	x4 = [[calArray objectAtIndex:2] x];
	y4 = [[calArray objectAtIndex:2] y];
	
	a0 = (x1 *(x4 *(-y2 + y3) + x3 *(y2 - y4)) + x2 *(x4 *(y1 - y3) + x3 *(-y1 + y4)))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	a1 = (x4 *(x3 *(-y1 + y2) + x1 *(-y2 + y3)) + x2 *(x3 *(y1 - y4) + x1 *(-y3 + y4)))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	a2 = x1;
	a3 = (x4 *(y1 - y2) *y3 + x1 *y2 *(y3 - y4) + x3 *(-y1 + y2)* y4 + x2* y1* (-y3 + y4))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	a4 = (x4 *y2 *(-y1 + y3) + x3 *y1 *(y2 - y4) + x2 *(y1 - y3)* y4 + x1* y3* (-y2 + y4))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	a5 = y1;
	a6 = (-(x3 - x4)* (y1 - y2) + (x1 - x2) *(y3 - y4))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	a7 = ((x2 - x4) *(y1 - y3) - (x1 - x3) *(y2 - y4))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	
	m0= (a4 - a5*a7)/(-(a1*a3) + a0*a4 - a2*a4*a6 + a1*a5*a6 + a2*a3*a7 - a0*a5*a7);
	m1= (a1 - a2*a7)/(a1*a3 - a0*a4 + a2*a4*a6 - a1*a5*a6 - a2*a3*a7 + a0*a5*a7);
	m2= (a2*a4 - a1*a5)/(a1*a3 - a0*a4 + a2*a4*a6 - a1*a5*a6 - a2*a3*a7 + a0*a5*a7);
	m3= (a3 - a5*a6)/(a1*a3 - a0*a4 + a2*a4*a6 - a1*a5*a6 - a2*a3*a7 + a0*a5*a7);
	m4= (a0 - a2*a6)/(-(a1*a3) + a0*a4 - a2*a4*a6 + a1*a5*a6 + a2*a3*a7 - a0*a5*a7);
	m5= (a2*a3 - a0*a5)/(-(a1*a3) + a0*a4 - a2*a4*a6 + a1*a5*a6 + a2*a3*a7 - a0*a5*a7);
	m6= (a4*a6 - a3*a7)/(a1*a3 - a0*a4 + a2*a4*a6 - a1*a5*a6 - a2*a3*a7 + a0*a5*a7);
	m7= (a1*a6 - a0*a7)/(-(a1*a3) + a0*a4 - a2*a4*a6 + a1*a5*a6 + a2*a3*a7 - a0*a5*a7);
	m8= (a1*a3 - a0*a4)/(a1*a3 - a0*a4 + a2*a4*a6 - a1*a5*a6 - a2*a3*a7 + a0*a5*a7);
	
	
		
	NSLog(@"New Quad transformation initialized");

}


-(NSPoint)transformPoint:(NSPoint)point
{
	if ((point.x==0)||(point.y==0)) {
		return NSMakePoint(0, 0);
	}
	
	float x;
	float y;
	
	x=point.x;
	y=point.y;
	
	NSPoint aPoint;
    aPoint.x = (m0*x+m1*y+m2)/(m6*x+m7*y+m8);
	aPoint.y = (m3*x+m4*y+m5)/(m6*x+m7*y+m8);
	return aPoint;
}

@end
