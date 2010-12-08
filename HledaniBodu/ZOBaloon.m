//
//  ZOBaloon.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOBaloon.h"

@implementation ZOBaloon

@synthesize shots;
@synthesize color;


-(id)initWithOrigin:(NSPoint) anOrigin 
			 Radius:(float) aRadius 
			  Speed:(float)aSpeed
		   andColor:(NSColor *)aColor
{
	if (![super init])
		return nil;
	origin.x = anOrigin.x;
	origin.y = anOrigin.y;
	
	speed = aSpeed;
	radius = aRadius;
	
	color = aColor;
	
	float delta;
	delta = 0.01*radius;
	shape = [[NSBezierPath alloc] init];
	[shape appendBezierPathWithOvalInRect:NSMakeRect(0,0, 2*radius, 3*radius)];
	[shape moveToPoint:NSMakePoint(radius, 3*radius-delta)];
	[shape curveToPoint:NSMakePoint(radius, 4*radius-delta) 
		  controlPoint1:NSMakePoint(1.2*radius, 3.5*radius) 
		  controlPoint2:NSMakePoint(1.2*radius, 3.5*radius)];
	[shape curveToPoint:NSMakePoint(radius, 5*radius-delta) 
		  controlPoint1:NSMakePoint(0.8*radius, 4.5*radius) 
		  controlPoint2:NSMakePoint(0.8*radius, 4.5*radius)];
	[shape curveToPoint:NSMakePoint(radius, 4*radius+delta) 
		  controlPoint1:NSMakePoint(0.8*radius, 4.5*radius) 
		  controlPoint2:NSMakePoint(0.8*radius, 4.5*radius)];
	[shape curveToPoint:NSMakePoint(radius, 3*radius+delta) 
		  controlPoint1:NSMakePoint(1.2*radius, 3.5*radius) 
		  controlPoint2:NSMakePoint(1.2*radius, 3.5*radius)];
	return self;
	
}

-(void)move
{
	origin.y-=speed;
}

-(NSBezierPath *)balloonPath
{

	NSAffineTransform * shift;
	shift = [NSAffineTransform transform];
	[shift translateXBy:origin.x yBy:origin.y];
	return [shift transformBezierPath:shape];
}
-(void)shooted
{
	shots++;
}
@end
